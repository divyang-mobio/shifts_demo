part of 'open_shift_bloc.dart';

abstract class OpenShiftEvent {}

class GetData extends OpenShiftEvent {}

class UpLoadData extends OpenShiftEvent {
  String projectName, memberName;
  DateTime dateTime;

  UpLoadData(
      {required this.dateTime,
      required this.projectName,
      required this.memberName});
}
