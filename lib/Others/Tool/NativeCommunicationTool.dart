import 'package:flutter/services.dart';

class NativeCommunicationTool {
  MethodChannel _platform;

  factory NativeCommunicationTool() => _sharedInfo();

  static NativeCommunicationTool _instance = NativeCommunicationTool._();

  static NativeCommunicationTool _sharedInfo() {
    return _instance;
  }

  NativeCommunicationTool._() {
    _initSomeThings();
  }

  void _initSomeThings() {
    _platform = const MethodChannel('flutterNativeChannel');
    print("_platform: $_platform");    
  }

  Future<String> getBatteryLevel() async { 
      String result = await _platform.invokeMethod('getBatteryLevel');
      print("batteryLevel: $result");
      return result;
    }
}
