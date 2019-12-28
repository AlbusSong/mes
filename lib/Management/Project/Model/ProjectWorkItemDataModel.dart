import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectWorkItemDataModel.g.dart';


@JsonSerializable()
  class ProjectWorkItemDataModel extends Object {

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

  ProjectWorkItemDataModel(this.WorkCenterID,this.WorkCenterCode,this.WorkCenterName,this.LineCode,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProjectWorkItemDataModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectWorkItemDataModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectWorkItemDataModelToJson(this);

}

  
