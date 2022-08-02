package com.tune_radio.tune_radio

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class PlayerBroadcast : BroadcastReceiver() {
    private lateinit var callback: PlayerBroadcastCallback

    fun setCallback(callbackr: PlayerBroadcastCallback) {
        callback = callbackr
    }

    override fun onReceive(p0: Context, p1: Intent?) {
        callback.onChange(p1?.action.toString())
    }

    companion object {
        const val ACTION_PLAY = "com.radio.player.play"
        const val ACTION_PAUSE = "com.radio.player.pause"
        const val ACTION_NEXT = "com.radio.player.next"
        const val ACTION_PREV = "com.radio.player.prev"
        const val ACTION_FAVORITE = "com.radio.player.favorite"
    }
}

abstract class PlayerBroadcastCallback {
    abstract fun onChange(action: String)
}