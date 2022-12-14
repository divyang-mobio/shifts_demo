part of 'open_shift_bloc.dart';

abstract class OpenShiftEvent {}

class GetData extends OpenShiftEvent {}

class DataSynced extends OpenShiftEvent {}

class UpLoadData extends OpenShiftEvent {
  String projectName, memberName, dateTime;

  UpLoadData(
      {required this.dateTime,
      required this.projectName,
      required this.memberName});
}

class UpdateShift extends OpenShiftEvent {
  String projectName, memberName, dateTime, id;
  UploadingStatues status;

  UpdateShift(
      {required this.dateTime,
      required this.id,
      required this.status,
      required this.projectName,
      required this.memberName});
}
