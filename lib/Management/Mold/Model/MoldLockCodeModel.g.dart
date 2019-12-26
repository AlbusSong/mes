// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MoldLockCodeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoldLockCodeModel _$MoldLockCodeModelFromJson(Map<String, dynamic> json) {
  return MoldLockCodeModel(
    json['LockCodeID'] as int,
    json['LockCode'] as String,
    json['LockObject'] as int,
    json['ApllyLine'] as String,
    json['Description'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$MoldLockCodeModelToJson(MoldLockCodeModel instance) =>
    <String, dynamic>{
      'LockCodeID': instance.LockCodeID,
      'LockCode': instance.LockCode,
      'LockObject': instance.LockObject,
      'ApllyLine': instance.ApllyLine,
      'Description': instance.Description,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
