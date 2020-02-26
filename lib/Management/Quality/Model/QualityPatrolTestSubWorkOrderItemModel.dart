import 'package:json_annotation/json_annotation.dart'; 
  
part 'QualityPatrolTestSubWorkOrderItemModel.g.dart';


@JsonSerializable()
  class QualityPatrolTestSubWorkOrderItemModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'IPQCPlanNo')
  String IPQCPlanNo;

  @JsonKey(name: 'IPQCItemNo')
  String IPQCItemNo;

  @JsonKey(name: 'StepCode')
  String StepCode;

  @JsonKey(name: 'Step')
  String Step;

  @JsonKey(name: 'Item')
  String Item;

  @JsonKey(name: 'Week')
  String Week;

  @JsonKey(name: 'PublishTime')
  String PublishTime;

  @JsonKey(name: 'ProductApply')
  String ProductApply;

  @JsonKey(name: 'Product')
  String Product;

  @JsonKey(name: 'StandardType')
  String StandardType;

  @JsonKey(name: 'ManualStandard')
  String ManualStandard;

  @JsonKey(name: 'UpperSpecLimit')
  double UpperSpecLimit;

  @JsonKey(name: 'LowerSpecLimit')
  double LowerSpecLimit;

  @JsonKey(name: 'QTY')
  int QTY;

  @JsonKey(name: 'QTYRemark')
  String QTYRemark;

  @JsonKey(name: 'Method')
  String Method;

  @JsonKey(name: 'Tool')
  String Tool;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  @JsonKey(name: 'DataGroup')
  String DataGroup;

  QualityPatrolTestSubWorkOrderItemModel(this.ID,this.IPQCPlanNo,this.IPQCItemNo,this.StepCode,this.Step,this.Item,this.Week,this.PublishTime,this.ProductApply,this.Product,this.StandardType,this.ManualStandard,this.UpperSpecLimit,this.LowerSpecLimit,this.QTY,this.QTYRemark,this.Method,this.Tool,this.Delflag,this.CreateTime,this.Creator,this.Comment,this.RowVersion,this.DataGroup,);

  factory QualityPatrolTestSubWorkOrderItemModel.fromJson(Map<String, dynamic> srcJson) => _$QualityPatrolTestSubWorkOrderItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QualityPatrolTestSubWorkOrderItemModelToJson(this);

}

  
