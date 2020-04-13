import 'package:json_annotation/json_annotation.dart'; 
  
part 'QualitySelfTestItemModel.g.dart';


@JsonSerializable()
  class QualitySelfTestItemModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'MECWorkOrderNo')
  String MECWorkOrderNo;

  @JsonKey(name: 'MECPlanNo')
  String MECPlanNo;

  @JsonKey(name: 'Actual')
  String Actual;

  @JsonKey(name: 'Item')
  String Item;

  @JsonKey(name: 'State')
  String State;

  @JsonKey(name: 'WOType')
  String WOType;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'StepCode')
  String StepCode;

  @JsonKey(name: 'Step')
  String Step;

  @JsonKey(name: 'Product')
  String Product;

  @JsonKey(name: 'Judge')
  String Judge;

  @JsonKey(name: 'UpperSpecLimit')
  double UpperSpecLimit;

  @JsonKey(name: 'LowerSpecLimit')
  double LowerSpecLimit;

  @JsonKey(name: 'Unit')
  String Unit;

  @JsonKey(name: 'MethodTool')
  String MethodTool;

  @JsonKey(name: 'StartTime')
  String StartTime;

  @JsonKey(name: 'CutOffTime')
  String CutOffTime;

  @JsonKey(name: 'AppTime')
  String AppTime;

  @JsonKey(name: 'AppWoType')
  String AppWoType;

  @JsonKey(name: 'AppStandard')
  String AppStandard;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  QualitySelfTestItemModel(this.ID,this.MECWorkOrderNo,this.MECPlanNo,this.Item,this.State,this.WOType,this.LineCode,this.LineName,this.StepCode,this.Step,this.Product,this.Judge,this.UpperSpecLimit,this.LowerSpecLimit,this.Unit,this.MethodTool,this.StartTime,this.CutOffTime,this.AppTime,this.AppWoType,this.AppStandard,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory QualitySelfTestItemModel.fromJson(Map<String, dynamic> srcJson) => _$QualitySelfTestItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QualitySelfTestItemModelToJson(this);

}

  
