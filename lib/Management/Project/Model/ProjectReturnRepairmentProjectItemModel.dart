import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectReturnRepairmentProjectItemModel.g.dart';


@JsonSerializable()
  class ProjectReturnRepairmentProjectItemModel extends Object {

  @JsonKey(name: 'ProcessID')
  int ProcessID;

  @JsonKey(name: 'Sequence')
  String Sequence;

  @JsonKey(name: 'ParentSequence')
  String ParentSequence;

  @JsonKey(name: 'ProcessCode')
  String ProcessCode;

  @JsonKey(name: 'ProcessName')
  String ProcessName;

  @JsonKey(name: 'ProdClassCode')
  String ProdClassCode;

  @JsonKey(name: 'Line')
  String Line;

  @JsonKey(name: 'WorkCenter')
  String WorkCenter;

  @JsonKey(name: 'ManPower')
  String ManPower;

  @JsonKey(name: 'YieldTarget')
  double YieldTarget;

  @JsonKey(name: 'OperRate')
  double OperRate;

  @JsonKey(name: 'PerformanceTarget')
  double PerformanceTarget;

  @JsonKey(name: 'PlanObject')
  bool PlanObject;

  @JsonKey(name: 'PSType')
  String PSType;

  @JsonKey(name: 'LOTStart')
  bool LOTStart;

  @JsonKey(name: 'LOTSend')
  String LOTSend;

  @JsonKey(name: 'LOTPrint')
  bool LOTPrint;

  @JsonKey(name: 'CToolCollection')
  bool CToolCollection;

  @JsonKey(name: 'IsKitFeed')
  bool IsKitFeed;

  @JsonKey(name: 'PlanWay')
  String PlanWay;

  @JsonKey(name: 'LeadTime')
  double LeadTime;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'ModifiedTime')
  String ModifiedTime;

  @JsonKey(name: 'Modifier')
  String Modifier;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  @JsonKey(name: 'DataGroup')
  String DataGroup;

  ProjectReturnRepairmentProjectItemModel(this.ProcessID,this.Sequence,this.ParentSequence,this.ProcessCode,this.ProcessName,this.ProdClassCode,this.Line,this.WorkCenter,this.ManPower,this.YieldTarget,this.OperRate,this.PerformanceTarget,this.PlanObject,this.PSType,this.LOTStart,this.LOTSend,this.LOTPrint,this.CToolCollection,this.IsKitFeed,this.PlanWay,this.LeadTime,this.Delflag,this.CreateTime,this.Creator,this.ModifiedTime,this.Modifier,this.Comment,this.RowVersion,this.DataGroup,);

  factory ProjectReturnRepairmentProjectItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectReturnRepairmentProjectItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectReturnRepairmentProjectItemModelToJson(this);

}

  
