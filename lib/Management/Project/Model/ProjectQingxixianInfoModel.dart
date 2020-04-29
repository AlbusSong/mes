import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectQingxixianInfoModel.g.dart';


@JsonSerializable()
  class ProjectQingxixianInfoModel extends Object {

  @JsonKey(name: 'ProcessCode')
  String ProcessCode;

  @JsonKey(name: 'ProcessName')
  String ProcessName;

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'ItemName')
  String ItemName;

  @JsonKey(name: 'Grade')
  String Grade;

  ProjectQingxixianInfoModel(this.ProcessCode,this.ProcessName,this.ItemCode,this.ItemName,this.Grade,);

  factory ProjectQingxixianInfoModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectQingxixianInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectQingxixianInfoModelToJson(this);

}

  
