import 'MyToast.dart';

typedef DissmissBlock = void Function ();

class HudTool {

  static void showInfoWithStatus(String status) {
    MyToast.showMessage(status);
  }

  static void show() {
    MyToast.show();
  }

  static void dismiss({DissmissBlock block}) {
    MyToast.dismiss();
  }
}
