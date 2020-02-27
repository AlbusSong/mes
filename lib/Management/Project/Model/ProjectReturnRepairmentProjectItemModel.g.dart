// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectReturnRepairmentProjectItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectReturnRepairmentProjectItemModel
    _$ProjectReturnRepairmentProjectItemModelFromJson(
        Map<String, dynamic> json) {
  return ProjectReturnRepairmentProjectItemModel(
    json['ProcessID'] as int,
    json['Sequence'] as String,
    json['ParentSequence'] as String,
    json['ProcessCode'] as String,
    json['ProcessName'] as String,
    json['ProdClassCode'] as String,
    json['Line'] as String,
    json['WorkCenter'] as String,
    json['ManPower'] as String,
    (json['YieldTarget'] as num)?.toDouble(),
    (json['OperRate'] as num)?.toDouble(),
    (json['PerformanceTarget'] as num)?.toDouble(),
    json['PlanObject'] as bool,
    json['PSType'] as String,
    json['LOTStart'] as bool,
    json['LOTSend'] as String,
    json['LOTPrint'] as bool,
    json['CToolCollection'] as bool,
    json['IsKitFeed'] as bool,
    json['PlanWay'] as String,
    (json['LeadTime'] as num)?.toDouble(),
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['ModifiedTime'] as String,
    json['Modifier'] as String,
    json['Comment'] as String,
    json['RowVersion'] as String,
    json['DataGroup'] as String,
  );
}

Map<String, dynamic> _$ProjectReturnRepairmentProjectItemModelToJson(
        ProjectReturnRepairmentProjectItemModel instance) =>
    <String, dynamic>{
      'ProcessID': instance.ProcessID,
      'Sequence': instance.Sequence,
      'ParentSequence': instance.ParentSequence,
      'ProcessCode': instance.ProcessCode,
      'ProcessName': instance.ProcessName,
      'ProdClassCode': instance.ProdClassCode,
      'Line': instance.Line,
      'WorkCenter': instance.WorkCenter,
      'ManPower': instance.ManPower,
      'YieldTarget': instance.YieldTarget,
      'OperRate': instance.OperRate,
      'PerformanceTarget': instance.PerformanceTarget,
      'PlanObject': instance.PlanObject,
      'PSType': instance.PSType,
      'LOTStart': instance.LOTStart,
      'LOTSend': instance.LOTSend,
      'LOTPrint': instance.LOTPrint,
      'CToolCollection': instance.CToolCollection,
      'IsKitFeed': instance.IsKitFeed,
      'PlanWay': instance.PlanWay,
      'LeadTime': instance.LeadTime,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'ModifiedTime': instance.ModifiedTime,
      'Modifier': instance.Modifier,
      'Comment': instance.Comment,
      'RowVersion': instance.RowVersion,
      'DataGroup': instance.DataGroup,
    };
