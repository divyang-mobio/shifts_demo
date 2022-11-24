import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shifts_demo/models/shift_data_model.dart';
import 'package:shifts_demo/utils/firestore_service.dart';

import '../resources/list_resources.dart';

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
                  Navigator.pushNamed(context, '/newShift');
                },
                icon: const Icon(Icons.add))
          ]),
      body: StreamBuilder<List<ShiftData>>(
          stream: DatabaseService().getShiftData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) => ListTile(
                          shape: const Border(
                              bottom: BorderSide(color: Colors.grey, width: 1)),
                          title: Text(
                            "${snapshot.data?[index].projectName} : ${snapshot.data?[index].memberName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Text(
                              DateFormat('dd MMM, kk:mm')
                                  .format(snapshot.data?[index].date as DateTime),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          trailing: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 0, 158, 61),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              child: Text('${snapshot.data?[index].activity.length}',
                                  style: const TextStyle(color: Colors.white))),
                        ));
              } else {
                return const Text("No data");
              }
            } else {
              return const CircularProgressIndicator.adaptive();
            }
          }),
    );
  }
}
