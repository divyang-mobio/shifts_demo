import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  String activityName, locationName, comments;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime endTime;

  ActivityModel(
      {required this.activityName,
      required this.locationName,
      required this.endTime,
      required this.comments});

  static DateTime _fromJson(Timestamp date) {
    DateTime dataTime = DateTime.parse(date.toDate().toString());
    return dataTime;
  }

  static DateTime _toJson(DateTime date) {
    return date;
  }

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
