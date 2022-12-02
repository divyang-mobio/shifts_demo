part of 'activity_bloc.dart';

abstract class ActivityEvent {}

class AddActivity extends ActivityEvent {
  ShiftActivityModel data;
  ActivityModel activityModel;

  AddActivity({required this.data, required this.activityModel});
}

class UpdateActivity extends ActivityEvent {
  ShiftActivityModel data;
  ActivityModel activityModel;
  UploadingStatues statues;
  int index;

  UpdateActivity(
      {required this.data,
      required this.index,
      required this.activityModel,
      required this.statues});
}

class DeleteActivity extends ActivityEvent {
  ShiftActivityModel data;
  ActivityModel activityModel;
  UploadingStatues statues;

  DeleteActivity(
      {required this.data, required this.activityModel, required this.statues});
}

class ShowActivityList extends ActivityEvent {
  ShiftActivityModel data;

  ShowActivityList({required this.data});
}
