// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectReturnRepairmentRepairCodeItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectReturnRepairmentRepairCodeItemModel
    _$ProjectReturnRepairmentRepairCodeItemModelFromJson(
        Map<String, dynamic> json) {
  return ProjectReturnRepairmentRepairCodeItemModel(
    json['LOTRepairCodeID'] as int,
    json['LOTRepairCode'] as String,
    json['ApllyLine'] as String,
    json['Description'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['ModifiedTime'] as String,
    json['Modifier'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectReturnRepairmentRepairCodeItemModelToJson(
        ProjectReturnRepairmentRepairCodeItemModel instance) =>
    <String, dynamic>{
      'LOTRepairCodeID': instance.LOTRepairCodeID,
      'LOTRepairCode': instance.LOTRepairCode,
      'ApllyLine': instance.ApllyLine,
      'Description': instance.Description,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'ModifiedTime': instance.ModifiedTime,
      'Modifier': instance.Modifier,
      'RowVersion': instance.RowVersion,
    };
