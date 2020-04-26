import 'package:shared_preferences/shared_preferences.dart';

class MeInfo {
  // 单例公开访问点
  factory MeInfo() => _sharedInfo();

  // 静态私有成员，没有初始化
  static MeInfo _instance = MeInfo._();

  // 静态、同步、私有访问点
  static MeInfo _sharedInfo() {
    return _instance;
  }

  // 私有构造函数
  MeInfo._() {
    // 具体初始化代码
    _initSomeThings();
  }

  String cookie;
  bool isLogined;
  String username;
  String password;
  String nickname;
  bool shouldRememberMe;
  int lastLoginUnixTime;

  Future _initSomeThings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    this.isLogined = (pref.getBool("isLogined") ?? false);this.shouldRememberMe = (pref.getBool("shouldRememberMe") ?? false);
    this.username = (pref.getString("username") ?? "");
    this.password = (pref.getString("password") ?? "");
    this.nickname = (pref.getString("nickname") ?? "");
    this.cookie = (pref.getString("cookie") ?? "");
    this.lastLoginUnixTime = (pref.getInt("lastLoginUnixTime") ?? DateTime.now().millisecondsSinceEpoch);
  }

  Future storeLoginInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("isLogined", this.isLogined);
    pref.setBool("shouldRememberMe", this.shouldRememberMe);
    if (this.shouldRememberMe == true) {
      pref.setString("password", this.password);
      pref.setString("username", this.username);
      pref.setString("nickname", this.nickname);
      pref.setString("cookie", this.cookie);
    } else {
      pref.setString("", this.password);
      pref.setString("", this.username);
      pref.setString("", this.nickname);
      pref.setString("cookie", this.cookie);
    }
  }

  Future storeCookie() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("cookie", this.cookie);

    // 记录登录时间
    pref.setInt("lastLoginUnixTime", DateTime.now().millisecondsSinceEpoch);
  }
}
