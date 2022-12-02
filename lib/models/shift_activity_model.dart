import 'package:json_annotation/json_annotation.dart';
import 'package:shifts_demo/models/shift_data_model.dart';

import '../resources/list_resources.dart';

part 'shift_activity_model.g.dart';

@JsonSerializable()
class ShiftActivityModel {
  String? id;
  List<ActivityShiftModel> activity;
  String projectName, memberName, date;
  @JsonKey(fromJson: _fromUploadJson, toJson: _toUploadJson)
  UploadingStatues isUploaded;

  ShiftActivityModel(
      {this.id,
      required this.projectName,
      required this.activity,
      required this.isUploaded,
      required this.memberName,
      required this.date});

  static UploadingStatues _fromUploadJson(int data) {
    UploadingStatues statues = statueCheckerFromJson(data);
    return statues;
  }

  static int _toUploadJson(UploadingStatues data) {
    int statues = statueCheckerToJson(data);
    return statues;
  }

  factory ShiftActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ShiftActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftActivityModelToJson(this);
}

@JsonSerializable()
class ActivityShiftModel {
  int? id;
  String activityName, locationName, comments, endTime;
  @JsonKey(fromJson: _fromUploadJson, toJson: _toUploadJson)
  UploadingStatues isUploaded;

  ActivityShiftModel(
      {required this.activityName,
      this.id,
      required this.locationName,
      required this.endTime,
      required this.isUploaded,
      required this.comments});

  static UploadingStatues _fromUploadJson(int data) {
    UploadingStatues statues = statueCheckerFromJson(data);
    return statues;
  }

  static int _toUploadJson(UploadingStatues data) {
    int statues = statueCheckerToJson(data);
    return statues;
  }

  factory ActivityShiftModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityShiftModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityShiftModelToJson(this);
}
