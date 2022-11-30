import 'package:bloc/bloc.dart';
import '../../models/activity_model.dart';
import '../../models/shift_activity_model.dart';
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
                isUploaded: true,
                comments: event.activityModel.comments));
      }
      await DatabaseHelper.instance.addActivityData(ActivityModel(
          activityName: event.activityModel.activityName,
          locationName: event.activityModel.locationName,
          shift_id: event.activityModel.shift_id,
          endTime: event.activityModel.endTime,
          isUploaded: isInternetAvailable,
          comments: event.activityModel.comments));
      event.data.activity.add(ActivityShiftModel(
          activityName: event.activityModel.activityName,
          locationName: event.activityModel.locationName,
          endTime: event.activityModel.endTime,
          isUploaded: isInternetAvailable,
          comments: event.activityModel.comments));

      emit(ActivityLoaded(data: event.data, newDataAdded: true));
    });
    on<ShowActivityList>((event, emit) async {
      emit(ActivityLoaded(data: event.data, newDataAdded: false));
    });
  }
}
