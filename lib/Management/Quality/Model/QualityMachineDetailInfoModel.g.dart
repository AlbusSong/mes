// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QualityMachineDetailInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualityMachineDetailInfoModel _$QualityMachineDetailInfoModelFromJson(
    Map<String, dynamic> json) {
  return QualityMachineDetailInfoModel(
    json['Standard'] as String,
    json['ID'] as int,
    json['MECPlanNo'] as String,
    json['ProductType'] as String,
    json['Product'] as String,
    json['JudgeStandard'] as String,
    (json['UpperSpecLimit'] as num)?.toDouble(),
    (json['LowerSpecLimit'] as num)?.toDouble(),
    json['Unit'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$QualityMachineDetailInfoModelToJson(
        QualityMachineDetailInfoModel instance) =>
    <String, dynamic>{
      'Standard': instance.Standard,
      'ID': instance.ID,
      'MECPlanNo': instance.MECPlanNo,
      'ProductType': instance.ProductType,
      'Product': instance.Product,
      'JudgeStandard': instance.JudgeStandard,
      'UpperSpecLimit': instance.UpperSpecLimit,
      'LowerSpecLimit': instance.LowerSpecLimit,
      'Unit': instance.Unit,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
      'DataGroup': instance.DataGroup,
    };
