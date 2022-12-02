import 'package:shifts_demo/models/shift_activity_model.dart';

class ScreenArguments {
  final ShiftActivityModel data;
  final bool isUpdate;
  final ActivityShiftModel? activityData;
  final int? index;

  ScreenArguments(
      {required this.isUpdate,
      this.index,
      required this.data,
      this.activityData});
}
