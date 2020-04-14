import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';


//  Image Base64字符串 转为 image
Image convertToImageByBase64String(base64String) {
  Uint8List bytes = Base64Decoder().convert(base64String);
  if (bytes != null) {
    return Image.memory(bytes);
  } else {
    return null;
  }
}

// md5 加密
String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}

Color hexColor(String hexString) {
  // 如果传入的十六进制颜色值不符合要求，返回默认值
  if (hexString == null || hexString.length != 6 || int.tryParse(hexString.substring(0, 6), radix: 16) == null) {
    hexString = 'ffffff';
  }

  return new Color(int.parse(hexString.substring(0, 6), radix: 16) + 0xFF000000);
}

Color randomColor() {
  final Random _rgn = new Random();
  Color result = Color.fromARGB(255, _rgn.nextInt(255), _rgn.nextInt(255), _rgn.nextInt(255));
  return result;
}

int randomIntUntil(int max) {
  return randomIntWithRange(0, max);
}

int randomIntWithRange(int min, int max) {
  final Random _rgn = new Random();
  return min + _rgn.nextInt(max - min + 1);
}

void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
}

int listLength(List list) {
  if (list == null) {
    return 0;
  }

  return list.length;
}

String avoidNull(String s) {
  if (s == null) {
    return "";
  }

  return s;
}

int stringLength(String s) {
  if (s == null) {
    return 0;
  }

  return s.length;
}

bool isAvailable(String s) {
  if (s == null) {
    return false;
  }

  if (s == "") {
    return false;
  }

  return true;
}

