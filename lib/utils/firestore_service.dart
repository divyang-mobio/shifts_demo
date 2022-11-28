import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shifts_demo/models/activity_model.dart';

import '../models/shift_data_model.dart';

class DatabaseService {
  final CollectionReference shiftCollection =
      FirebaseFirestore.instance.collection('shift');

  Future<bool> setShiftDate({
    required String projectName,
    required String memberName,
    required DateTime dateTime,
  }) async {
    try {
      final data = ShiftData(
              projectName: projectName,
              activity: [],
              memberName: memberName,
              date: dateTime)
          .toJson();
      final ids = await shiftCollection.add(data);

      await ids.update({'id': ids.id});
      return true;
    } catch (e) {
      throw 'error';
    }
  }

  setActivityDate(
      {required String id, required ActivityModel activityModel}) async {
    shiftCollection.doc(id).set({
      'activity': FieldValue.arrayUnion([activityModel.toJson()]),
    }, SetOptions(merge: true));
  }

  Stream<List<ShiftData>> getShiftData() {
    try {
      return shiftCollection
          .orderBy('date', descending: false)
          .snapshots()
          .transform(Utils.transformer(ShiftData.fromJson));
    } catch (e) {
      throw 'error';
    }
  }

  Future<List<ShiftData>> getShift() async {
    try {
      final data =
          await shiftCollection.orderBy('date', descending: false).get();

      List<ShiftData> shiftData = data.docs
          .map((e) => ShiftData.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      return shiftData;
    } catch (e) {
      throw 'error';
    }
  }
}

class Utils {
  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<T>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> data,
                EventSink<List<T>> sink) {
              final snaps = data.docs.map((doc) => doc.data()).toList();
              final users = snaps.map((json) => fromJson(json)).toList();

              sink.add(users);
            },
          );
}
