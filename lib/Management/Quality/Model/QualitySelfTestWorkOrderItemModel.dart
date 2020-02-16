import 'package:json_annotation/json_annotation.dart'; 
  
part 'QualitySelfTestWorkOrderItemModel.g.dart';


@JsonSerializable()
  class QualitySelfTestWorkOrderItemModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'MECWorkOrderNo')
  String MECWorkOrderNo;

  @JsonKey(name: 'MECPlanNo')
  String MECPlanNo;

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

  QualitySelfTestWorkOrderItemModel(this.ID,this.MECWorkOrderNo,this.MECPlanNo,this.Item,this.State,this.WOType,this.LineCode,this.LineName,this.StepCode,this.Step,this.MethodTool,this.StartTime,this.CutOffTime,this.AppTime,this.AppWoType,this.AppStandard,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory QualitySelfTestWorkOrderItemModel.fromJson(Map<String, dynamic> srcJson) => _$QualitySelfTestWorkOrderItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QualitySelfTestWorkOrderItemModelToJson(this);

}

  
