import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shifts_demo/controller/activity_bloc/activity_bloc.dart';
import 'package:shifts_demo/models/activity_model.dart';
import 'package:shifts_demo/models/shift_data_model.dart';
import 'package:shifts_demo/widgets/common_widgets.dart';
import '../resources/list_resources.dart';

class NewActivitiesScreen extends StatefulWidget {
  const NewActivitiesScreen({Key? key, required this.data}) : super(key: key);

  final ShiftData data;

  @override
  State<NewActivitiesScreen> createState() => _NewActivitiesScreenState();
}

class _NewActivitiesScreenState extends State<NewActivitiesScreen> {
  String? activityName, locationName;
  DateTime? endTime;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("New Activities"),
          backgroundColor: const Color.fromARGB(255, 0, 158, 61)),
      body: SingleChildScrollView(
        child: Column(children: [
          listTile(context,
              leadingIcon: Icons.directions_run_outlined,
              title: 'Activity',
              subTitle: (activityName == null)
                  ? 'Required'
                  : activityName.toString(), onTap: () async {
            activityName =
                await bottomSheet(context, data: bottomSheetActivityData);
            if (activityName != null) {
              setState(() {});
            }
          }, isTrailing: true),
          listTile(context,
              leadingIcon: Icons.edit_location,
              title: 'Location',
              subTitle: (locationName == null)
                  ? 'Required'
                  : locationName.toString(), onTap: () async {
            locationName =
                await bottomSheet(context, data: bottomSheetLocationData);
            if (locationName != null) {
              setState(() {});
            }
          }, isTrailing: true),
          listTile(context,
              leadingIcon: Icons.access_time_rounded,
              title: 'End Time',
              subTitle: (endTime == null)
                  ? 'Required'
                  : DateFormat('dd MMM, kk:mm').format(endTime!),
              onTap: () async {
            endTime = await dateTimeWidgets(context);
            if (endTime != null) {
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
                endTime != null &&
                locationName != null &&
                activityName != null) {
              BlocProvider.of<ActivityBloc>(context, listen: false).add(AddActivity(
                  data: widget.data,
                  activityModel: ActivityModel(
                      activityName: activityName!,
                      locationName: locationName!,
                      endTime: endTime!,
                      comments: _controller.text)));
              Navigator.pop(context);
            }
          }, title: 'Log')
        ]),
      ),
    );
  }
}
