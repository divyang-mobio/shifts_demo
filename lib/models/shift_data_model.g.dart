// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShiftData _$ShiftDataFromJson(Map<String, dynamic> json) => ShiftData(
      id: json['id'] as int?,
      projectName: json['projectName'] as String,
      isUploaded: ShiftData._fromIsUploadJson(json['isUploaded'] as int),
      memberName: json['memberName'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$ShiftDataToJson(ShiftData instance) => <String, dynamic>{
      'id': instance.id,
      'projectName': instance.projectName,
      'memberName': instance.memberName,
      'date': instance.date,
      'isUploaded': ShiftData._toIsUploadJson(instance.isUploaded),
    };
