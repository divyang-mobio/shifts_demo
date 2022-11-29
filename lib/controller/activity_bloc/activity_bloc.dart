import 'package:bloc/bloc.dart';
import 'package:shifts_demo/models/shift_data_model.dart';

import '../../models/activity_model.dart';
import '../../utils/firestore_service.dart';
import '../../utils/local_database.dart';

part 'activity_event.dart';

part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    on<AddActivity>((event, emit) async {
      emit(ActivityInitial());

      await DatabaseHelper.instance.addActivityData(event.activityModel);
      // DatabaseService().setActivityDate(
      //     id: event.data.id!, activityModel: event.activityModel);
      // event.data.activity.add(event.activityModel);
      List<ActivityModel> data =
          await DatabaseHelper.instance.getActivityData();

      emit(ActivityLoaded(data: data, newDataAdded: false));
    });
    on<ShowActivityList>((event, emit) async {
      List<ActivityModel> data =
          await DatabaseHelper.instance.getActivityData();
      emit(ActivityLoaded(data: data, newDataAdded: false));
    });
  }
}
