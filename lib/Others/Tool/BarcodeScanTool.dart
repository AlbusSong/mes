import 'dart:io';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/NativeCommunicationTool.dart';

class BarcodeScanTool {
  static Future <String> tryToScanBarcode() async {
    String barcodeScanRes;
    if(Platform.isIOS){
      barcodeScanRes = await NativeCommunicationTool().tryToScanBarcode();      
    } else if (Platform.isAndroid) {
      barcodeScanRes = await NativeCommunicationTool().tryToScanBarcode();      
    }
    if (isAvailable(barcodeScanRes) && barcodeScanRes.startsWith("C") && barcodeScanRes.length > 16) {
      barcodeScanRes = barcodeScanRes.substring(0, 16);
    }
    return barcodeScanRes;
  }
}