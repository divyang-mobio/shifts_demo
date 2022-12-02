import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shifts_demo/models/activity_model.dart';
import 'package:shifts_demo/models/shift_activity_model.dart';
import 'package:shifts_demo/models/shift_data_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _init();

  Future<Database> _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "shift.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE SHIFT(
    id TEXT,
    projectName TEXT,
    memberName TEXT,
    isUploaded INTEGER,
    date TEXT
  )
    ''');

    await db.execute('''
    CREATE TABLE ACTIVITY(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    activityName TEXT,
    locationName TEXT,
    comments TEXT,
    shift_id TEXT,
    isUploaded INTEGER,
    endTime TEXT
  )
  ''');
  }

  Future<int> addShiftData(ShiftData data) async {
    Database db = await instance.database;
    return await db.insert('SHIFT', data.toJson());
  }

  Future<List<ShiftData>> getShiftData() async {
    Database db = await instance.database;
    var data = await db.query('SHIFT');
    List<ShiftData> dataList =
        data.isNotEmpty ? data.map((c) => ShiftData.fromJson(c)).toList() : [];
    return dataList;
  }

  Future<int> deleteShiftData(int id) async {
    Database db = await instance.database;
    return await db.delete('SHIFT', where: "id = ?", whereArgs: [id]);
  }

  Future<int> addActivityData(ActivityModel data) async {
    Database db = await instance.database;
    return await db.insert('ACTIVITY', data.toJson());
  }

  Future<int> updateActivityData(ActivityModel data) async {
    Database db = await instance.database;
    return await db.update('ACTIVITY', data.toJson(),
        where: "id = ?", whereArgs: [data.id]);
  }

  Future<List<ActivityModel>> getActivityData(int id) async {
    Database db = await instance.database;
    var data =
        await db.query('ACTIVITY', where: "shift_id = ?", whereArgs: [id]);
    List<ActivityModel> dataList = data.isNotEmpty
        ? data.map((c) => ActivityModel.fromJson(c)).toList()
        : [];
    return dataList;
  }

  Future<int> deleteActivityData(int id) async {
    Database db = await instance.database;
    return await db.delete('ACTIVITY', where: "id = ?", whereArgs: [id]);
  }

  Future<bool> deleteAllData() async {
    Database db = await instance.database;
    await db.delete('SHIFT');
    await db.delete('ACTIVITY');
    return true;
  }

  Future<List<ShiftData>> getUnUploadedShiftData() async {
    Database db = await instance.database;
    var data = await db.query('SHIFT', where: "isUploaded != ?", whereArgs: [0]);
    List<ShiftData> dataList =
        data.isNotEmpty ? data.map((c) => ShiftData.fromJson(c)).toList() : [];
    return dataList;
  }

  Future<List<ActivityModel>> getUnUploadedActivityData() async {
    Database db = await instance.database;
    var data =
        await db.query('ACTIVITY', where: "isUploaded != ?", whereArgs: [0]);
    List<ActivityModel> dataList = data.isNotEmpty
        ? data.map((c) => ActivityModel.fromJson(c)).toList()
        : [];
    return dataList;
  }

  Future<List<ShiftActivityModel>> getShiftActivityData() async {
    Database db = await instance.database;
    var data = await db.query('SHIFT');
    List<ShiftData> dataList =
        data.isNotEmpty ? data.map((c) => ShiftData.fromJson(c)).toList() : [];
    if (dataList.isEmpty) {
      return [];
    } else {
      var datas = await db.query('ACTIVITY');
      List<ActivityModel> activityList = datas.isNotEmpty
          ? datas.map((c) => ActivityModel.fromJson(c)).toList()
          : [];
      List<ShiftActivityModel> shiftActivityModel = dataList
          .map((e) => ShiftActivityModel(
              projectName: e.projectName,
              id: e.id.toString(),
              activity: (activityList.isEmpty)
                  ? []
                  : activityList
                      .map((f) => (f.shift_id == e.id)
                          ? ActivityShiftModel(
                              id: f.id,
                              activityName: f.activityName,
                              locationName: f.locationName,
                              endTime: f.endTime,
                              isUploaded: f.isUploaded,
                              comments: f.comments)
                          : null)
                      .whereType<ActivityShiftModel>()
                      .toList(),
              isUploaded: e.isUploaded,
              memberName: e.memberName,
              date: e.date))
          .toList();

      return shiftActivityModel;
    }
  }
}
