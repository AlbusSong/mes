import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as ImageTool;
import 'package:mes/Others/Model/Trifle.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class TakePhotoForOCRPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TakePhotoForOCRPageState();
  }
}

class _TakePhotoForOCRPageState extends State<TakePhotoForOCRPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  double screenWidth = window.physicalSize.width / window.devicePixelRatio;
  double marginLeft = 40;
  double marginTop;
  Rect cropArea;

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    double size = screenWidth - marginLeft * 2;
    marginTop =
        (window.physicalSize.height / window.devicePixelRatio - size) / 2.0 -
            50;
    cropArea = Rect.fromLTWH(marginLeft, marginTop, size, size);

    WidgetsFlutterBinding.ensureInitialized();
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      Trifle().firstCamera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexColor("f2f2f7"),
      appBar: AppBar(
        title: Text("OCR拍照"),
        centerTitle: true,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // Provide an onPressed callback.
          onPressed: () {
            _tryToTakePicture();
          }),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return _realBody();
        } else {
          // Otherwise, display a loading indicator.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _realBody() {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CameraPreview(_controller),
          Positioned(
            left: cropArea.left,
            top: cropArea.top,
            child: Opacity(
              opacity: 1.0,
              child: Container(
                height: cropArea.width,
                width: cropArea.height,
                // color: randomColor(),
                decoration: BoxDecoration(
                  color: Color.fromARGB(60, 255, 255, 255),
                  border: new Border.all(width: 2, color: hexColor("ffffff")),
                  borderRadius: new BorderRadius.all(Radius.circular(0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _tryToTakePicture() async {
    print("_tryToTakePicture");
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    await _controller.takePicture(path);
    _clipImage(path, 0, 0, 0, 0);
  }

  Future _clipImage(String imagePath, double left, double top, double width,
      double height) async {
    ImageTool.Image originalImage =
        ImageTool.decodeImage(File(imagePath).readAsBytesSync());
    int shortSide = min(originalImage.width, originalImage.height);
    int longSide = max(originalImage.width, originalImage.height);
    int size =
        (shortSide * ((screenWidth - marginLeft * 2) / screenWidth)).toInt();
    int left = (shortSide * (marginLeft / screenWidth)).toInt();
    int top = (longSide *
            (marginTop /
                (window.physicalSize.height / window.devicePixelRatio)))
        .toInt();
    ImageTool.Image croppedImage =
        ImageTool.copyCrop(originalImage, top, left, size, size);
    File(imagePath).writeAsBytesSync(ImageTool.encodeJpg(croppedImage));
    _controller.stopImageStream();
    _getContentFromXunfeiServer(File(imagePath));

    // Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => DisplayPictureScreen(imagePath: imagePath)
    //           ),
    //         );
  }

  void _getContentFromXunfeiServer(File croppedImage) {    

    String editedImageBase64String =
        base64Encode(croppedImage.readAsBytesSync());
    HudTool.show();
    HttpDigger.xunfeiOCR(editedImageBase64String,
        success: (int code, String message, dynamic responseJson) {
      print("responseJson: $responseJson");
      if (code == 0) {
        List blockList = responseJson["data"]["block"] as List;
        if (listLength(blockList) == 0) {
          HudTool.showInfoWithStatus("无有效文本信息");
          Navigator.of(context).pop(null);
          return;
        }

        List contentList = ((blockList[0] as Map)["line"] as List);
        String code;
        for (int i = 0; i < listLength(contentList); i++) {
          Map contentDict = contentList[i];
          List wordList = contentDict["word"];
          if (listLength(wordList) == 0) {
            continue;
          }
          for (Map contentSubDict in wordList) {
            String c = contentSubDict["content"] as String;
            if (isAvailable(c)) {
              code = c;
              break;
            }
            // if (c.startsWith("C") && c.endsWith("F")) {
            //   code = c;
            //   break;
            // }
          }

          if (code != null) {
            break;
          }
        }

        if (code == null) {
          HudTool.showInfoWithStatus("未识别出有效码，请重试");
          Navigator.of(context).pop(null);
        }

        HudTool.dismiss();
        Navigator.of(context).pop(code);
      } else {
        HudTool.showInfoWithStatus(message);
        Navigator.of(context).pop(null);
      }
    }, failure: (dynamic error) {
      print("error: $error");
      HudTool.showInfoWithStatus(error.toString());
      Navigator.of(context).pop(null);
    });
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
