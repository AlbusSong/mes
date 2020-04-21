import 'package:dio/dio.dart';
import 'package:mes/Others/Model/MeInfo.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:mes/Others/Tool/HudTool.dart';
import 'dart:convert';
import 'FlutterCache.dart';
import '../../Home/HomePage.dart';

typedef HttpSuccess = void Function(
    int code, String message, dynamic responseJson);
typedef HttpFailure = void Function(dynamic error);

class HttpDigger {
  factory HttpDigger() => _getInstance();

  static HttpDigger get instance => _getInstance();

  static HttpDigger _instance;

  HttpDigger._internal() {
    // Initialize
    _initSomeThings();
  }

  static HttpDigger _getInstance() {
    if (_instance == null) {
      _instance = new HttpDigger._internal();
    }
    return _instance;
  }

  void _initSomeThings() {
//    dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
//    FlutterCache();
  }

  static const String baseUrl = "http://58.210.106.178:8088/";

  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 100000,
    // 5s
    headers: {
      "user-agent": "MES-Android",
      // "api": "1.0.0",
      "Cookie": MeInfo().cookie,
    },
    contentType: "application/json",
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.json,
  ));

  void postWithUri(String uri,
      {Map parameters,
      bool shouldCache = false,
      HttpSuccess success,
      HttpFailure failure}) {
    print("NetworkRequest Url: ${baseUrl + uri}");

    String md5OfParameters = generateMd5(jsonEncode(parameters));
    String cacheKey = (baseUrl + uri + "/" + md5OfParameters);
    print("cacheKey: $cacheKey");
    if (shouldCache == true) {
      Future<dynamic> cachedDataFuture = FlutterCache().getCachedData(cacheKey);
      cachedDataFuture.then((responseJsonString) {
        if (success != null && responseJsonString != null) {
          dynamic responseJson = jsonDecode(responseJsonString);
          if (responseJson == null) {
            success(0, "data is null", null);
            return;
          }

          bool s = false;
          if ((responseJson is Map) && responseJson["Success"] != null) {
            s = responseJson["Success"];
          }
          // s = (responseJson["Success"] != null) ? responseJson["Success"] : false;
          String message = "";
          if ((responseJson is Map) && responseJson["Message"] != null) {
            message = responseJson["Message"];
          }
          if (responseJson is Map) {
            responseJson["isCachedData"] = true;
          }
          success(s ? 1 : 0, message, responseJson);
        }
      });
    }

    Future<Response> responseFuture =
        dio.post(uri, data: parameters == null ? {} : parameters);
    responseFuture.then((responseObject) {
      dynamic responseObjectData = responseObject.data;
      Map responseJson;
      if ((responseObjectData is Map) == false ||
          ((responseObjectData is Map) == true &&
              responseObjectData["Success"] == null)) {
        responseJson = {
          "Success": true,
          "Message": "",
          "Extend": responseObjectData,
        };
      } else {
        responseJson = responseObjectData;
      }

      if (success != null) {
        if (responseJson == null) {
          success(0, "data is null", null);
          return;
        }

        bool s = false;
        if ((responseJson is Map) && responseJson["Success"] != null) {
          s = responseJson["Success"];
        }
        // s = (responseJson["Success"] != null) ? responseJson["Success"] : false;
        String message = "";
        if ((responseJson is Map) && responseJson["Message"] != null) {
          message = responseJson["Message"];
        }
        success(s ? 1 : 0, message, responseJson);
      }

      if (shouldCache == true) {
        FlutterCache().cacheData(jsonEncode(responseJson), cacheKey);
      }
    }).catchError((error) {
      if (_checkIfNeedReLoginFromError(error) == true) {
        HomePage.eventBus.fire(null);
      } else {
        if (failure != null) {
          failure(error);
        } else {
          print("$uri error: $error");
          HudTool.showInfoWithStatus("网络或服务器错误: $uri");
        }
      }
    });
  }

  bool _checkIfNeedReLoginFromError(dynamic error) {
    bool result = false;
    if (error is DioError) {
      DioError dError = error as DioError;
      if (dError.response.statusCode == 302) {
        // 302 means wrong data type（html）
        // 302 means needing relogin
        result = true;
      }
    }

    return result;
  }

  void cancelAllRequest() {
    dio.clear();
  }

  static void xunfeiOCR(String imageBase64String,
      {HttpSuccess success, HttpFailure failure}) {
    String xunfeiAppId = "5e73354e";
    String xunfeiAppKey = "323f4a078dc0102067b66b2088e7c73e";
    String currentUnixTimeString =
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}";
    Map xParam = {"language": "en", "location": "false"};
    String xParamBase64String = base64.encode(utf8.encode(jsonEncode(xParam)));
    String checkSumMaterial =
        "$xunfeiAppKey$currentUnixTimeString$xParamBase64String";
    String checkSum = generateMd5(checkSumMaterial);
    Dio(BaseOptions(
      baseUrl: "https://webapi.xfyun.cn/",
      connectTimeout: 300000,
      receiveTimeout: 300000,
      // 5s
      headers: {
        "user-agent": "MES-Android",
        "X-Appid": xunfeiAppId,
        "X-CurTime": currentUnixTimeString,
        "X-Param": xParamBase64String,
        "X-CheckSum": checkSum,
        // "api": "1.0.0",
        // "Cookie": MeInfo().cookie,
      },
      // contentType: "application/json",
      contentType: "application/x-www-form-urlencoded",
      responseType: ResponseType.json,
    ))
      ..post("v1/service/v1/ocr/general", data: {"image": imageBase64String})
          .then((responseObject) {
        // print("responseObject: $responseObject");
        // print("responseObject Data: ${responseObject.data is String}");
        Map responseJson;
        if (responseObject.data is String) {
          responseJson = jsonDecode(responseObject.data);
        } else {
          responseJson = responseObject.data;
        }
        if (success != null) {
          // print("responseJson: $responseJson");
          // MeInfo().cookie = responseObject.headers.value("set-cookie");
          // Map responseJson = responseObject.data;
          // bool s = responseJson["Success"];
          // String message = responseJson["Message"];
          success(int.parse(responseJson["code"]), responseJson["desc"],
              responseJson);
        }
      }).catchError((error) {
        if (failure != null) {
          failure(error);
        }
      });
  }

  static void login(String username, String password,
      {HttpSuccess success, HttpFailure failure}) {
    Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 100000,
      // 5s
      headers: {
        "user-agent": "MES-Android",
        // "api": "1.0.0",
        // "Cookie": MeInfo().cookie,
      },
      contentType: "application/json",
      responseType: ResponseType.json,
    )).post("Login/OutOnline", data: {
      "UserName": username ?? "",
      "Password": password ?? ""
    }).then((responseObject) {
      if (success != null) {
        MeInfo().cookie = responseObject.headers.value("set-cookie");
        Map responseJson = responseObject.data;
        bool s = responseJson["Success"];
        String message = responseJson["Message"];
        success(s ? 1 : 0, message, responseJson);
      }
    }).catchError((error) {
      if (failure != null) {
        failure(error);
      }
    });
  }
}
