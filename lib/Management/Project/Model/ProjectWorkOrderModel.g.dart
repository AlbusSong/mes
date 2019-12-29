// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectWorkOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectWorkOrderModel _$ProjectWorkOrderModelFromJson(
    Map<String, dynamic> json) {
  return ProjectWorkOrderModel(
    json['ProcessCode'] as String,
    json['ProcessName'] as String,
    json['LOTSize'] as int,
    json['ProdClass'] as String,
    json['Wono'] as String,
    json['Pdno'] as String,
    json['LineCode'] as String,
    json['WorkCenterCode'] as String,
    json['ProjectCode'] as String,
    json['ItemCode'] as String,
    json['ItemName'] as String,
    json['WoDate'] as String,
    json['PdFTime'] as String,
    json['Shift'] as String,
    (json['WoPlanQty'] as num)?.toDouble(),
    json['State'] as int,
    json['StateDesc'] as String,
    (json['WoOutPutQty'] as num)?.toDouble(),
    (json['WoReturnQty'] as num)?.toDouble(),
    (json['WoBadQty'] as num)?.toDouble(),
    (json['WoScrapQty'] as num)?.toDouble(),
    (json['WoRepareQty'] as num)?.toDouble(),
    json['WoStartDate'] as String,
    json['PreState'] as int,
    json['Rpno'] as String,
    json['BopVersion'] as String,
    json['ProductCode'] as String,
    json['SWareHouse'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['ModifiedTime'] as String,
    json['Modifier'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$ProjectWorkOrderModelToJson(
        ProjectWorkOrderModel instance) =>
    <String, dynamic>{
      'ProcessCode': instance.ProcessCode,
      'ProcessName': instance.ProcessName,
      'LOTSize': instance.LOTSize,
      'ProdClass': instance.ProdClass,
      'Wono': instance.Wono,
      'Pdno': instance.Pdno,
      'LineCode': instance.LineCode,
      'WorkCenterCode': instance.WorkCenterCode,
      'ProjectCode': instance.ProjectCode,
      'ItemCode': instance.ItemCode,
      'ItemName': instance.ItemName,
      'WoDate': instance.WoDate,
      'PdFTime': instance.PdFTime,
      'Shift': instance.Shift,
      'WoPlanQty': instance.WoPlanQty,
      'State': instance.State,
      'StateDesc': instance.StateDesc,
      'WoOutPutQty': instance.WoOutPutQty,
      'WoReturnQty': instance.WoReturnQty,
      'WoBadQty': instance.WoBadQty,
      'WoScrapQty': instance.WoScrapQty,
      'WoRepareQty': instance.WoRepareQty,
      'WoStartDate': instance.WoStartDate,
      'PreState': instance.PreState,
      'Rpno': instance.Rpno,
      'BopVersion': instance.BopVersion,
      'ProductCode': instance.ProductCode,
      'SWareHouse': instance.SWareHouse,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'ModifiedTime': instance.ModifiedTime,
      'Modifier': instance.Modifier,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
      'DataGroup': instance.DataGroup,
    };
