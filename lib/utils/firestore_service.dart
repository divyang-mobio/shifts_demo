import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shifts_demo/models/shift_activity_model.dart';

class DatabaseService {
  final CollectionReference shiftCollection =
      FirebaseFirestore.instance.collection('shift');

  Future<String> setShiftDate({
    required ShiftActivityModel shiftActivityModel,
  }) async {
    try {
      final ids = await shiftCollection.add(shiftActivityModel.toJson());

      await ids.update({'id': ids.id});
      return ids.id;
    } catch (e) {
      throw 'error';
    }
  }

  Future<bool> setActivityDate(
      {required String id,
      required ActivityShiftModel activityShiftModel}) async {
    try {
      await shiftCollection.doc(id).set({
        'activity': FieldValue.arrayUnion([activityShiftModel.toJson()]),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      throw 'error';
    }
  }

  Future<bool> deleteActivityDate(
      {required String id,
      required ActivityShiftModel activityShiftModel}) async {
    try {
      await shiftCollection.doc(id).update({
        'activity': FieldValue.arrayRemove([activityShiftModel.toJson()]),
      });
      return true;
    } catch (e) {
      throw 'error';
    }
  }

  Future<bool> updateActivityDate(
      {required String id,
      required ActivityShiftModel activityShiftModel}) async {
    try {
      await shiftCollection.doc(id).update({
        'activity': FieldValue.arrayRemove([activityShiftModel.toJson()]),
      });
      return true;
    } catch (e) {
      throw 'error';
    }
  }

  Future<List<ShiftActivityModel>> getShift() async {
    try {
      final data =
          await shiftCollection.orderBy('date', descending: true).get();

      List<ShiftActivityModel> shiftData = data.docs
          .map((e) =>
              ShiftActivityModel.fromJson(e.data() as Map<String, dynamic>))
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
