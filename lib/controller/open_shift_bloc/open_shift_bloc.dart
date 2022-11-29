import 'package:bloc/bloc.dart';
import 'package:shifts_demo/models/shift_data_model.dart';
import 'package:shifts_demo/utils/firestore_service.dart';
import 'package:shifts_demo/utils/local_database.dart';

part 'open_shift_event.dart';

part 'open_shift_state.dart';

class OpenShiftBloc extends Bloc<OpenShiftEvent, OpenShiftState> {
  OpenShiftBloc() : super(OpenShiftInitial()) {
    on<GetData>((event, emit) async {
      List<ShiftData> data = await DatabaseHelper.instance.getShiftData();
      // List<ShiftData> data = await DatabaseService().getShift();
      emit(OpenShiftLoaded(data: data));
    });

    on<UpLoadData>((event, emit) async {
      emit(OpenShiftInitial());
      await DatabaseHelper.instance.addShiftData(ShiftData(
          projectName: event.projectName,
          // activity: null,
          isUploaded: false,
          memberName: event.memberName,
          date: event.dateTime));

      // bool isUploaded = await DatabaseService().setShiftDate(
      //     projectName: event.projectName,
      //     memberName: event.memberName,
      //     dateTime: event.dateTime);
      // if (isUploaded) {
      List<ShiftData> data = await DatabaseHelper.instance.getShiftData();
      // List<ShiftData> data = await DatabaseService().getShift();
      emit(OpenShiftLoaded(data: data));
      // }
    });
  }
}
