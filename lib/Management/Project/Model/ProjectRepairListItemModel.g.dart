// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectRepairListItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectRepairListItemModel _$ProjectRepairListItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectRepairListItemModel(
    json['RPWO'] as String,
    json['CreateTime'] as String,
    json['OTime'] as String,
    json['Type'] as String,
    json['TypeDesc'] as String,
    json['Wono'] as String,
    json['LotNo'] as String,
    json['Qty'] as int,
    json['RepairCode'] as String,
    json['ProcessCode'] as String,
    json['ProcessName'] as String,
    json['BopVersion'] as String,
    json['ItemCode'] as String,
    json['ItemName'] as String,
    json['ProdClass'] as String,
    json['Grade'] as String,
    json['LineCode'] as String,
    json['LineName'] as String,
    json['WorkCenterCode'] as String,
    json['WorkCenterName'] as String,
    json['Comment'] as String,
    json['Status'] as int,
  );
}

Map<String, dynamic> _$ProjectRepairListItemModelToJson(
        ProjectRepairListItemModel instance) =>
    <String, dynamic>{
      'RPWO': instance.RPWO,
      'CreateTime': instance.CreateTime,
      'OTime': instance.OTime,
      'Type': instance.Type,
      'TypeDesc': instance.TypeDesc,
      'Wono': instance.Wono,
      'LotNo': instance.LotNo,
      'Qty': instance.Qty,
      'RepairCode': instance.RepairCode,
      'ProcessCode': instance.ProcessCode,
      'ProcessName': instance.ProcessName,
      'BopVersion': instance.BopVersion,
      'ItemCode': instance.ItemCode,
      'ItemName': instance.ItemName,
      'ProdClass': instance.ProdClass,
      'Grade': instance.Grade,
      'LineCode': instance.LineCode,
      'LineName': instance.LineName,
      'WorkCenterCode': instance.WorkCenterCode,
      'WorkCenterName': instance.WorkCenterName,
      'Comment': instance.Comment,
      'Status': instance.Status,
    };
