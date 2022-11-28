// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityModel _$ActivityModelFromJson(Map<String, dynamic> json) =>
    ActivityModel(
      activityName: json['activityName'] as String,
      locationName: json['locationName'] as String,
      endTime: ActivityModel._fromJson(json['endTime'] as Timestamp),
      comments: json['comments'] as String,
    );

Map<String, dynamic> _$ActivityModelToJson(ActivityModel instance) =>
    <String, dynamic>{
      'activityName': instance.activityName,
      'locationName': instance.locationName,
      'comments': instance.comments,
      'endTime': ActivityModel._toJson(instance.endTime),
    };
