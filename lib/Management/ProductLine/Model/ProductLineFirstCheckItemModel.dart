import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProductLineFirstCheckItemModel.g.dart';


@JsonSerializable()
  class ProductLineFirstCheckItemModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'ParentCode')
  String ParentCode;

  @JsonKey(name: 'Code')
  String Code;

  @JsonKey(name: 'Value')
  String Value;

  @JsonKey(name: 'Type')
  int Type;

  @JsonKey(name: 'TypeDesc')
  bool TypeDesc;

  @JsonKey(name: 'Desc')
  String Desc;

  @JsonKey(name: 'Remark')
  String Remark;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProductLineFirstCheckItemModel(this.ID,this.ParentCode,this.Code,this.Value,this.Type,this.TypeDesc,this.Desc,this.Remark,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProductLineFirstCheckItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProductLineFirstCheckItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductLineFirstCheckItemModelToJson(this);

}

  
