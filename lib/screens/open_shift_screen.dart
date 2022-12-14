import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/activity_bloc/activity_bloc.dart';
import '../resources/list_resources.dart';
import '../controller/open_shift_bloc/open_shift_bloc.dart';
import '../models/screen_args_model.dart';

class OpenShiftListScreen extends StatefulWidget {
  const OpenShiftListScreen({Key? key}) : super(key: key);

  @override
  State<OpenShiftListScreen> createState() => _OpenShiftListScreenState();
}

class _OpenShiftListScreenState extends State<OpenShiftListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Open Shifts"),
            backgroundColor: const Color.fromARGB(255, 255, 140, 0),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/newShift',
                        arguments: ShiftScreenArguments(
                            isUpdate: false));
                  },
                  icon: const Icon(Icons.add))
            ]),
        body: BlocConsumer<OpenShiftBloc, OpenShiftState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OpenShiftLoaded) {
              return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          if (state.data[index].isUploaded ==
                              UploadingStatues.success) {
                            BlocProvider.of<ActivityBloc>(context)
                                .add(ShowActivityList(data: state.data[index]));
                            Navigator.pushNamed(context, '/Activity',
                                arguments: state.data[index]);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Sync Data First')));
                          }
                        },
                        child: ListTile(
                          shape: const Border(
                              bottom: BorderSide(color: Colors.grey, width: 1)),
                          title: Text(
                            "${state.data[index].projectName} : ${state.data[index].memberName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Text(state.data[index].date,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          trailing: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 0, 158, 61),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              child: Text(
                                  '${state.data[index].activity.length}',
                                  style: const TextStyle(color: Colors.white))),
                        ),
                      ));
            } else {
              return const CircularProgressIndicator.adaptive();
            }
          },
        ));
  }
}
