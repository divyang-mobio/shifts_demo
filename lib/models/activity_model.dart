import 'package:json_annotation/json_annotation.dart';
import 'package:shifts_demo/models/shift_data_model.dart';

import '../resources/list_resources.dart';

part 'activity_model.g.dart';

@JsonSerializable()
class ActivityModel {
  String activityName, locationName, comments, endTime, shift_id;
  @JsonKey(fromJson: _fromUploadJson, toJson: _toUploadJson)
  UploadingStatues isUploaded;

  ActivityModel(
      {required this.activityName,
      required this.locationName,
      required this.shift_id,
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

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityModelToJson(this);
}
