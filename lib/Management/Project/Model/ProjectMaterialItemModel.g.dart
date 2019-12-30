// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectMaterialItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMaterialItemModel _$ProjectMaterialItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectMaterialItemModel(
    (json['NeedQty'] as num)?.toDouble(),
    json['ItemTypeDesc'] as String,
    json['BomID'] as int,
    json['ItemCode'] as String,
    json['ItemName'] as String,
    json['ProdClassCode'] as String,
    json['ItemType'] as int,
    json['Unit'] as String,
    (json['SingleUsage'] as num)?.toDouble(),
    (json['SubSingleUsage'] as num)?.toDouble(),
    json['IsKitObj'] as bool,
    json['RankCode'] as String,
    json['ParentRankCode'] as String,
    json['Level'] as int,
    json['IsNEXTLevel'] as bool,
    json['FigureNo'] as String,
    json['ItemGroup'] as String,
    json['Cwar'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectMaterialItemModelToJson(
        ProjectMaterialItemModel instance) =>
    <String, dynamic>{
      'NeedQty': instance.NeedQty,
      'ItemTypeDesc': instance.ItemTypeDesc,
      'BomID': instance.BomID,
      'ItemCode': instance.ItemCode,
      'ItemName': instance.ItemName,
      'ProdClassCode': instance.ProdClassCode,
      'ItemType': instance.ItemType,
      'Unit': instance.Unit,
      'SingleUsage': instance.SingleUsage,
      'SubSingleUsage': instance.SubSingleUsage,
      'IsKitObj': instance.IsKitObj,
      'RankCode': instance.RankCode,
      'ParentRankCode': instance.ParentRankCode,
      'Level': instance.Level,
      'IsNEXTLevel': instance.IsNEXTLevel,
      'FigureNo': instance.FigureNo,
      'ItemGroup': instance.ItemGroup,
      'Cwar': instance.Cwar,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
