import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectRepairListItemModel.g.dart';


@JsonSerializable()
  class ProjectRepairListItemModel extends Object {

  @JsonKey(name: 'RPWO')
  String RPWO;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'OTime')
  String OTime;

  @JsonKey(name: 'Type')
  String Type;

  @JsonKey(name: 'TypeDesc')
  String TypeDesc;

  @JsonKey(name: 'Wono')
  String Wono;

  @JsonKey(name: 'LotNo')
  String LotNo;

  @JsonKey(name: 'Qty')
  int Qty;

  @JsonKey(name: 'RepairCode')
  String RepairCode;

  @JsonKey(name: 'ProcessCode')
  String ProcessCode;

  @JsonKey(name: 'ProcessName')
  String ProcessName;

  @JsonKey(name: 'BopVersion')
  String BopVersion;

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'ItemName')
  String ItemName;

  @JsonKey(name: 'ProdClass')
  String ProdClass;

  @JsonKey(name: 'Grade')
  String Grade;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'WorkCenterCode')
  String WorkCenterCode;

  @JsonKey(name: 'WorkCenterName')
  String WorkCenterName;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'Status')
  int Status;

  ProjectRepairListItemModel(this.RPWO,this.CreateTime,this.OTime,this.Type,this.TypeDesc,this.Wono,this.LotNo,this.Qty,this.RepairCode,this.ProcessCode,this.ProcessName,this.BopVersion,this.ItemCode,this.ItemName,this.ProdClass,this.Grade,this.LineCode,this.LineName,this.WorkCenterCode,this.WorkCenterName,this.Comment,this.Status,);

  factory ProjectRepairListItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectRepairListItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectRepairListItemModelToJson(this);

}

  
