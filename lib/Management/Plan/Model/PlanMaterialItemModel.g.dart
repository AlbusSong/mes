// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlanMaterialItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanMaterialItemModel _$PlanMaterialItemModelFromJson(
    Map<String, dynamic> json) {
  return PlanMaterialItemModel(
    json['ID'] as int,
    json['ExportNo'] as String,
    json['State'] as String,
    json['DestWareHouseID'] as String,
    json['WorkOrderNo'] as String,
    json['Line'] as String,
    json['LineName'] as String,
    json['Compounder'] as String,
    json['NeedDate'] as String,
    json['PrepareTime'] as String,
    json['MoutTime'] as String,
    json['ReceiveTime'] as String,
    json['AprTime'] as String,
    json['Approver'] as String,
    json['CreateTime'] as String,
    json['Creator'] as String,
  );
}

Map<String, dynamic> _$PlanMaterialItemModelToJson(
        PlanMaterialItemModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'ExportNo': instance.ExportNo,
      'State': instance.State,
      'DestWareHouseID': instance.DestWareHouseID,
      'WorkOrderNo': instance.WorkOrderNo,
      'Line': instance.Line,
      'LineName': instance.LineName,
      'Compounder': instance.Compounder,
      'NeedDate': instance.NeedDate,
      'PrepareTime': instance.PrepareTime,
      'MoutTime': instance.MoutTime,
      'ReceiveTime': instance.ReceiveTime,
      'AprTime': instance.AprTime,
      'Approver': instance.Approver,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
    };
