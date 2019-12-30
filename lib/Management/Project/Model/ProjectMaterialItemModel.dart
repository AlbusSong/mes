import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectMaterialItemModel.g.dart';


@JsonSerializable()
  class ProjectMaterialItemModel extends Object {

  @JsonKey(name: 'NeedQty')
  double NeedQty;

  @JsonKey(name: 'ItemTypeDesc')
  String ItemTypeDesc;

  @JsonKey(name: 'BomID')
  int BomID;

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'ItemName')
  String ItemName;

  @JsonKey(name: 'ProdClassCode')
  String ProdClassCode;

  @JsonKey(name: 'ItemType')
  int ItemType;

  @JsonKey(name: 'Unit')
  String Unit;

  @JsonKey(name: 'SingleUsage')
  double SingleUsage;

  @JsonKey(name: 'SubSingleUsage')
  double SubSingleUsage;

  @JsonKey(name: 'IsKitObj')
  bool IsKitObj;

  @JsonKey(name: 'RankCode')
  String RankCode;

  @JsonKey(name: 'ParentRankCode')
  String ParentRankCode;

  @JsonKey(name: 'Level')
  int Level;

  @JsonKey(name: 'IsNEXTLevel')
  bool IsNEXTLevel;

  @JsonKey(name: 'FigureNo')
  String FigureNo;

  @JsonKey(name: 'ItemGroup')
  String ItemGroup;

  @JsonKey(name: 'Cwar')
  String Cwar;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectMaterialItemModel(this.NeedQty,this.ItemTypeDesc,this.BomID,this.ItemCode,this.ItemName,this.ProdClassCode,this.ItemType,this.Unit,this.SingleUsage,this.SubSingleUsage,this.IsKitObj,this.RankCode,this.ParentRankCode,this.Level,this.IsNEXTLevel,this.FigureNo,this.ItemGroup,this.Cwar,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProjectMaterialItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectMaterialItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectMaterialItemModelToJson(this);

}

  
