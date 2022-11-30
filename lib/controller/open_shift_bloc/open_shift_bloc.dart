import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:shifts_demo/models/shift_activity_model.dart';
import 'package:shifts_demo/models/shift_data_model.dart';
import 'package:shifts_demo/utils/local_database.dart';

import '../../utils/firestore_service.dart';
import '../../utils/internet_checker.dart';

part 'open_shift_event.dart';

part 'open_shift_state.dart';

class OpenShiftBloc extends Bloc<OpenShiftEvent, OpenShiftState> {
  OpenShiftBloc() : super(OpenShiftInitial()) {
    on<GetData>((event, emit) async {
      List<ShiftActivityModel> data =
          await DatabaseHelper.instance.getShiftActivityData();
      // List<ShiftData> data = await DatabaseService().getShift();
      emit(OpenShiftLoaded(data: data));
    });

    on<UpLoadData>((event, emit) async {
      emit(OpenShiftInitial());

      final isInternetAvailable = await InternetChecker().connectionCheck();

      if (isInternetAvailable) {
        await DatabaseService().setShiftDate(
            shiftActivityModel: ShiftActivityModel(
                activity: [],
                isUploaded: true,
                projectName: event.projectName,
                memberName: event.memberName,
                date: event.dateTime));
      }
      await DatabaseHelper.instance.addShiftData(ShiftData(
          id: Random().nextInt(200),
          projectName: event.projectName,
          isUploaded: isInternetAvailable,
          memberName: event.memberName,
          date: event.dateTime));

      List<ShiftActivityModel> data =
          await DatabaseHelper.instance.getShiftActivityData();
      emit(OpenShiftLoaded(data: data));
      // }
    });
  }
}
