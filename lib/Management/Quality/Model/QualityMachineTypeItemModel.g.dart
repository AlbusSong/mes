// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QualityMachineTypeItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QualityMachineTypeItemModel _$QualityMachineTypeItemModelFromJson(
    Map<String, dynamic> json) {
  return QualityMachineTypeItemModel(
    json['ItemCode'] as String,
    json['ItemName'] as String,
    json['State'] as int,
    json['AppState'] as String,
  );
}

Map<String, dynamic> _$QualityMachineTypeItemModelToJson(
        QualityMachineTypeItemModel instance) =>
    <String, dynamic>{
      'ItemCode': instance.ItemCode,
      'ItemName': instance.ItemName,
      'State': instance.State,
      'AppState': instance.AppState,
    };
