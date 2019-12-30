// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectTodayWorkOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTodayWorkOrderModel _$ProjectTodayWorkOrderModelFromJson(
    Map<String, dynamic> json) {
  return ProjectTodayWorkOrderModel(
    json['ID'] as int,
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
    json['PreState'] as int,
    json['Rpno'] as String,
    json['ProductCode'] as String,
    json['SWareHouse'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['Modifier'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$ProjectTodayWorkOrderModelToJson(
        ProjectTodayWorkOrderModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
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
      'PreState': instance.PreState,
      'Rpno': instance.Rpno,
      'ProductCode': instance.ProductCode,
      'SWareHouse': instance.SWareHouse,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'Modifier': instance.Modifier,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
      'DataGroup': instance.DataGroup,
    };
