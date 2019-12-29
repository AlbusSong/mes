// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectLineModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectLineModel _$ProjectLineModelFromJson(Map<String, dynamic> json) {
  return ProjectLineModel(
    json['LineID'] as int,
    json['WShopCode'] as String,
    json['LineCode'] as String,
    json['LineName'] as String,
    (json['YieldTarget'] as num)?.toDouble(),
    json['Description'] as String,
    json['ValidStatus'] as String,
    json['FileName'] as String,
    json['Length'] as int,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectLineModelToJson(ProjectLineModel instance) =>
    <String, dynamic>{
      'LineID': instance.LineID,
      'WShopCode': instance.WShopCode,
      'LineCode': instance.LineCode,
      'LineName': instance.LineName,
      'YieldTarget': instance.YieldTarget,
      'Description': instance.Description,
      'ValidStatus': instance.ValidStatus,
      'FileName': instance.FileName,
      'Length': instance.Length,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
