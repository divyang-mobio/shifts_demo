import 'package:shifts_demo/models/shift_activity_model.dart';

class ScreenArguments {
  final ShiftActivityModel data;
  final bool isUpdate;
  final ActivityShiftModel? activityData;

  ScreenArguments(
      {required this.isUpdate, required this.data, this.activityData});
}
