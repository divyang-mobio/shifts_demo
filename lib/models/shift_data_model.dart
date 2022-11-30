import 'package:json_annotation/json_annotation.dart';

part 'shift_data_model.g.dart';

@JsonSerializable()
class ShiftData {
  int id;
  String projectName, memberName, date;
  @JsonKey(fromJson: _fromIsUploadJson, toJson: _toIsUploadJson)
  bool isUploaded;

  ShiftData(
      {required this.id,
      required this.projectName,
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

  factory ShiftData.fromJson(Map<String, dynamic> json) =>
      _$ShiftDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftDataToJson(this);
}
