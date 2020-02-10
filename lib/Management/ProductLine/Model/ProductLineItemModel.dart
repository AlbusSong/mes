import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProductLineItemModel.g.dart';


@JsonSerializable()
  class ProductLineItemModel extends Object {

  @JsonKey(name: 'LineID')
  int LineID;

  @JsonKey(name: 'WShopCode')
  String WShopCode;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'YieldTarget')
  double YieldTarget;

  @JsonKey(name: 'Description')
  String Description;

  @JsonKey(name: 'ValidStatus')
  String ValidStatus;

  @JsonKey(name: 'FileName')
  String FileName;

  @JsonKey(name: 'Length')
  int Length;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProductLineItemModel(this.LineID,this.WShopCode,this.LineCode,this.LineName,this.YieldTarget,this.Description,this.ValidStatus,this.FileName,this.Length,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProductLineItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProductLineItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductLineItemModelToJson(this);

}

  
