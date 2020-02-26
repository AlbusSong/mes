import 'package:json_annotation/json_annotation.dart'; 
  
part 'QualityPatrolTestWorkOrderItemModel.g.dart';


@JsonSerializable()
  class QualityPatrolTestWorkOrderItemModel extends Object {

  @JsonKey(name: 'IPQCWoNo')
  String IPQCWoNo;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'WCCode')
  String WCCode;

  @JsonKey(name: 'WCName')
  String WCName;

  @JsonKey(name: 'IPQCType')
  String IPQCType;

  @JsonKey(name: 'State')
  String State;

  @JsonKey(name: 'StartTime')
  String StartTime;

  @JsonKey(name: 'WaitTime')
  double WaitTime;

  @JsonKey(name: 'IPQCPlanNo')
  String IPQCPlanNo;

  @JsonKey(name: 'AppTime')
  String AppTime;

  @JsonKey(name: 'AppIPQCType')
  String AppIPQCType;

  QualityPatrolTestWorkOrderItemModel(this.IPQCWoNo,this.LineCode,this.LineName,this.WCCode,this.WCName,this.IPQCType,this.State,this.StartTime,this.WaitTime,this.IPQCPlanNo,this.AppTime,this.AppIPQCType,);

  factory QualityPatrolTestWorkOrderItemModel.fromJson(Map<String, dynamic> srcJson) => _$QualityPatrolTestWorkOrderItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QualityPatrolTestWorkOrderItemModelToJson(this);

}

  
