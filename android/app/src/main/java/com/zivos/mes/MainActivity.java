package com.zivos.mes;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "flutterNativeChannel";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, Result result) {
                if (call.method.equals("getBatteryLevel")) {
                    result.success("Jalsdkf");
//                  int batteryLevel = 5;
//
//                  if (batteryLevel != -1) {
//                    result.success(batteryLevel);
//                  } else {
//                    result.error("UNAVAILABLE", "Battery level not available.", null);
//                  }
                } else {
                  result.notImplemented();
                }
              }
            }
    );
  }
}
