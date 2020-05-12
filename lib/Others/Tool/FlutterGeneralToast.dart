import 'package:flutter/material.dart';

class FlutterGeneralToast {
  factory FlutterGeneralToast() => _sharedInfo();
  
  static FlutterGeneralToast _instance = FlutterGeneralToast._();

  static FlutterGeneralToast _sharedInfo() {
    return _instance;
  }

  FlutterGeneralToast._() {
    _initSomeThings();
  }

  void _initSomeThings() {

  }

  int milliSecondsBeforeDissmissed = 1500;
  static BuildContext APP_CONTEXT;

  FlutterGeneralToastController _toastController = FlutterGeneralToastController(1500);

  static showMessage(String status) {
    showMessageWithLivingPeriod(status, FlutterGeneralToast().milliSecondsBeforeDissmissed);
  }

  static showMessageWithLivingPeriod(
      String status, int milliSecondsBeforeDissmissed) {
    var overlayState = Overlay.of(APP_CONTEXT);
    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (ctx) {
      return buildMessageToastLayout(status);
      // return buildProgressHUDLayout();
    });
    FlutterGeneralToast()._toastController.dismiss();
    FlutterGeneralToast()._toastController.milliSecondsBeforeDissmissed =
        milliSecondsBeforeDissmissed;
    FlutterGeneralToast()._toastController.overlayState = overlayState;
    FlutterGeneralToast()._toastController.overlayEntry = overlayEntry;
    FlutterGeneralToast()._toastController.showAndDismissSoon();
  }

  static show() {
    var overlayState = Overlay.of(APP_CONTEXT);
//    print("overlayState: $overlayState");
    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (ctx) {
      return buildProgressHUDLayout();
    });
    FlutterGeneralToast()._toastController.dismiss();
    FlutterGeneralToast()._toastController.overlayState = overlayState;
    FlutterGeneralToast()._toastController.overlayEntry = overlayEntry;
    FlutterGeneralToast()._toastController.show();
  }

  static dismiss() {
    FlutterGeneralToast()._toastController.dismiss();
  }

  static LayoutBuilder buildProgressHUDLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * 0.45,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }

  static LayoutBuilder buildMessageToastLayout(String status) {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              child: Container(
                child: Text(
                  "$status",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height * 0.45,
                left: constraints.biggest.width * 0.2,
                right: constraints.biggest.width * 0.2,
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    });
  }
}

class FlutterGeneralToastController {
  FlutterGeneralToastController([this.milliSecondsBeforeDissmissed]);

  int milliSecondsBeforeDissmissed;
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  bool isDismissed = false;

  showAndDismissSoon() async {
    await Future.delayed(Duration(microseconds: 100));
    // overlayEntry?.remove();
    overlayState.insert(overlayEntry);
    this.isDismissed = false;
    await Future.delayed(Duration(milliseconds: milliSecondsBeforeDissmissed));
    this.dismiss();
  }

  show() async {
    await Future.delayed(Duration(microseconds: 100));
    // overlayEntry?.remove();
    overlayState.insert(overlayEntry);
    this.isDismissed = false;
  }

  dismiss() async {
    if (this.isDismissed == true) {
      return;
    }

    if (overlayEntry != null) {
      overlayEntry.remove();
    }

    this.isDismissed = true;
  }
}