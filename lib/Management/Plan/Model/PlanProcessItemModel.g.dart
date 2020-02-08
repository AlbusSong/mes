// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlanProcessItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanProcessItemModel _$PlanProcessItemModelFromJson(Map<String, dynamic> json) {
  return PlanProcessItemModel(
    (json['WoGoodQty'] as num)?.toDouble(),
    json['ProductName'] as String,
    json['ProcessName'] as String,
    json['LineName'] as String,
    (json['CompRate'] as num)?.toDouble(),
    json['ID'] as int,
    json['Wono'] as String,
    json['Pdno'] as String,
    json['LineCode'] as String,
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
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Comment'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$PlanProcessItemModelToJson(
        PlanProcessItemModel instance) =>
    <String, dynamic>{
      'WoGoodQty': instance.WoGoodQty,
      'ProductName': instance.ProductName,
      'ProcessName': instance.ProcessName,
      'LineName': instance.LineName,
      'CompRate': instance.CompRate,
      'ID': instance.ID,
      'Wono': instance.Wono,
      'Pdno': instance.Pdno,
      'LineCode': instance.LineCode,
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
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Comment': instance.Comment,
      'DataGroup': instance.DataGroup,
    };
