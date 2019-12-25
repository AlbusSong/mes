// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MoldInModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoldInModel _$MoldInModelFromJson(Map<String, dynamic> json) {
  return MoldInModel(
    json['HoldStateDes'] as String,
    json['StorageStateDes'] as String,
    json['ID'] as int,
    json['MouldNo'] as String,
    json['MouldCode'] as String,
    json['MouldName'] as String,
    json['Qty'] as int,
    json['ActUseCount'] as int,
    json['MouldStatus'] as String,
    json['Location'] as String,
    json['HoldState'] as bool,
    json['HoldReasonCode'] as String,
    json['HoldPerson'] as String,
    json['HoldRemark'] as String,
    json['UnHoldRemark'] as String,
  );
}

Map<String, dynamic> _$MoldInModelToJson(MoldInModel instance) =>
    <String, dynamic>{
      'HoldStateDes': instance.HoldStateDes,
      'StorageStateDes': instance.StorageStateDes,
      'ID': instance.ID,
      'MouldNo': instance.MouldNo,
      'MouldCode': instance.MouldCode,
      'MouldName': instance.MouldName,
      'Qty': instance.Qty,
      'ActUseCount': instance.ActUseCount,
      'MouldStatus': instance.MouldStatus,
      'Location': instance.Location,
      'HoldState': instance.HoldState,
      'HoldReasonCode': instance.HoldReasonCode,
      'HoldPerson': instance.HoldPerson,
      'HoldRemark': instance.HoldRemark,
      'UnHoldRemark': instance.UnHoldRemark,
    };
