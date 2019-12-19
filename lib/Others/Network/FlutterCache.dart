import 'dart:async';
import 'package:mes/Others/Tool/GlobalTool.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FlutterCache {
  Database database;

  // 单例公开访问点
  factory FlutterCache() => _sharedInstance();

  // 静态私有成员，没有初始化
  static FlutterCache _instance = FlutterCache._();

  // 静态、同步、私有访问点
  static FlutterCache _sharedInstance() {
    return _instance;
  }

  // 私有构造函数
  FlutterCache._() {
    // 具体初始化代码
    _initSomeThings();
  }

  Future _initSomeThings() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'flutter_cache.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Cache_Table (id INTEGER PRIMARY KEY, cacheKey TEXT, cachedData BLOB, update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP)');
    });
    print("database: $database");
  }

  Future<void> cacheData(dynamic data, String cacheKey) async {
    List<Map> listOfRecord = await database.rawQuery("SELECT * FROM Cache_Table WHERE cacheKey = ?", [cacheKey]);
//    print("cacheData listOfRecord: $listOfRecord");
//    Map<String, dynamic> recordDict = {"cacheKey":cacheKey, "cachedData":data};
    if (listLength(listOfRecord) == 0) {
//      await database.insert("Cache_Table", recordDict, conflictAlgorithm: ConflictAlgorithm.replace);
      await database.rawInsert("INSERT INTO Cache_Table(cacheKey, cachedData) VALUES(?, ?)", [cacheKey, data]);
    } else {
//      await database.update("Cache_Table", recordDict, where: "");
      await database.rawUpdate("UPDATE Cache_Table SET cachedData = ?, update_time = datetime('now','localtime') WHERE cacheKey = ?", [data, cacheKey]);
    }
  }

  Future<dynamic> getCachedData(String cacheKey) async {
    List<Map> listOfRecord = await database.rawQuery("SELECT * FROM Cache_Table WHERE cacheKey = ?", [cacheKey]);
//    print("getCachedData listOfRecord: $listOfRecord");
    if (listLength(listOfRecord) == 0) {
      return null;
    } else {
      Map firstRecord = listOfRecord[0];
      return firstRecord["cachedData"];
    }
  }
}

class CacheRecord {
  CacheRecord({this.record_id, this.cacheKey, this.cachedData});

  final int record_id;
  final String cacheKey;
  final dynamic cachedData;

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': record_id,
      'cacheKey': cacheKey,
      'cachedData': cachedData,
    };
  }
}
