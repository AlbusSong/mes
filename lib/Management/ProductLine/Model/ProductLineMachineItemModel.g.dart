// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductLineMachineItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductLineMachineItemModel _$ProductLineMachineItemModelFromJson(
    Map<String, dynamic> json) {
  return ProductLineMachineItemModel(
    json['ProductID'] as int,
    json['ProductCode'] as String,
    json['ProductName'] as String,
    json['FigureNo'] as String,
    json['Unit'] as String,
    json['Property'] as String,
    json['ProdType'] as String,
    json['Spec'] as String,
    json['ProdClass'] as String,
    json['Line'] as String,
    json['WorkCenterCode'] as String,
    json['Customer'] as String,
    json['LOTID'] as String,
    json['LOTSize'] as int,
    json['Enabled'] as String,
    json['CToolCode'] as String,
    json['Delflag'] as bool,
    json['CreateTime'] as String,
    json['Creator'] as String,
    json['RowVersion'] as String,
  );
}

Map<String, dynamic> _$ProductLineMachineItemModelToJson(
        ProductLineMachineItemModel instance) =>
    <String, dynamic>{
      'ProductID': instance.ProductID,
      'ProductCode': instance.ProductCode,
      'ProductName': instance.ProductName,
      'FigureNo': instance.FigureNo,
      'Unit': instance.Unit,
      'Property': instance.Property,
      'ProdType': instance.ProdType,
      'Spec': instance.Spec,
      'ProdClass': instance.ProdClass,
      'Line': instance.Line,
      'WorkCenterCode': instance.WorkCenterCode,
      'Customer': instance.Customer,
      'LOTID': instance.LOTID,
      'LOTSize': instance.LOTSize,
      'Enabled': instance.Enabled,
      'CToolCode': instance.CToolCode,
      'Delflag': instance.Delflag,
      'CreateTime': instance.CreateTime,
      'Creator': instance.Creator,
      'RowVersion': instance.RowVersion,
    };
