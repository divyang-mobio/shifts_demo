part of 'activity_bloc.dart';

abstract class ActivityEvent {}

class AddActivity extends ActivityEvent {
  ShiftActivityModel data;
  ActivityModel activityModel;

  AddActivity({required this.data, required this.activityModel});
}

class ShowActivityList extends ActivityEvent {
  ShiftActivityModel data;

  ShowActivityList({required this.data});
}
