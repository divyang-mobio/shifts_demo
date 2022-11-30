import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:shifts_demo/models/activity_model.dart';
import 'package:shifts_demo/models/shift_activity_model.dart';
import 'package:shifts_demo/models/shift_data_model.dart';
import 'package:shifts_demo/utils/local_database.dart';
import '../../utils/firestore_service.dart';
import '../../utils/internet_checker.dart';

part 'open_shift_event.dart';

part 'open_shift_state.dart';

class OpenShiftBloc extends Bloc<OpenShiftEvent, OpenShiftState> {
  OpenShiftBloc() : super(OpenShiftInitial()) {
    on<GetData>((event, emit) async {
      final notSendDataActivity =
          await DatabaseHelper.instance.getUnUploadedActivityData();
      final notSendDataShift =
          await DatabaseHelper.instance.getUnUploadedShiftData();
      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (notSendDataActivity.isEmpty &&
          notSendDataShift.isEmpty &&
          isInternetAvailable) {
        List<ShiftActivityModel> data = await DatabaseService().getShift();
        await DatabaseHelper.instance.deleteAllData();
        for (final i in data) {
          await DatabaseHelper.instance.addShiftData(ShiftData(
              id: i.id as String,
              projectName: i.projectName,
              isUploaded: i.isUploaded,
              memberName: i.memberName,
              date: i.date));
          for (final f in i.activity) {
            await DatabaseHelper.instance.addActivityData(ActivityModel(
                activityName: f.activityName,
                locationName: f.locationName,
                shift_id: i.id as String,
                endTime: f.endTime,
                isUploaded: f.isUploaded,
                comments: f.comments));
          }
        }
        emit(OpenShiftLoaded(
            data: data, isInternetConnected: isInternetAvailable));
      } else {
        List<ShiftActivityModel> data =
            await DatabaseHelper.instance.getShiftActivityData();
        emit(OpenShiftLoaded(
            data: data, isInternetConnected: isInternetAvailable));
      }
    });

    on<DataSynced>((event, emit) async {
      List<ShiftActivityModel> data =
          await DatabaseHelper.instance.getShiftActivityData();
      emit(OpenShiftLoaded(data: data, isInternetConnected: true));
    });

    on<UpLoadData>((event, emit) async {
      emit(OpenShiftInitial());

      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        final id = await DatabaseService().setShiftDate(
            shiftActivityModel: ShiftActivityModel(
                activity: [],
                isUploaded: true,
                projectName: event.projectName,
                memberName: event.memberName,
                date: event.dateTime));

        await DatabaseHelper.instance.addShiftData(ShiftData(
            id: id,
            projectName: event.projectName,
            isUploaded: isInternetAvailable,
            memberName: event.memberName,
            date: event.dateTime));

        List<ShiftActivityModel> data =
            await DatabaseHelper.instance.getShiftActivityData();
        emit(OpenShiftLoaded(
            data: data, isInternetConnected: isInternetAvailable));
      } else {
        await DatabaseHelper.instance.addShiftData(ShiftData(
            id: getRandomString(10),
            projectName: event.projectName,
            isUploaded: isInternetAvailable,
            memberName: event.memberName,
            date: event.dateTime));

        List<ShiftActivityModel> data =
            await DatabaseHelper.instance.getShiftActivityData();
        emit(OpenShiftLoaded(
            data: data, isInternetConnected: isInternetAvailable));
      }
    });
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
