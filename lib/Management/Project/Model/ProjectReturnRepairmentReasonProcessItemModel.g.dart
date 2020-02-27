// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectReturnRepairmentReasonProcessItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectReturnRepairmentReasonProcessItemModel
    _$ProjectReturnRepairmentReasonProcessItemModelFromJson(
        Map<String, dynamic> json) {
  return ProjectReturnRepairmentReasonProcessItemModel(
    json['StepID'] as int,
    json['StepCode'] as String,
    json['StepName'] as String,
    json['StepType'] as String,
    json['ProcessCode'] as String,
    json['Line'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectReturnRepairmentReasonProcessItemModelToJson(
        ProjectReturnRepairmentReasonProcessItemModel instance) =>
    <String, dynamic>{
      'StepID': instance.StepID,
      'StepCode': instance.StepCode,
      'StepName': instance.StepName,
      'StepType': instance.StepType,
      'ProcessCode': instance.ProcessCode,
      'Line': instance.Line,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
