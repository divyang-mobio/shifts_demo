import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shifts_demo/controller/activity_bloc/activity_bloc.dart';
import 'package:shifts_demo/controller/open_shift_bloc/open_shift_bloc.dart';
import '../models/shift_data_model.dart';
import '../widgets/common_widgets.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key, required this.data}) : super(key: key);

  final ShiftData data;

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Activities"),
          backgroundColor: const Color.fromARGB(255, 38, 89, 153),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.info_outline_rounded)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/newActivities',
                      arguments: widget.data);
                },
                icon: const Icon(Icons.add))
          ]),
      body: Column(
        children: [
          BlocConsumer<ActivityBloc, ActivityState>(
            listener: (context, state) {
              if (state is ActivityLoaded) {
                if (state.newDataAdded) {
                  BlocProvider.of<OpenShiftBloc>(context).add(GetData());
                }
              }
            },
            builder: (context, state) {
              if (state is ActivityLoaded) {
                return Text(state.data.length.toString());
                // return ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: state.data.activity?.length,
                //   itemBuilder: (context, index) => ListTile(
                //     shape: const Border(
                //         bottom: BorderSide(color: Colors.grey, width: 1)),
                //     leading: Container(
                //         padding: const EdgeInsets.all(8),
                //         decoration: const BoxDecoration(
                //             color: Color.fromARGB(255, 0, 158, 61),
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(40))),
                //         child: const Text('50%',
                //             style: TextStyle(color: Colors.white))),
                //     title: Text(state.data.activity![index].activityName,
                //         style: const TextStyle(fontSize: 20)),
                //     subtitle: Text(state.data.activity![index].endTime,
                //         style: const TextStyle(color: Colors.black)),
                //   ),
                // );
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          ),
          const SizedBox(height: 20),
          materialButton(context,
              onPressed: () {},
              title: 'Close Shift',
              color: const Color.fromARGB(255, 244, 151, 17)),
          const SizedBox(height: 20),
          materialButton(context,
              onPressed: () {},
              title: 'Delete Shift',
              color: const Color.fromARGB(255, 210, 10, 17))
        ],
      ),
    );
  }
}
