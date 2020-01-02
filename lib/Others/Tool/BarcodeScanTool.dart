import 'dart:io';
import 'package:qrscan/qrscan.dart' as scanner;

class BarcodeScanTool {
  static Future <String> tryToScanBarcode() async {
    if(Platform.isIOS){
      
    } else if (Platform.isAndroid) {
      String barcodeScanRes = await scanner.scan();
      return barcodeScanRes;
    }
  }
}