package com.tune_radio.tune_radio

import android.content.*
import android.os.*
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.io.Serializable

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.tune_radio/not"
    private val PLAYER_EVENT_CHANNEL = "playerActions"
    private val TAG = "PLAYER-NOTIFICATION"

    private lateinit var playerBroadcast: PlayerBroadcast

    override fun onDestroy() {
        unregisterReceiver(playerBroadcast)
        stopPlayerService()
        Log.i(TAG, "FlutterActivity DESTROYED!!!")
        super.onDestroy()
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        registerPlayerBroadcast()
        registerEventChannel(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method.equals("notifyStationChange")) {
                val args = call.arguments as ArrayList<*>
                val name = args[0] as String
                val tags = args[1] as String
                val cover = args[2] as ByteArray

                updatePlayerService(name, tags, cover)

                result.success("")
            } else if (call.method.equals("notifyPlayState")) {
                val args = call.arguments as ArrayList<*>
                val playing = args[0] as Boolean

                updatePlayerService(playing)

                result.success("")
            }
        }
    }

    private  fun updatePlayerService(name: String, tags: String, cover: ByteArray) {
        val intent = Intent(this, PlayerService::class.java)
        intent.putExtra("name", name)
        intent.putExtra("tags", tags)
        intent.putExtra("cover", cover)
        startService(intent)
    }

    private  fun updatePlayerService(isPlaying: Boolean) {
        val intent = Intent(this, PlayerService::class.java)
        intent.putExtra("isPlaying", isPlaying)
        startService(intent)
    }

    private fun stopPlayerService() {
        val intent = Intent(this, PlayerService::class.java)
        stopService(intent)
    }

    private fun registerPlayerBroadcast() {
        playerBroadcast = PlayerBroadcast()

        val filter = IntentFilter().apply {
            addAction(PlayerBroadcast.ACTION_PLAY)
            addAction(PlayerBroadcast.ACTION_PAUSE)
            addAction(PlayerBroadcast.ACTION_NEXT)
            addAction(PlayerBroadcast.ACTION_PREV)
            addAction(PlayerBroadcast.ACTION_FAVORITE)
        }

        registerReceiver(playerBroadcast, filter)
        Log.i(TAG, "BROADCAST REGISTRADO")
    }

    private fun registerEventChannel(flutterEngine: FlutterEngine) {
        val eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger,  PLAYER_EVENT_CHANNEL)

        eventChannel.setStreamHandler(object: EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                playerBroadcast.setCallback(object: PlayerBroadcastCallback() {
                    override fun onChange(action: String) {
                        events?.success(action)
                    }
                })
            }

            override fun onCancel(arguments: Any?) {}
        })
    }

}