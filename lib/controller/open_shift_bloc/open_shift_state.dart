part of 'open_shift_bloc.dart';

abstract class OpenShiftState {}

class OpenShiftInitial extends OpenShiftState {}

class OpenShiftLoaded extends OpenShiftState {
  List<ShiftActivityModel> data;
  bool isInternetConnected;

  OpenShiftLoaded({required this.data, required this.isInternetConnected});
}

class OpenShiftError extends OpenShiftState {}
