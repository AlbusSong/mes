import 'package:json_annotation/json_annotation.dart'; 
  
part 'QualityMaterialHoldItemModel.g.dart';


@JsonSerializable()
  class QualityMaterialHoldItemModel extends Object {

  @JsonKey(name: 'ItemName')
  String ItemName;

  @JsonKey(name: 'HoldCode')
  String HoldCode;

  @JsonKey(name: 'HoldRemark')
  String HoldRemark;

  @JsonKey(name: 'Dsca')
  String Dsca;

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'HoldNo')
  String HoldNo;

  @JsonKey(name: 'Batch')
  String Batch;

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'TagID')
  String TagID;

  @JsonKey(name: 'WareHouseID')
  String WareHouseID;

  @JsonKey(name: 'State')
  String State;

  @JsonKey(name: 'HoldState')
  bool HoldState;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'Modifier')
  String Modifier;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  QualityMaterialHoldItemModel(this.ItemName,this.HoldCode,this.HoldRemark,this.Dsca,this.ID,this.HoldNo,this.Batch,this.ItemCode,this.TagID,this.WareHouseID,this.State,this.HoldState,this.Delflag,this.CreateTime,this.Creator,this.Modifier,this.Comment,this.RowVersion,);

  factory QualityMaterialHoldItemModel.fromJson(Map<String, dynamic> srcJson) => _$QualityMaterialHoldItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QualityMaterialHoldItemModelToJson(this);

}

  
