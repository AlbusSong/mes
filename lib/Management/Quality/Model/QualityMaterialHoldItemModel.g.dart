// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QualityMaterialHoldItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualityMaterialHoldItemModel _$QualityMaterialHoldItemModelFromJson(
    Map<String, dynamic> json) {
  return QualityMaterialHoldItemModel(
    json['ItemName'] as String,
    json['HoldCode'] as String,
    json['HoldRemark'] as String,
    json['Dsca'] as String,
    json['ID'] as int,
    json['HoldNo'] as String,
    json['Batch'] as String,
    json['ItemCode'] as String,
    json['TagID'] as String,
    json['WareHouseID'] as String,
    json['State'] as String,
    json['HoldState'] as bool,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['Modifier'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$QualityMaterialHoldItemModelToJson(
        QualityMaterialHoldItemModel instance) =>
    <String, dynamic>{
      'ItemName': instance.ItemName,
      'HoldCode': instance.HoldCode,
      'HoldRemark': instance.HoldRemark,
      'Dsca': instance.Dsca,
      'ID': instance.ID,
      'HoldNo': instance.HoldNo,
      'Batch': instance.Batch,
      'ItemCode': instance.ItemCode,
      'TagID': instance.TagID,
      'WareHouseID': instance.WareHouseID,
      'State': instance.State,
      'HoldState': instance.HoldState,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'Modifier': instance.Modifier,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
    };
