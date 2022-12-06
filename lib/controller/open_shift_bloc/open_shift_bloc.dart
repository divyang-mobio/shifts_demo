import 'dart:math';
import 'package:bloc/bloc.dart';
import '../../models/activity_model.dart';
import '../../models/shift_activity_model.dart';
import '../../models/shift_data_model.dart';
import '../../utils/local_database.dart';
import '../../resources/list_resources.dart';
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
        List<ShiftActivityModel> dataUpdate =
            await DatabaseService().getShift();
        await DatabaseHelper.instance.deleteAllData();
        for (final i in dataUpdate) {
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
      }
      List<ShiftActivityModel> data =
          await DatabaseHelper.instance.getShiftActivityData();
      emit(OpenShiftLoaded(data: data));
    });

    on<DataSynced>((event, emit) async {
      List<ShiftActivityModel> data =
          await DatabaseHelper.instance.getShiftActivityData();
      emit(OpenShiftLoaded(data: data));
    });

    on<UpdateShift>((event, emit) async {
      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        await DatabaseService().updateShiftDate(
            shiftActivityModel: ShiftData(
                id: event.id,
                isUploaded: UploadingStatues.success,
                projectName: event.projectName,
                memberName: event.memberName,
                date: event.dateTime));
      }

      await DatabaseHelper.instance.updateShift(ShiftData(
          id: event.id,
          projectName: event.projectName,
          isUploaded:
              isInternetAvailable ? UploadingStatues.success : event.status,
          memberName: event.memberName,
          date: event.dateTime));

      List<ShiftActivityModel> data =
          await DatabaseHelper.instance.getShiftActivityData();
      emit(OpenShiftLoaded(data: data));
    });

    on<UpLoadData>((event, emit) async {
      emit(OpenShiftInitial());
      String? id;

      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        id = await DatabaseService().setShiftDate(
            shiftActivityModel: ShiftActivityModel(
                activity: [],
                isUploaded: UploadingStatues.success,
                projectName: event.projectName,
                memberName: event.memberName,
                date: event.dateTime));
      }

      await DatabaseHelper.instance.addShiftData(ShiftData(
          id: id ?? getRandomString(10),
          projectName: event.projectName,
          isUploaded: isInternetAvailable
              ? UploadingStatues.success
              : UploadingStatues.notUploaded,
          memberName: event.memberName,
          date: event.dateTime));

      List<ShiftActivityModel> data =
          await DatabaseHelper.instance.getShiftActivityData();
      emit(OpenShiftLoaded(data: data));
    });
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
