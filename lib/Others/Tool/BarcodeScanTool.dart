import 'dart:io';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:mes/Others/Tool/NativeCommunicationTool.dart';

class BarcodeScanTool {
  static Future <String> tryToScanBarcode() async {
    if(Platform.isIOS){
      String barcodeScanRes = await NativeCommunicationTool().tryToScanBarcode();
      return barcodeScanRes;
    } else if (Platform.isAndroid) {
      String barcodeScanRes = await NativeCommunicationTool().tryToScanBarcode();
      return barcodeScanRes;
    }
  }
}