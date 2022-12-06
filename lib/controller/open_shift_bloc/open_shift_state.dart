part of 'open_shift_bloc.dart';

abstract class OpenShiftState {}

class OpenShiftInitial extends OpenShiftState {}

class OpenShiftLoaded extends OpenShiftState {
  List<ShiftActivityModel> data;

  OpenShiftLoaded({required this.data});
}

class OpenShiftError extends OpenShiftState {}
