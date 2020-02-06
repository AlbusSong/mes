// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectRepairMaterialItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectRepairMaterialItemModel _$ProjectRepairMaterialItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectRepairMaterialItemModel(
    json['BomID'] as int,
    json['ItemCode'] as String,
    json['ItemName'] as String,
    json['ProdClassCode'] as String,
    json['ItemType'] as int,
    (json['SingleUsage'] as num)?.toDouble(),
    (json['SubSingleUsage'] as num)?.toDouble(),
    json['IsKitObj'] as bool,
    json['RankCode'] as String,
    json['ParentRankCode'] as String,
    json['Level'] as int,
    json['IsNEXTLevel'] as bool,
    json['FigureNo'] as String,
    json['Delflag'] as bool,
    json['Comment'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$ProjectRepairMaterialItemModelToJson(
        ProjectRepairMaterialItemModel instance) =>
    <String, dynamic>{
      'BomID': instance.BomID,
      'ItemCode': instance.ItemCode,
      'ItemName': instance.ItemName,
      'ProdClassCode': instance.ProdClassCode,
      'ItemType': instance.ItemType,
      'SingleUsage': instance.SingleUsage,
      'SubSingleUsage': instance.SubSingleUsage,
      'IsKitObj': instance.IsKitObj,
      'RankCode': instance.RankCode,
      'ParentRankCode': instance.ParentRankCode,
      'Level': instance.Level,
      'IsNEXTLevel': instance.IsNEXTLevel,
      'FigureNo': instance.FigureNo,
      'Delflag': instance.Delflag,
      'Comment': instance.Comment,
      'DataGroup': instance.DataGroup,
    };
