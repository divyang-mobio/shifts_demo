// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftData _$ShiftDataFromJson(Map<String, dynamic> json) => ShiftData(
      id: json['id'] as String?,
      projectName: json['projectName'] as String,
      activity: (json['activity'] as List<dynamic>)
          .map((e) => ActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      memberName: json['memberName'] as String,
      date: ShiftData._fromJson(json['date'] as Timestamp),
    );

Map<String, dynamic> _$ShiftDataToJson(ShiftData instance) => <String, dynamic>{
      'id': instance.id,
      'activity': instance.activity,
      'projectName': instance.projectName,
      'memberName': instance.memberName,
      'date': ShiftData._toJson(instance.date),
    };
