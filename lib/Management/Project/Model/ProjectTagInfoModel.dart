import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectTagInfoModel.g.dart';


@JsonSerializable()
  class ProjectTagInfoModel extends Object {

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'TagID')
  String TagID;

  @JsonKey(name: 'Qty')
  double Qty;

  @JsonKey(name: 'Cost')
  double Cost;

  @JsonKey(name: 'Sequence')
  int Sequence;

  @JsonKey(name: 'ProductionBatch')
  String ProductionBatch;

  @JsonKey(name: 'Unit')
  String Unit;

  @JsonKey(name: 'OrderNo')
  String OrderNo;

  @JsonKey(name: 'State')
  int State;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'DataGroup')
  String DataGroup;

  ProjectTagInfoModel(this.ItemCode,this.TagID,this.Qty,this.Cost,this.Sequence,this.ProductionBatch,this.Unit,this.OrderNo,this.State,this.Delflag,this.Comment,this.DataGroup,);

  factory ProjectTagInfoModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectTagInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectTagInfoModelToJson(this);

}

  
