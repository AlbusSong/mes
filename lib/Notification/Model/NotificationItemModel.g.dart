// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationItemModel _$NotificationItemModelFromJson(
    Map<String, dynamic> json) {
  return NotificationItemModel(
    json['PushCode'] as String,
    json['PushType'] as int,
    json['PushSubject'] as String,
    json['PushText'] as String,
    json['PushFunctionCode'] as String,
    json['PushStatus'] as int,
  )..CreateTime = json['CreateTime'] as String;
}

Map<String, dynamic> _$NotificationItemModelToJson(
        NotificationItemModel instance) =>
    <String, dynamic>{
      'PushCode': instance.PushCode,
      'PushType': instance.PushType,
      'PushSubject': instance.PushSubject,
      'PushText': instance.PushText,
      'PushFunctionCode': instance.PushFunctionCode,
      'PushStatus': instance.PushStatus,
      'CreateTime': instance.CreateTime,
    };
