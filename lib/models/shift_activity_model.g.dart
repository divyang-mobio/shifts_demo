// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftActivityModel _$ShiftActivityModelFromJson(Map<String, dynamic> json) =>
    ShiftActivityModel(
      id: json['id'] as String?,
      projectName: json['projectName'] as String,
      activity: (json['activity'] as List<dynamic>)
          .map((e) => ActivityShiftModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isUploaded:
          ShiftActivityModel._fromIsUploadJson(json['isUploaded'] as int),
      memberName: json['memberName'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ShiftActivityModelToJson(ShiftActivityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activity': instance.activity,
      'projectName': instance.projectName,
      'memberName': instance.memberName,
      'date': instance.date,
      'isUploaded': ShiftActivityModel._toIsUploadJson(instance.isUploaded),
    };

ActivityShiftModel _$ActivityShiftModelFromJson(Map<String, dynamic> json) =>
    ActivityShiftModel(
      activityName: json['activityName'] as String,
      locationName: json['locationName'] as String,
      endTime: json['endTime'] as String,
      isUploaded:
          ActivityShiftModel._fromIsUploadJson(json['isUploaded'] as int),
      comments: json['comments'] as String,
    );

Map<String, dynamic> _$ActivityShiftModelToJson(ActivityShiftModel instance) =>
    <String, dynamic>{
      'activityName': instance.activityName,
      'locationName': instance.locationName,
      'comments': instance.comments,
      'endTime': instance.endTime,
      'isUploaded': ActivityShiftModel._toIsUploadJson(instance.isUploaded),
    };
