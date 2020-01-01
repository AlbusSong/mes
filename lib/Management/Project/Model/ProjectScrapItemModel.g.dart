// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectScrapItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectScrapItemModel _$ProjectScrapItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectScrapItemModel(
    json['ScrapCodeID'] as int,
    json['ScrapCode'] as String,
    json['ScrapObject'] as int,
    json['ApllyLine'] as String,
    json['Description'] as String,
    json['Delflag'] as bool,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectScrapItemModelToJson(
        ProjectScrapItemModel instance) =>
    <String, dynamic>{
      'ScrapCodeID': instance.ScrapCodeID,
      'ScrapCode': instance.ScrapCode,
      'ScrapObject': instance.ScrapObject,
      'ApllyLine': instance.ApllyLine,
      'Description': instance.Description,
      'Delflag': instance.Delflag,
      'RowVersion': instance.RowVersion,
    };
