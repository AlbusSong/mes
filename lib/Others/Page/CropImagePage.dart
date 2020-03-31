import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:simple_image_crop/simple_image_crop.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'package:mes/Others/Network/HttpDigger.dart';

class CropImagePage extends StatefulWidget {
  CropImagePage(
    this.image,
  );
  final File image;
  @override
  _CropImagePageState createState() => _CropImagePageState(image);
}

class _CropImagePageState extends State<CropImagePage> {
  _CropImagePageState(
    this.image,
  );
  final File image;
  final cropKey = GlobalKey<ImgCropState>();

  @override
  Widget build(BuildContext context) {
    // final Map args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: hexColor("f2f2f7"),
        appBar: AppBar(
          title: Text("图像裁剪"),
          centerTitle: true,
        ),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final crop = cropKey.currentState;
            final croppedImage =
                await crop.cropCompleted(image, pictureQuality: 600);
            this._getContentFromXunfeiServer(croppedImage);
          },
          tooltip: '裁剪',
          child: Text('裁剪'),
        ));
  }

  Widget _buildBody() {
    return Center(
      child: ImgCrop(
        key: cropKey,
        // chipRadius: 100,
        chipShape: 'rect',
        maximumScale: 3,
        image: FileImage(image),
      ),
    );
  }

  void _getContentFromXunfeiServer(File editedImage) {
    String editedImageBase64String =
        base64Encode(editedImage.readAsBytesSync());
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
