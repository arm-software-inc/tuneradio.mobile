package com.radiao.radiao

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.media.MediaMetadata
import android.os.*
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.MediaMetadataCompat
import android.support.v4.media.session.MediaSessionCompat
import android.support.v4.media.session.PlaybackStateCompat
import android.util.Log
import androidx.media.MediaBrowserServiceCompat

class PlayerService : MediaBrowserServiceCompat() {
    private val TAG = "PlayerService"
    private lateinit var mediaSession: MediaSessionCompat

    private lateinit var notificationManager: PlayerNotificationManager

    private lateinit var playbackStateCompat: PlaybackStateCompat.Builder


    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val extras = intent.extras
        val name = extras?.getString("name") ?: ""
        val tags = extras?.getString("tags") ?: ""
        val cover = extras?.getByteArray("cover") ?: ByteArray(0)
        val isPlaying = extras?.getBoolean("isPlaying") ?: false

        if (name.isEmpty()) {
            updateNotification(isPlaying)
        } else {
            updateNotification(name, tags, cover)
        }

        return super.onStartCommand(intent, flags, startId)
    }

    override fun onCreate() {
        super.onCreate()

        playbackStateCompat = PlaybackStateCompat.Builder()
            .setActions(PlaybackStateCompat.ACTION_PAUSE
                        or PlaybackStateCompat.ACTION_PLAY
                        or PlaybackStateCompat.ACTION_SKIP_TO_PREVIOUS
                        or PlaybackStateCompat.ACTION_SKIP_TO_NEXT)

        mediaSession = MediaSessionCompat(this, "service")
        mediaSession.apply {
            setCallback(callbacks)
            setPlaybackState(playbackStateCompat.build())
        }

        sessionToken = mediaSession.sessionToken

        mediaSession.isActive = true

        notificationManager = PlayerNotificationManager(this)
    }

    override fun onGetRoot(
        clientPackageName: String,
        clientUid: Int,
        rootHints: Bundle?
    ): BrowserRoot? {
        return BrowserRoot("root", null)
    }

    override fun onLoadChildren(
        parentId: String,
        result: Result<MutableList<MediaBrowserCompat.MediaItem>>
    ) {
        result.sendResult(null)
    }

    private fun updateNotification(isPlaying: Boolean) {
        stopForeground(false) // verificar a necessidade de usar este comando

        val notification = notificationManager.getNotification(isPlaying)
        startForeground(notificationManager.NOTIFICATION_ID, notification)
    }

    private fun updateNotification(stationName: String, tags: String, cover: ByteArray) {
        stopForeground(false) //verificar a necessidade de usar este comando

        buildMetadata(stationName, tags)

        val notification = notificationManager.getNotification(stationName, tags, cover)
        startForeground(notificationManager.NOTIFICATION_ID, notification)
    }

    private fun buildMetadata(stationName: String, tags: String) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            mediaSession.setMetadata(
                MediaMetadataCompat.Builder()
                    .putString(MediaMetadata.METADATA_KEY_TITLE, stationName)
                    .putString(MediaMetadata.METADATA_KEY_ARTIST, tags)
                    .build())
        }
    }

    private fun sendActionToBroadcast(action: String) {
        val intent = Intent(action)
        val pendingIntent = PendingIntent.getBroadcast(applicationContext, 0, intent, 0)
        pendingIntent.send()
    }

    val callbacks = object: MediaSessionCompat.Callback() {
        override fun onCommand(command: String?, extras: Bundle?, cb: ResultReceiver?) {
            super.onCommand(command, extras, cb)
        }

        override fun onPlay() {
            super.onPlay()
            Log.i(TAG, "PLAYING")

            sendActionToBroadcast(PlayerBroadcast.ACTION_PLAY)
        }

        override fun onPause() {
            super.onPause()
            Log.i(TAG, "PAUSED")

            sendActionToBroadcast(PlayerBroadcast.ACTION_PAUSE)
        }

        override fun onSkipToNext() {
            super.onSkipToNext()

            Log.i(TAG, "NEXT")
        }

        override fun onSkipToPrevious() {
            super.onSkipToPrevious()

            Log.i(TAG, "PREVIOUS")
        }

        override fun onMediaButtonEvent(mediaButtonEvent: Intent?): Boolean {
            return super.onMediaButtonEvent(mediaButtonEvent)
        }
    }

}