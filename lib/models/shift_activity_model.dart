import 'package:json_annotation/json_annotation.dart';

part 'shift_activity_model.g.dart';

@JsonSerializable()
class ShiftActivityModel {
  String? id;
  List<ActivityShiftModel> activity;
  String projectName, memberName, date;
  @JsonKey(fromJson: _fromIsUploadJson, toJson: _toIsUploadJson)
  bool isUploaded;

  ShiftActivityModel(
      {this.id,
      required this.projectName,
      required this.activity,
      required this.isUploaded,
      required this.memberName,
      required this.date});

  static bool _fromIsUploadJson(int data) {
    bool isUploaded = (data == 0) ? false : true;
    return isUploaded;
  }

  static int _toIsUploadJson(bool data) {
    int isUploaded = (data) ? 1 : 0;
    return isUploaded;
  }

  factory ShiftActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftActivityModelToJson(this);
}

@JsonSerializable()
class ActivityShiftModel {
  String activityName, locationName, comments, endTime;
  @JsonKey(fromJson: _fromIsUploadJson, toJson: _toIsUploadJson)
  bool isUploaded;

  ActivityShiftModel(
      {required this.activityName,
      required this.locationName,
      required this.endTime,
      required this.isUploaded,
      required this.comments});

  static bool _fromIsUploadJson(int data) {
    bool isUploaded = (data == 0) ? false : true;
    return isUploaded;
  }

  static int _toIsUploadJson(bool data) {
    int isUploaded = (data) ? 1 : 0;
    return isUploaded;
  }

  factory ActivityShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityShiftModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityShiftModelToJson(this);
}

