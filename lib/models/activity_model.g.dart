// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      activityName: json['activityName'] as String,
      locationName: json['locationName'] as String,
      shift_id: json['shift_id'] as String,
      endTime: json['endTime'] as String,
      isUploaded: ActivityModel._fromIsUploadJson(json['isUploaded'] as int),
      comments: json['comments'] as String,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'activityName': instance.activityName,
      'locationName': instance.locationName,
      'comments': instance.comments,
      'endTime': instance.endTime,
      'shift_id': instance.shift_id,
      'isUploaded': ActivityModel._toIsUploadJson(instance.isUploaded),
    };
