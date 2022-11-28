part of 'activity_bloc.dart';

abstract class ActivityEvent {}

class AddActivity extends ActivityEvent {
  ShiftData data;
  ActivityModel activityModel;

  AddActivity({required this.data, required this.activityModel});
}

class ShowActivityList extends ActivityEvent {
  ShiftData data;

  ShowActivityList({required this.data});
}
