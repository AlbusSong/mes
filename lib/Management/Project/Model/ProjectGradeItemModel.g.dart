// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProjectGradeItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectGradeItemModel _$ProjectGradeItemModelFromJson(
    Map<String, dynamic> json) {
  return ProjectGradeItemModel(
    json['LevelMatchID'] as int,
    json['ProdClassCode'] as String,
    json['Level'] as String,
    json['IsDefaultLevel'] as bool,
    json['Delflag'] as bool,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProjectGradeItemModelToJson(
        ProjectGradeItemModel instance) =>
    <String, dynamic>{
      'LevelMatchID': instance.LevelMatchID,
      'ProdClassCode': instance.ProdClassCode,
      'Level': instance.Level,
      'IsDefaultLevel': instance.IsDefaultLevel,
      'Delflag': instance.Delflag,
      'RowVersion': instance.RowVersion,
    };
