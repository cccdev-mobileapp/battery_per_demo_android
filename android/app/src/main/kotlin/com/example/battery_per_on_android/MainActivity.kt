package com.example.battery_per_on_android

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.IntentFilter
import android.os.BatteryManager

class MainActivity : FlutterActivity() {
    //data communication method name
    private val getBatteryPercentageMethod: String = "getBatteryPercentageMethod"
    private val batteryErrorMsg: String = "Failed to get battery percentage!"

    //method channel and default variable initialization
    private val commonMethodChannel: String = "com.example.battery_per_on_android/common_channel"
    private val resultHandlers = mutableMapOf<String, MethodChannel.Result>()
    private lateinit var methodChannel: MethodChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, commonMethodChannel
        )
        methodChannel.setMethodCallHandler { call, result ->
            resultHandlers[commonMethodChannel] = result
            when (call.method) {

                getBatteryPercentageMethod -> {
                    getBatteryPercentage()
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getBatteryPercentage() {
        try {
            val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { filter ->
                applicationContext.registerReceiver(null, filter)
            }
            val level: Int = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
            val scale: Int = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1

            resultHandlers[commonMethodChannel]?.success(mapOf("batteryPercentage" to (level * 100 / scale.toFloat()).toInt()))
            return

        } catch (exception: Exception) {
            resultHandlers[commonMethodChannel]?.error(
                "battery_per_err",
                exception.toString(),
                batteryErrorMsg,
            )
            return
        }
    }

}