import 'package:json_annotation/json_annotation.dart';
import '../resources/list_resources.dart';

part 'shift_data_model.g.dart';

@JsonSerializable()
class ShiftData {
  String id;
  String projectName, memberName, date;
  @JsonKey(fromJson: _fromUploadJson, toJson: _toUploadJson)
  UploadingStatues isUploaded;

  ShiftData(
      {required this.id,
      required this.projectName,
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

  factory ShiftData.fromJson(Map<String, dynamic> json) =>
      _$ShiftDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftDataToJson(this);
}

UploadingStatues statueCheckerFromJson(int data) {
  switch (data) {
    case 1:
      return UploadingStatues.success;
    case 2:
      return UploadingStatues.notUploaded;
    case 3:
      return UploadingStatues.update;
    case 4:
      return UploadingStatues.delete;
    default:
      return UploadingStatues.notUploaded;
  }
}

int statueCheckerToJson(UploadingStatues data) {
  switch (data) {
    case UploadingStatues.success:
      return 1;
    case UploadingStatues.notUploaded:
      return 2;
    case UploadingStatues.update:
      return 3;
    case UploadingStatues.delete:
      return 4;
    default:
      return 2;
  }
}
