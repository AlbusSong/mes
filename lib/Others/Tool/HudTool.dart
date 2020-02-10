import 'package:flutter_general_toast/flutter_general_toast.dart';
// import 'MyToast.dart';

typedef DissmissBlock = void Function ();

class HudTool {

  static void showInfoWithStatus(String status) {
    // MyToast.showMessage(status);
    FlutterGeneralToast.showMessage(status);
  }

  static void show() {
    // MyToast.show();
    FlutterGeneralToast.show();
  }

  static void dismiss({DissmissBlock block}) {
    // MyToast.dismiss();
    FlutterGeneralToast.dismiss();
  }
}
