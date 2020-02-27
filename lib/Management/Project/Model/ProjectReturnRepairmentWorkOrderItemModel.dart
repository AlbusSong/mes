import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectReturnRepairmentWorkOrderItemModel.g.dart';


@JsonSerializable()
  class ProjectReturnRepairmentWorkOrderItemModel extends Object {

  @JsonKey(name: 'WorkCenterID')
  int WorkCenterID;

  @JsonKey(name: 'WorkCenterCode')
  String WorkCenterCode;

  @JsonKey(name: 'WorkCenterName')
  String WorkCenterName;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectReturnRepairmentWorkOrderItemModel(this.WorkCenterID,this.WorkCenterCode,this.WorkCenterName,this.LineCode,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProjectReturnRepairmentWorkOrderItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectReturnRepairmentWorkOrderItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectReturnRepairmentWorkOrderItemModelToJson(this);

}

  
