import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../controller/open_shift_bloc/open_shift_bloc.dart';
import '../models/shift_activity_model.dart';
import '../resources/list_resources.dart';
import '../widgets/common_widgets.dart';

class NewShiftScreen extends StatefulWidget {
  const NewShiftScreen({Key? key, this.data, required this.isUpdate})
      : super(key: key);

  final ShiftActivityModel? data;
  final bool isUpdate;

  @override
  State<NewShiftScreen> createState() => _NewShiftScreenState();
}

class _NewShiftScreenState extends State<NewShiftScreen> {
  String? projectName, dateTime;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    setShiftData();
    super.initState();
  }

  setShiftData() {
    if (widget.isUpdate) {
      projectName = widget.data?.projectName;
      dateTime = widget.data?.date;
      _controller.text = (widget.data?.memberName).toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isUpdate ? "Update Shifts" : "New Shifts"),
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
              subTitle: (dateTime == null) ? 'Required' : dateTime!,
              onTap: () async {
            DateTime? startTime = await dateTimeWidgets(context);
            if (startTime != null) {
              dateTime = DateFormat('dd MMM, kk:mm').format(startTime);
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
            if (widget.isUpdate) {
              BlocProvider.of<OpenShiftBloc>(context).add(UpdateShift(
                  status: widget.data?.isUploaded == UploadingStatues.success
                      ? UploadingStatues.update
                      : UploadingStatues.notUploaded,
                  dateTime: dateTime!,
                  projectName: projectName!,
                  memberName: _controller.text.trim(),
                  id: (widget.data?.id).toString()));
              Navigator.pop(context);
            } else {
              if (_controller.text != "" &&
                  dateTime != null &&
                  projectName != null) {
                BlocProvider.of<OpenShiftBloc>(context).add(UpLoadData(
                    dateTime: dateTime!,
                    projectName: projectName!,
                    memberName: _controller.text.trim()));
                Navigator.pop(context);
              }
            }
          }, title: widget.isUpdate ? 'Update' : 'Start')
        ]),
      ),
    );
  }
}
