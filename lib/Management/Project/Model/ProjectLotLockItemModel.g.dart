// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectLotLockItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectLotLockItemModel _$ProjectLotLockItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectLotLockItemModel(
    json['ID'] as int,
    json['LotNo'] as String,
    json['Status'] as int,
    json['StatusDesc'] as String,
    json['Hold'] as String,
    json['HoldCode'] as String,
    json['ProcessCode'] as String,
    json['ProcessName'] as String,
    json['ItemCode'] as String,
    json['ItemName'] as String,
    json['Dscb'] as String,
    json['Qty'] as int,
    json['Cost'] as int,
    json['CToolNo'] as String,
    json['FlowCode'] as String,
    json['FlowName'] as String,
    json['Wono'] as String,
    json['OrderNo'] as String,
    json['Grade'] as String,
    json['Location'] as String,
    json['RepairCode'] as String,
    json['ScrapCode'] as String,
    json['FromLot'] as String,
    json['IntoLot'] as String,
    json['LineCode'] as String,
    json['LineName'] as String,
    json['WorkCenterCode'] as String,
    json['WorkCenterName'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['ModifiedTime'] as String,
    json['Modifier'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectLotLockItemModelToJson(
        ProjectLotLockItemModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'LotNo': instance.LotNo,
      'Status': instance.Status,
      'StatusDesc': instance.StatusDesc,
      'Hold': instance.Hold,
      'HoldCode': instance.HoldCode,
      'ProcessCode': instance.ProcessCode,
      'ProcessName': instance.ProcessName,
      'ItemCode': instance.ItemCode,
      'ItemName': instance.ItemName,
      'Dscb': instance.Dscb,
      'Qty': instance.Qty,
      'Cost': instance.Cost,
      'CToolNo': instance.CToolNo,
      'FlowCode': instance.FlowCode,
      'FlowName': instance.FlowName,
      'Wono': instance.Wono,
      'OrderNo': instance.OrderNo,
      'Grade': instance.Grade,
      'Location': instance.Location,
      'RepairCode': instance.RepairCode,
      'ScrapCode': instance.ScrapCode,
      'FromLot': instance.FromLot,
      'IntoLot': instance.IntoLot,
      'LineCode': instance.LineCode,
      'LineName': instance.LineName,
      'WorkCenterCode': instance.WorkCenterCode,
      'WorkCenterName': instance.WorkCenterName,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'ModifiedTime': instance.ModifiedTime,
      'Modifier': instance.Modifier,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
    };
