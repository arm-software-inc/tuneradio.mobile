package com.radiao.radiao

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.graphics.BitmapFactory
import android.graphics.Color
import android.os.Build
import android.provider.MediaStore
import android.support.v4.media.session.PlaybackStateCompat
import androidx.core.app.NotificationCompat
import androidx.media.session.MediaButtonReceiver

class PlayerNotificationManager(val playerService: PlayerService) {
    val NOTIFICATION_ID = 11234
    val CHANNEL_ID = "CHANNELD"

    private val notification = createNotification()

    private val playAction: NotificationCompat.Action = NotificationCompat.Action(
        android.R.drawable.ic_media_play,
        "PLAY",
        MediaButtonReceiver.buildMediaButtonPendingIntent(playerService, PlaybackStateCompat.ACTION_PLAY)
    )

    private val pauseAction: NotificationCompat.Action = NotificationCompat.Action(
        android.R.drawable.ic_media_pause,
        "PAUSE",
        MediaButtonReceiver.buildMediaButtonPendingIntent(playerService, PlaybackStateCompat.ACTION_PAUSE)
    )

    private val nextAction: NotificationCompat.Action = NotificationCompat.Action(
        android.R.drawable.ic_media_next,
        "NEXT",
        MediaButtonReceiver.buildMediaButtonPendingIntent(playerService, PlaybackStateCompat.ACTION_SKIP_TO_NEXT)
    )

    private val prevAction: NotificationCompat.Action = NotificationCompat.Action(
        android.R.drawable.ic_media_previous,
        "PREV",
        MediaButtonReceiver.buildMediaButtonPendingIntent(playerService, PlaybackStateCompat.ACTION_SKIP_TO_PREVIOUS)
    )

    fun getNotification(stationName: String, tags: String, cover: ByteArray): Notification {
        return notification
            .clearActions()
            .addAction(prevAction)
            .addAction(pauseAction)
            .addAction(nextAction)
            .setContentTitle(stationName)
            .setContentText(tags)
            .setLargeIcon(BitmapFactory.decodeByteArray(cover, 0, cover.size))
            .build()
    }

    fun getNotification(playing: Boolean): Notification {
        return notification
            .clearActions()
            .addAction(prevAction)
            .addAction(if (playing) pauseAction else playAction)
            .addAction(nextAction)
            .build()
    }

    private fun createNotification(): NotificationCompat.Builder {
        createChannel()
        return NotificationCompat.Builder(playerService, CHANNEL_ID)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            .setSmallIcon(R.drawable.ic_play)
            .setStyle(
                androidx.media.app.NotificationCompat.MediaStyle()
                    .setShowActionsInCompactView(0, 1, 2)
                    .setMediaSession(playerService.sessionToken)
            )
            .setOnlyAlertOnce(true)
    }

    private fun createChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "player",
                NotificationManager.IMPORTANCE_LOW
            ).apply { description = "desc" }
            val notificationManager =
                playerService.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

            notificationManager.createNotificationChannel(channel)
        }
    }
}