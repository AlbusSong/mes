// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectGradeItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectGradeItemModel _$ProjectGradeItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectGradeItemModel(
    json['ProdClassID'] as int,
    json['ProdClassCode'] as String,
    json['ProdClassName'] as String,
    json['Cwar'] as String,
    json['LevelManage'] as String,
    json['Description'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectGradeItemModelToJson(
        ProjectGradeItemModel instance) =>
    <String, dynamic>{
      'ProdClassID': instance.ProdClassID,
      'ProdClassCode': instance.ProdClassCode,
      'ProdClassName': instance.ProdClassName,
      'Cwar': instance.Cwar,
      'LevelManage': instance.LevelManage,
      'Description': instance.Description,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
