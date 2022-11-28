part of 'activity_bloc.dart';

abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoaded extends ActivityState {
  ShiftData data;
  bool newDataAdded;

  ActivityLoaded({required this.data, required this.newDataAdded});
}

class ActivityError extends ActivityState {}
