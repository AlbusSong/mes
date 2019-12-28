import 'package:dio/dio.dart';
import 'package:mes/Others/Model/MeInfo.dart';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'dart:convert';
import 'FlutterCache.dart';

typedef HttpSuccess = void Function(
    int code, String message, dynamic responseJson);
typedef HttpFailure = void Function(Error error);

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
      "user-agent": "EES-Android",
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
        if (success != null) {
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
      dynamic responseJson = responseObject.data;
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
        "user-agent": "EES-Android",
        // "api": "1.0.0",
        // "Cookie": MeInfo().cookie,
      },
      contentType: "application/json",
      responseType: ResponseType.json,
    ))
      ..post("Login/OutOnline",
              data: {"UserName": username ?? "", "Password": password ?? ""})
          .then((responseObject) {
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
