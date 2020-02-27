import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectReturnRepairmentRepairCodeItemModel.g.dart';


@JsonSerializable()
  class ProjectReturnRepairmentRepairCodeItemModel extends Object {

  @JsonKey(name: 'LOTRepairCodeID')
  int LOTRepairCodeID;

  @JsonKey(name: 'LOTRepairCode')
  String LOTRepairCode;

  @JsonKey(name: 'ApllyLine')
  String ApllyLine;

  @JsonKey(name: 'Description')
  String Description;

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

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectReturnRepairmentRepairCodeItemModel(this.LOTRepairCodeID,this.LOTRepairCode,this.ApllyLine,this.Description,this.Delflag,this.CreateTime,this.Creator,this.ModifiedTime,this.Modifier,this.RowVersion,);

  factory ProjectReturnRepairmentRepairCodeItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectReturnRepairmentRepairCodeItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectReturnRepairmentRepairCodeItemModelToJson(this);

}

  
