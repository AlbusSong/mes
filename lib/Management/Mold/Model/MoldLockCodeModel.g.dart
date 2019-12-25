// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MoldLockCodeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoldLockCodeModel _$MoldLockCodeModelFromJson(Map<String, dynamic> json) {
  return MoldLockCodeModel(
    json['LockCode'] as String,
    json['Description'] as String,
    json['LockCodeID'] as String,
  );
}

Map<String, dynamic> _$MoldLockCodeModelToJson(MoldLockCodeModel instance) =>
    <String, dynamic>{
      'LockCode': instance.LockCode,
      'Description': instance.Description,
      'LockCodeID': instance.LockCodeID,
    };
