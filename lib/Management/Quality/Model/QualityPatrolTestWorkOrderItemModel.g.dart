// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QualityPatrolTestWorkOrderItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualityPatrolTestWorkOrderItemModel
    _$QualityPatrolTestWorkOrderItemModelFromJson(Map<String, dynamic> json) {
  return QualityPatrolTestWorkOrderItemModel(
    json['IPQCWoNo'] as String,
    json['LineCode'] as String,
    json['LineName'] as String,
    json['WCCode'] as String,
    json['WCName'] as String,
    json['IPQCType'] as String,
    json['State'] as String,
    json['StartTime'] as String,
    (json['WaitTime'] as num)?.toDouble(),
    json['IPQCPlanNo'] as String,
    json['AppTime'] as String,
    json['AppIPQCType'] as String,
  );
}

Map<String, dynamic> _$QualityPatrolTestWorkOrderItemModelToJson(
        QualityPatrolTestWorkOrderItemModel instance) =>
    <String, dynamic>{
      'IPQCWoNo': instance.IPQCWoNo,
      'LineCode': instance.LineCode,
      'LineName': instance.LineName,
      'WCCode': instance.WCCode,
      'WCName': instance.WCName,
      'IPQCType': instance.IPQCType,
      'State': instance.State,
      'StartTime': instance.StartTime,
      'WaitTime': instance.WaitTime,
      'IPQCPlanNo': instance.IPQCPlanNo,
      'AppTime': instance.AppTime,
      'AppIPQCType': instance.AppIPQCType,
    };
