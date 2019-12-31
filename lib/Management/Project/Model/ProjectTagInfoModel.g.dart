// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectTagInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectTagInfoModel _$ProjectTagInfoModelFromJson(Map<String, dynamic> json) {
  return ProjectTagInfoModel(
    json['ItemCode'] as String,
    json['TagID'] as String,
    (json['Qty'] as num)?.toDouble(),
    (json['Cost'] as num)?.toDouble(),
    json['Sequence'] as int,
    json['ProductionBatch'] as String,
    json['Unit'] as String,
    json['OrderNo'] as String,
    json['State'] as int,
    json['Delflag'] as bool,
    json['Comment'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$ProjectTagInfoModelToJson(
        ProjectTagInfoModel instance) =>
    <String, dynamic>{
      'ItemCode': instance.ItemCode,
      'TagID': instance.TagID,
      'Qty': instance.Qty,
      'Cost': instance.Cost,
      'Sequence': instance.Sequence,
      'ProductionBatch': instance.ProductionBatch,
      'Unit': instance.Unit,
      'OrderNo': instance.OrderNo,
      'State': instance.State,
      'Delflag': instance.Delflag,
      'Comment': instance.Comment,
      'DataGroup': instance.DataGroup,
    };
