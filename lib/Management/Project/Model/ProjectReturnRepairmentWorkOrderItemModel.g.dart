// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectReturnRepairmentWorkOrderItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectReturnRepairmentWorkOrderItemModel
    _$ProjectReturnRepairmentWorkOrderItemModelFromJson(
        Map<String, dynamic> json) {
  return ProjectReturnRepairmentWorkOrderItemModel(
    json['WorkCenterID'] as int,
    json['WorkCenterCode'] as String,
    json['WorkCenterName'] as String,
    json['LineCode'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectReturnRepairmentWorkOrderItemModelToJson(
        ProjectReturnRepairmentWorkOrderItemModel instance) =>
    <String, dynamic>{
      'WorkCenterID': instance.WorkCenterID,
      'WorkCenterCode': instance.WorkCenterCode,
      'WorkCenterName': instance.WorkCenterName,
      'LineCode': instance.LineCode,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
