import 'package:bloc/bloc.dart';
import 'package:shifts_demo/models/activity_model.dart';
import 'package:shifts_demo/models/shift_data_model.dart';
import 'package:shifts_demo/resources/list_resources.dart';
import 'package:shifts_demo/utils/local_database.dart';

import '../../models/shift_activity_model.dart';
import '../../utils/firestore_service.dart';
import '../../utils/internet_checker.dart';

part 'sync_data_event.dart';

part 'sync_data_state.dart';

class SyncDataBloc extends Bloc<SyncDataEvent, SyncDataState> {
  SyncDataBloc() : super(SyncDataInitial()) {
    on<SyncAllData>((event, emit) async {
      emit(SyncDataUploadingData());
      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        List<ShiftData> shiftData =
            await DatabaseHelper.instance.getUnUploadedShiftData();
        if (shiftData.isNotEmpty) {
          for (final e in shiftData) {
            await DatabaseService().setShiftDate(
                shiftActivityModel: ShiftActivityModel(
                    activity: [],
                    isUploaded: UploadingStatues.success,
                    projectName: e.projectName,
                    memberName: e.memberName,
                    date: e.date));
          }
        }
        List<ActivityModel> activityData =
            await DatabaseHelper.instance.getUnUploadedActivityData();
        if (activityData.isNotEmpty) {
          for (final e in activityData) {
            if (e.isUploaded == UploadingStatues.notUploaded) {
              await DatabaseService().setActivityDate(
                  id: e.shift_id.toString(),
                  activityShiftModel: ActivityShiftModel(
                      activityName: e.activityName,
                      locationName: e.locationName,
                      endTime: e.endTime,
                      isUploaded: UploadingStatues.success,
                      comments: e.comments));
            } else if (e.isUploaded == UploadingStatues.delete) {
              await DatabaseService().deleteActivityDate(
                  id: e.shift_id.toString(),
                  activityShiftModel: ActivityShiftModel(
                      activityName: e.activityName,
                      locationName: e.locationName,
                      endTime: e.endTime,
                      isUploaded: UploadingStatues.success,
                      comments: e.comments));
            }
          }
        }
        emit(SyncDataGettingData());
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
        emit(SyncDataSuccess());
        emit(SyncDataInitial());
      } else {
        emit(NoInternet());
        emit(SyncDataInitial());
      }
    });
  }
}
