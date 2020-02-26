// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QualityPatrolTestSubWorkOrderItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualityPatrolTestSubWorkOrderItemModel
    _$QualityPatrolTestSubWorkOrderItemModelFromJson(
        Map<String, dynamic> json) {
  return QualityPatrolTestSubWorkOrderItemModel(
    json['ID'] as int,
    json['IPQCPlanNo'] as String,
    json['IPQCItemNo'] as String,
    json['StepCode'] as String,
    json['Step'] as String,
    json['Item'] as String,
    json['Week'] as String,
    json['PublishTime'] as String,
    json['ProductApply'] as String,
    json['Product'] as String,
    json['StandardType'] as String,
    json['ManualStandard'] as String,
    (json['UpperSpecLimit'] as num)?.toDouble(),
    (json['LowerSpecLimit'] as num)?.toDouble(),
    json['QTY'] as int,
    json['QTYRemark'] as String,
    json['Method'] as String,
    json['Tool'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$QualityPatrolTestSubWorkOrderItemModelToJson(
        QualityPatrolTestSubWorkOrderItemModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'IPQCPlanNo': instance.IPQCPlanNo,
      'IPQCItemNo': instance.IPQCItemNo,
      'StepCode': instance.StepCode,
      'Step': instance.Step,
      'Item': instance.Item,
      'Week': instance.Week,
      'PublishTime': instance.PublishTime,
      'ProductApply': instance.ProductApply,
      'Product': instance.Product,
      'StandardType': instance.StandardType,
      'ManualStandard': instance.ManualStandard,
      'UpperSpecLimit': instance.UpperSpecLimit,
      'LowerSpecLimit': instance.LowerSpecLimit,
      'QTY': instance.QTY,
      'QTYRemark': instance.QTYRemark,
      'Method': instance.Method,
      'Tool': instance.Tool,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
      'DataGroup': instance.DataGroup,
    };
