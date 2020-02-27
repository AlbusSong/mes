import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectReturnRepairmentReasonProcessItemModel.g.dart';


@JsonSerializable()
  class ProjectReturnRepairmentReasonProcessItemModel extends Object {

  @JsonKey(name: 'StepID')
  int StepID;

  @JsonKey(name: 'StepCode')
  String StepCode;

  @JsonKey(name: 'StepName')
  String StepName;

  @JsonKey(name: 'StepType')
  String StepType;

  @JsonKey(name: 'ProcessCode')
  String ProcessCode;

  @JsonKey(name: 'Line')
  String Line;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectReturnRepairmentReasonProcessItemModel(this.StepID,this.StepCode,this.StepName,this.StepType,this.ProcessCode,this.Line,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProjectReturnRepairmentReasonProcessItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectReturnRepairmentReasonProcessItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectReturnRepairmentReasonProcessItemModelToJson(this);

}

  
