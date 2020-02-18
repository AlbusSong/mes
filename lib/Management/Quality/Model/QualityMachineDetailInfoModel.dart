import 'package:json_annotation/json_annotation.dart'; 
  
part 'QualityMachineDetailInfoModel.g.dart';


@JsonSerializable()
  class QualityMachineDetailInfoModel extends Object {

  @JsonKey(name: 'Standard')
  String Standard;

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'MECPlanNo')
  String MECPlanNo;

  @JsonKey(name: 'ProductType')
  String ProductType;

  @JsonKey(name: 'Product')
  String Product;

  @JsonKey(name: 'JudgeStandard')
  String JudgeStandard;

  @JsonKey(name: 'UpperSpecLimit')
  double UpperSpecLimit;

  @JsonKey(name: 'LowerSpecLimit')
  double LowerSpecLimit;

  @JsonKey(name: 'Unit')
  String Unit;

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

  QualityMachineDetailInfoModel(this.Standard,this.ID,this.MECPlanNo,this.ProductType,this.Product,this.JudgeStandard,this.UpperSpecLimit,this.LowerSpecLimit,this.Unit,this.Delflag,this.CreateTime,this.Creator,this.Comment,this.RowVersion,this.DataGroup,);

  factory QualityMachineDetailInfoModel.fromJson(Map<String, dynamic> srcJson) => _$QualityMachineDetailInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QualityMachineDetailInfoModelToJson(this);

}

  
