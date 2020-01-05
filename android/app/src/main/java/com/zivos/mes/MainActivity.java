package com.zivos.mes;

import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import cn.bingoogolapple.qrcode.core.BGAQRCodeUtil;
//import pub.devrel.easypermissions.AfterPermissionGranted;
//import pub.devrel.easypermissions.EasyPermissions;

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
                } else if (call.method.equals("tryToScanBarcode")) {
                    tryToScanBarcode();
                    result.success("HLaskldfasldfjlasdjflassjf");
                } else {
                  result.notImplemented();
                }
              }
            }
    );
  }

  private void tryToScanBarcode() {
      Intent in = new Intent(this, BarcodeScanActivity.class);
      startActivityForResult(in, 100001);
//      startActivity(new Intent(this, BarcodeScanActivity.class));
//      String cc = in.getStringExtra("data");
//      Log.i("TRS", cc);
  }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        String resStr = data.getStringExtra("data").toString();
        Log.i("TRS", "HHHH: " + resStr);
    }
}
