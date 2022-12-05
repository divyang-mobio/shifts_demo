import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shifts_demo/controller/activity_bloc/activity_bloc.dart';
import 'package:shifts_demo/models/activity_model.dart';
import 'package:shifts_demo/widgets/common_widgets.dart';
import '../models/shift_activity_model.dart';
import '../resources/list_resources.dart';
import '../utils/internet_checker.dart';
import '../widgets/alert_box.dart';

class NewActivitiesScreen extends StatefulWidget {
  const NewActivitiesScreen(
      {Key? key,
      required this.data,
      required this.isUpdate,
      this.index,
      this.activityShiftModel})
      : super(key: key);

  final ShiftActivityModel data;
  final bool isUpdate;
  final int? index;
  final ActivityShiftModel? activityShiftModel;

  @override
  State<NewActivitiesScreen> createState() => _NewActivitiesScreenState();
}

class _NewActivitiesScreenState extends State<NewActivitiesScreen> {
  String? activityName, locationName, endTime;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    if (widget.isUpdate) {
      activityName = widget.activityShiftModel?.activityName;
      locationName = widget.activityShiftModel?.locationName;
      endTime = widget.activityShiftModel?.endTime;
      _controller.text = (widget.activityShiftModel?.comments).toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isUpdate ? "Update Activity" : "New Activity"),
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
              subTitle: (endTime == null) ? 'Required' : endTime!,
              onTap: () async {
            DateTime? dateTime = await dateTimeWidgets(context);
            if (dateTime != null) {
              endTime = DateFormat('dd MMM, kk:mm').format(dateTime);
              setState(() {});
            }
          }, isTrailing: false),
          textFieldWidget(context,
              controller: _controller,
              leadingIcon: Icons.person,
              title: 'Member',
              hintText: 'Required'),
          const SizedBox(height: 20),
          materialButton(context, onPressed: () async {
            if (widget.isUpdate) {
              if (_controller.text.trim() !=
                      widget.activityShiftModel?.comments ||
                  endTime != widget.activityShiftModel?.endTime ||
                  locationName != widget.activityShiftModel?.locationName ||
                  activityName != widget.activityShiftModel?.activityName) {
                if (await InternetChecker().connectionCheck()) {
                  BlocProvider.of<ActivityBloc>(context).add(UpdateActivity(
                      index: widget.index as int,
                      statues: widget.activityShiftModel?.isUploaded
                          as UploadingStatues,
                      data: widget.data,
                      activityModel: ActivityModel(
                          id: widget.activityShiftModel?.id,
                          shift_id: widget.data.id.toString(),
                          activityName: activityName!,
                          locationName: locationName!,
                          endTime: endTime!,
                          comments: _controller.text,
                          isUploaded: UploadingStatues.update)));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No Internet')));
                }
              }
            } else {
              if (_controller.text != "" &&
                  endTime != null &&
                  locationName != null &&
                  activityName != null) {
                BlocProvider.of<ActivityBloc>(context).add(AddActivity(
                    data: widget.data,
                    activityModel: ActivityModel(
                        shift_id: widget.data.id.toString(),
                        activityName: activityName!,
                        locationName: locationName!,
                        endTime: endTime!,
                        comments: _controller.text.trim(),
                        isUploaded: UploadingStatues.notUploaded)));
                Navigator.pop(context);
              }
            }
          }, title: widget.isUpdate ? 'Update' : 'Log'),
          const SizedBox(height: 20),
          if (widget.isUpdate)
            materialButton(context, onPressed: () async {
              final deleteData = await alertDialog(
                  context, 'Confirm', "Are you sure to delete Activity");
              if (deleteData) {
                if (await InternetChecker().connectionCheck()) {
                  BlocProvider.of<ActivityBloc>(context).add(DeleteActivity(
                      data: widget.data,
                      activityModel: ActivityModel(
                          id: widget.activityShiftModel?.id,
                          shift_id: widget.data.id.toString(),
                          activityName: activityName!,
                          locationName: locationName!,
                          endTime: endTime!,
                          comments: _controller.text.trim(),
                          isUploaded: UploadingStatues.delete),
                      statues: widget.activityShiftModel?.isUploaded
                          as UploadingStatues));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No Internet')));
                }
              }
            }, title: 'Delete', color: const Color.fromARGB(255, 210, 10, 17))
        ]),
      ),
    );
  }
}
