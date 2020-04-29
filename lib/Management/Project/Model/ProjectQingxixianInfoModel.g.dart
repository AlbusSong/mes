// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectQingxixianInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectQingxixianInfoModel _$ProjectQingxixianInfoModelFromJson(
    Map<String, dynamic> json) {
  return ProjectQingxixianInfoModel(
    json['ProcessCode'] as String,
    json['ProcessName'] as String,
    json['ItemCode'] as String,
    json['ItemName'] as String,
    json['Grade'] as String,
  );
}

Map<String, dynamic> _$ProjectQingxixianInfoModelToJson(
        ProjectQingxixianInfoModel instance) =>
    <String, dynamic>{
      'ProcessCode': instance.ProcessCode,
      'ProcessName': instance.ProcessName,
      'ItemCode': instance.ItemCode,
      'ItemName': instance.ItemName,
      'Grade': instance.Grade,
    };
