import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shifts_demo/models/shift_data_model.dart';

import '../resources/list_resources.dart';
import '../utils/firestore_service.dart';

class NewShiftScreen extends StatefulWidget {
  const NewShiftScreen({Key? key}) : super(key: key);

  @override
  State<NewShiftScreen> createState() => _NewShiftScreenState();
}

class _NewShiftScreenState extends State<NewShiftScreen> {
  String? projectName;
  DateTime? dateTime;
  final TextEditingController _controller = TextEditingController();

  listTile(
      {required IconData leadingIcon,
      required bool isTrailing,
      String subTitle = 'Required',
      required GestureTapCallback onTap,
      required String title}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ListTile(
              leading: Icon(leadingIcon,
                  size: 35, color: Theme.of(context).hintColor),
              title: Text(title, style: Theme.of(context).textTheme.headline6),
              subtitle: Text(subTitle, style: const TextStyle(fontSize: 17)),
              trailing: isTrailing
                  ? const Icon(Icons.keyboard_arrow_down, size: 35)
                  : null),
        ),
        Divider(
          thickness: 1,
          indent: MediaQuery.of(context).size.width * .17,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }

  textFieldWidget(
      {required IconData leadingIcon,
      required String hintText,
      required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(leadingIcon, size: 35, color: Theme.of(context).hintColor),
        const SizedBox(width: 20),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800)),
              const SizedBox(height: 10),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: hintText)),
              )
            ]),
      ]),
    );
  }

  Future<dynamic> bottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: bottomSheetData
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: MaterialButton(
                            shape: const Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 1)),
                            child: Text(e),
                            onPressed: () => Navigator.pop(context, e),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("New Shifts"),
          backgroundColor: const Color.fromARGB(255, 255, 140, 0)),
      body: SingleChildScrollView(
        child: Column(children: [
          listTile(
              leadingIcon: Icons.settings,
              title: 'Project',
              subTitle:
                  (projectName == null) ? 'Required' : projectName.toString(),
              onTap: () async {
                final h = await bottomSheet();
                if (h != null) {
                  projectName = h;
                  setState(() {});
                }
              },
              isTrailing: true),
          listTile(
              leadingIcon: Icons.access_time_rounded,
              title: 'Start',
              subTitle: (dateTime == null)
                  ? 'Required'
                  : DateFormat('dd MMM, kk:mm').format(dateTime!),
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(DateTime.now().year + 10));
                if (date != null) {
                  TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: DateTime.now().hour,
                          minute: DateTime.now().minute));
                  if (time != null) {
                    dateTime = DateTime(date.year, date.month, date.day,
                        time.hour, time.minute);
                    setState(() {});
                  }
                }
              },
              isTrailing: false),
          textFieldWidget(
              leadingIcon: Icons.person, title: 'Member', hintText: 'Required'),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * .9,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                textColor: Colors.white,
                color: const Color.fromARGB(255, 0, 158, 61),
                onPressed: () {
                  if (_controller.text != "" &&
                      dateTime != null &&
                      projectName != null) {
                    DatabaseService().setShiftDate(
                        projectName: projectName!,
                        memberName: _controller.text,
                        dateTime: dateTime!);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Start",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          )
        ]),
      ),
    );
  }
}
