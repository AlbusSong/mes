// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QualitySelfTestItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualitySelfTestItemModel _$QualitySelfTestItemModelFromJson(
    Map<String, dynamic> json) {
  return QualitySelfTestItemModel(
    json['ID'] as int,
    json['MECWorkOrderNo'] as String,
    json['MECPlanNo'] as String,
    json['Item'] as String,
    json['State'] as String,
    json['WOType'] as String,
    json['LineCode'] as String,
    json['LineName'] as String,
    json['StepCode'] as String,
    json['Step'] as String,
    json['Product'] as String,
    json['Judge'] as String,
    (json['UpperSpecLimit'] as num)?.toDouble(),
    (json['LowerSpecLimit'] as num)?.toDouble(),
    json['Unit'] as String,
    json['MethodTool'] as String,
    json['StartTime'] as String,
    json['CutOffTime'] as String,
    json['AppTime'] as String,
    json['AppWoType'] as String,
    json['AppStandard'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  )..Actual = json['Actual'] as String;
}

Map<String, dynamic> _$QualitySelfTestItemModelToJson(
        QualitySelfTestItemModel instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'MECWorkOrderNo': instance.MECWorkOrderNo,
      'MECPlanNo': instance.MECPlanNo,
      'Actual': instance.Actual,
      'Item': instance.Item,
      'State': instance.State,
      'WOType': instance.WOType,
      'LineCode': instance.LineCode,
      'LineName': instance.LineName,
      'StepCode': instance.StepCode,
      'Step': instance.Step,
      'Product': instance.Product,
      'Judge': instance.Judge,
      'UpperSpecLimit': instance.UpperSpecLimit,
      'LowerSpecLimit': instance.LowerSpecLimit,
      'Unit': instance.Unit,
      'MethodTool': instance.MethodTool,
      'StartTime': instance.StartTime,
      'CutOffTime': instance.CutOffTime,
      'AppTime': instance.AppTime,
      'AppWoType': instance.AppWoType,
      'AppStandard': instance.AppStandard,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
