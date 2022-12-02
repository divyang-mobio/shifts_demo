import 'package:bloc/bloc.dart';
import '../../models/activity_model.dart';
import '../../models/shift_activity_model.dart';
import '../../resources/list_resources.dart';
import '../../utils/firestore_service.dart';
import '../../utils/internet_checker.dart';
import '../../utils/local_database.dart';

part 'activity_event.dart';

part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    on<AddActivity>((event, emit) async {
      emit(ActivityInitial());

      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        await DatabaseService().setActivityDate(
            id: event.activityModel.shift_id.toString(),
            activityShiftModel: ActivityShiftModel(
                activityName: event.activityModel.activityName,
                locationName: event.activityModel.locationName,
                endTime: event.activityModel.endTime,
                isUploaded: UploadingStatues.success,
                comments: event.activityModel.comments));
      }
      await DatabaseHelper.instance.addActivityData(ActivityModel(
          activityName: event.activityModel.activityName,
          locationName: event.activityModel.locationName,
          shift_id: event.activityModel.shift_id,
          endTime: event.activityModel.endTime,
          isUploaded: isInternetAvailable
              ? UploadingStatues.success
              : event.activityModel.isUploaded,
          comments: event.activityModel.comments));
      event.data.activity.add(ActivityShiftModel(
          activityName: event.activityModel.activityName,
          locationName: event.activityModel.locationName,
          endTime: event.activityModel.endTime,
          isUploaded: isInternetAvailable
              ? UploadingStatues.success
              : event.activityModel.isUploaded,
          comments: event.activityModel.comments));

      emit(ActivityLoaded(data: event.data, newDataAdded: true));
    });
    on<UpdateActivity>((event, emit) async {
      emit(ActivityInitial());

      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        if (event.statues != UploadingStatues.success) {
          await DatabaseService().setActivityDate(
              id: event.activityModel.shift_id.toString(),
              activityShiftModel: ActivityShiftModel(
                  activityName: event.activityModel.activityName,
                  locationName: event.activityModel.locationName,
                  endTime: event.activityModel.endTime,
                  isUploaded: UploadingStatues.success,
                  comments: event.activityModel.comments));
        } else {
          await DatabaseService().updateActivityDate(
              id: event.activityModel.shift_id.toString(),
              activityShiftModel: ActivityShiftModel(
                  activityName: event.activityModel.activityName,
                  locationName: event.activityModel.locationName,
                  endTime: event.activityModel.endTime,
                  isUploaded: UploadingStatues.success,
                  comments: event.activityModel.comments));
        }
      }
      await DatabaseHelper.instance.addActivityData(ActivityModel(
          activityName: event.activityModel.activityName,
          locationName: event.activityModel.locationName,
          shift_id: event.activityModel.shift_id,
          endTime: event.activityModel.endTime,
          isUploaded: isInternetAvailable
              ? UploadingStatues.success
              : event.activityModel.isUploaded,
          comments: event.activityModel.comments));
      event.data.activity.add(ActivityShiftModel(
          activityName: event.activityModel.activityName,
          locationName: event.activityModel.locationName,
          endTime: event.activityModel.endTime,
          isUploaded: isInternetAvailable
              ? UploadingStatues.success
              : event.activityModel.isUploaded,
          comments: event.activityModel.comments));

      emit(ActivityLoaded(data: event.data, newDataAdded: true));
    });
    on<DeleteActivity>((event, emit) async {
      emit(ActivityInitial());

      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        if (event.statues != UploadingStatues.success) {
        } else {
          await DatabaseService().deleteActivityDate(
              id: event.activityModel.shift_id.toString(),
              activityShiftModel: ActivityShiftModel(
                  activityName: event.activityModel.activityName,
                  locationName: event.activityModel.locationName,
                  endTime: event.activityModel.endTime,
                  isUploaded: UploadingStatues.success,
                  comments: event.activityModel.comments));
        }
      }
      await DatabaseHelper.instance.deleteActivityData(ActivityModel(
          activityName: event.activityModel.activityName,
          locationName: event.activityModel.locationName,
          shift_id: event.activityModel.shift_id,
          endTime: event.activityModel.endTime,
          isUploaded: UploadingStatues.success,
          comments: event.activityModel.comments));
      event.data.activity.removeWhere((element) =>
          element.endTime == event.activityModel.endTime &&
          element.locationName == event.activityModel.locationName &&
          element.comments == event.activityModel.comments &&
          element.activityName == event.activityModel.activityName);

      emit(ActivityLoaded(data: event.data, newDataAdded: true));
    });
    on<ShowActivityList>((event, emit) async {
      emit(ActivityLoaded(data: event.data, newDataAdded: false));
    });
  }
}
