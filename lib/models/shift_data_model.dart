import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shifts_demo/models/activity_model.dart';

part 'shift_data_model.g.dart';

@JsonSerializable()
class ShiftData {
  String? id;
  List<ActivityModel> activity;
  String projectName, memberName;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime date;

  ShiftData(
      {this.id,
      required this.projectName,
      required this.activity,
      required this.memberName,
      required this.date});

  static DateTime _fromJson(Timestamp date) {
    DateTime dataTime = DateTime.parse(date.toDate().toString());
    return dataTime;
  }

  static DateTime _toJson(DateTime date) {
    return date;
  }


  factory ShiftData.fromJson(Map<String, dynamic> json) =>
      _$ShiftDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftDataToJson(this);
}
