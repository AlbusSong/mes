import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProductLineMachineItemModel.g.dart';


@JsonSerializable()
  class ProductLineMachineItemModel extends Object {

  @JsonKey(name: 'ProductID')
  int ProductID;

  @JsonKey(name: 'ProductCode')
  String ProductCode;

  @JsonKey(name: 'ProductName')
  String ProductName;

  @JsonKey(name: 'FigureNo')
  String FigureNo;

  @JsonKey(name: 'Unit')
  String Unit;

  @JsonKey(name: 'Property')
  String Property;

  @JsonKey(name: 'ProdType')
  String ProdType;

  @JsonKey(name: 'Spec')
  String Spec;

  @JsonKey(name: 'ProdClass')
  String ProdClass;

  @JsonKey(name: 'Line')
  String Line;

  @JsonKey(name: 'WorkCenterCode')
  String WorkCenterCode;

  @JsonKey(name: 'Customer')
  String Customer;

  @JsonKey(name: 'LOTID')
  String LOTID;

  @JsonKey(name: 'LOTSize')
  int LOTSize;

  @JsonKey(name: 'Enabled')
  String Enabled;

  @JsonKey(name: 'CToolCode')
  String CToolCode;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProductLineMachineItemModel(this.ProductID,this.ProductCode,this.ProductName,this.FigureNo,this.Unit,this.Property,this.ProdType,this.Spec,this.ProdClass,this.Line,this.WorkCenterCode,this.Customer,this.LOTID,this.LOTSize,this.Enabled,this.CToolCode,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProductLineMachineItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProductLineMachineItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductLineMachineItemModelToJson(this);

}

  
