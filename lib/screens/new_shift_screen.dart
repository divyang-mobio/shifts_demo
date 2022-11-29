import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shifts_demo/controller/open_shift_bloc/open_shift_bloc.dart';
import '../resources/list_resources.dart';
import '../utils/firestore_service.dart';
import '../widgets/common_widgets.dart';

class NewShiftScreen extends StatefulWidget {
  const NewShiftScreen({Key? key}) : super(key: key);

  @override
  State<NewShiftScreen> createState() => _NewShiftScreenState();
}

class _NewShiftScreenState extends State<NewShiftScreen> {
  String? projectName;
  DateTime? dateTime;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("New Shifts"),
          backgroundColor: const Color.fromARGB(255, 255, 140, 0)),
      body: SingleChildScrollView(
        child: Column(children: [
          listTile(context,
              leadingIcon: Icons.settings,
              title: 'Project',
              subTitle: (projectName == null)
                  ? 'Required'
                  : projectName.toString(), onTap: () async {
            final h = await bottomSheet(context, data: bottomSheetShiftData);
            if (h != null) {
              projectName = h;
              setState(() {});
            }
          }, isTrailing: true),
          listTile(context,
              leadingIcon: Icons.access_time_rounded,
              title: 'Start',
              subTitle: (dateTime == null)
                  ? 'Required'
                  : DateFormat('dd MMM, kk:mm').format(dateTime!),
              onTap: () async {
            dateTime = await dateTimeWidgets(context);
            if (dateTime != null) {
              setState(() {});
            }
          }, isTrailing: false),
          textFieldWidget(context,
              controller: _controller,
              leadingIcon: Icons.person,
              title: 'Member',
              hintText: 'Required'),
          const SizedBox(height: 20),
          materialButton(context, onPressed: () {
            if (_controller.text != "" &&
                dateTime != null &&
                projectName != null) {
              BlocProvider.of<OpenShiftBloc>(context).add(UpLoadData(
                  dateTime: DateFormat('dd MMM, kk:mm').format(dateTime!),
                  projectName: projectName!,
                  memberName: _controller.text));
              Navigator.pop(context);
            }
          }, title: 'Start')
        ]),
      ),
    );
  }
}
