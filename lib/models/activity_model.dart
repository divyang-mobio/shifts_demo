import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  String activityName, locationName, comments, endTime, shift_id;
  @JsonKey(fromJson: _fromIsUploadJson, toJson: _toIsUploadJson)
  bool isUploaded;

  ActivityModel(
      {required this.activityName,
      required this.locationName,
      required this.shift_id,
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

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
