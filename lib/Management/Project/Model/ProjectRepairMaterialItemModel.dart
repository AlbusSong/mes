import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectRepairMaterialItemModel.g.dart';


@JsonSerializable()
  class ProjectRepairMaterialItemModel extends Object {

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

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'DataGroup')
  String DataGroup;

  ProjectRepairMaterialItemModel(this.BomID,this.ItemCode,this.ItemName,this.ProdClassCode,this.ItemType,this.SingleUsage,this.SubSingleUsage,this.IsKitObj,this.RankCode,this.ParentRankCode,this.Level,this.IsNEXTLevel,this.FigureNo,this.Delflag,this.Comment,this.DataGroup,);

  factory ProjectRepairMaterialItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectRepairMaterialItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectRepairMaterialItemModelToJson(this);

}

  
