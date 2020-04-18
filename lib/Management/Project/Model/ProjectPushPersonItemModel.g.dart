// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectPushPersonItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectPushPersonItemModel _$ProjectPushPersonItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectPushPersonItemModel(
    json['ID'] as int,
    json['LineCode'] as String,
    json['UserID'] as String,
    json['StartDateTime'] as String,
    json['EndDateTime'] as String,
    json['KaoQinDate'] as String,
    (json['WorkTime'] as num)?.toDouble(),
    json['Shift'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectPushPersonItemModelToJson(
        ProjectPushPersonItemModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'LineCode': instance.LineCode,
      'UserID': instance.UserID,
      'StartDateTime': instance.StartDateTime,
      'EndDateTime': instance.EndDateTime,
      'KaoQinDate': instance.KaoQinDate,
      'WorkTime': instance.WorkTime,
      'Shift': instance.Shift,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
    };
