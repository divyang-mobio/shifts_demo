import 'package:bloc/bloc.dart';
import 'package:shifts_demo/models/shift_data_model.dart';

import '../../models/activity_model.dart';
import '../../utils/firestore_service.dart';

part 'activity_event.dart';

part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityInitial()) {
    on<AddActivity>((event, emit) {
      emit(ActivityInitial());
      DatabaseService().setActivityDate(
          id: event.data.id!, activityModel: event.activityModel);
      event.data.activity.add(event.activityModel);
      emit(ActivityLoaded(data: event.data, newDataAdded: true));
    });
    on<ShowActivityList>((event, emit) {
      emit(ActivityLoaded(data: event.data, newDataAdded: false));
    });
  }
}
