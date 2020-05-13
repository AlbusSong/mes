import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    // _setCertificateForHttpClient(this.dio);

    _startTimer();
  }

  void _setCertificateForHttpClient(Dio d) {
    (d.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      SecurityContext sc = SecurityContext.defaultContext;
      //file is the path of certificate
      sc.setTrustedCertificates("");
      HttpClient httpClient = new HttpClient(context: sc);
      // httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
      //   return true;
      // };
      return httpClient;
    };
  }

  void _startTimer() {
    Timer.periodic(const Duration(minutes: 25), (timer) {
      // Every hour
      _periodicalLogin();
    });
  }

  void _periodicalLogin() {
    if (isAvailable(MeInfo().username) == false ||
        isAvailable(MeInfo().password)) {
      return;
    }

    HttpDigger.login(MeInfo().username, MeInfo().password);
  }

  static const String baseUrl = "https://szzivos.51vip.biz/";
  // static const String baseUrl = "http://58.210.106.178:8088/";

  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {
      "user-agent": "MES-App",
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

    // update Cookie in header
    this.dio.options.headers["Cookie"] = MeInfo().cookie;
    // this.dio.options.headers["cookie"] = MeInfo().cookie;
    this.dio.options.headers.remove("cookie");
    // print("$uri header: ${this.dio.options.headers}");
    print("$uri mDict: $parameters");

    String md5OfParameters = generateMd5(jsonEncode(parameters));
    String cacheKey = (baseUrl + uri + "/" + md5OfParameters);
    // print("cacheKey: $cacheKey");
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

        if (_checkIfTimeoutByResponse(responseJson) == true) {
          HudTool.showInfoWithStatus("登陆超时");
          HomePage.eventBus.fire(null);
          return;
        }

        success(s ? 1 : 0, message, responseJson);
      }

      if (shouldCache == true) {
        FlutterCache().cacheData(jsonEncode(responseJson), cacheKey);
      }
    }).catchError((error) {
      int errorType = _checkErrorType(error);
      if (errorType != 0) {
        if (errorType == 1) {
          HudTool.showInfoWithStatus("网络超时");
        } else if (errorType == 2) {
          HudTool.showInfoWithStatus("登录错误");
          HomePage.eventBus.fire(null);
        } else if (errorType == -1) {
          // Do nothing
          HudTool.dismiss();
        }
      } else {
        print("$uri error: $error");
        if (failure != null) {
          failure(error);
        } else {
          HudTool.showInfoWithStatus("网络或服务器错误: $uri");
        }
      }
    });
  }

  bool _checkIfTimeoutByResponse(Map responseDict) {
    bool result = ((responseDict is Map) &&
        responseDict["Message"] != null &&
        ((responseDict["Message"] as String).contains("登录超时")));
    if (result) {
      print("_checkIfTimeoutByResponse: $responseDict");
    }
    return result;
  }

  int _checkErrorType(dynamic error) {
    int result = 0;
    if (error is DioError) {
      DioError dError = error;
      if (dError.type == DioErrorType.CONNECT_TIMEOUT ||
          dError.type == DioErrorType.RECEIVE_TIMEOUT) {
        result = 1; // timeout
      } else {
        if (dError.response != null) {
          if ((dError.response.statusCode != null) &&
              (dError.response.statusCode == 302)) {
            // 302 means wrong data type（html）
            // 302 means needing relogin
            result = 2; // 登录错误
          }
        } else {
          result = 1;
        }
      }
    } else if (error is FlutterError) {
      FlutterError fError = error;
      if (fError.message != null) {
        if (fError.message.startsWith("setState()")) {
          result = -1;
        }
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
        "user-agent": "MES-App",
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
        "user-agent": "MES-App",
        // "api": "1.0.0",
        // "Cookie": MeInfo().cookie,
      },
      contentType: "application/json",
      responseType: ResponseType.json,
    )).post("Login/OutOnline", data: {
      "UserName": username ?? "",
      "Password": password ?? ""
    }).then((responseObject) {
      MeInfo().cookie = responseObject.headers.value("set-cookie");
      MeInfo().storeCookie();
      if (success != null) {
        Map responseJson = responseObject.data;
        bool s = responseJson["Success"];
        String message = responseJson["Message"];
        success(s ? 1 : 0, message, responseJson);
      }
    }).catchError((error) {
      if (failure != null) {
        print("Login/OutOnline error: $error");
        failure(error);
      }
    });
  }
}
