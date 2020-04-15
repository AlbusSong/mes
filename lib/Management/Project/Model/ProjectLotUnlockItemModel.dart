import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectLotUnlockItemModel.g.dart';


@JsonSerializable()
  class ProjectLotUnlockItemModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'LotNo')
  String LotNo;

  @JsonKey(name: 'Status')
  int Status;

  @JsonKey(name: 'StatusDesc')
  String StatusDesc;

  @JsonKey(name: 'Hold')
  String Hold;

  @JsonKey(name: 'HoldCode')
  String HoldCode;

  @JsonKey(name: 'ProcessCode')
  String ProcessCode;

  @JsonKey(name: 'ProcessName')
  String ProcessName;

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'ItemName')
  String ItemName;

  @JsonKey(name: 'Dscb')
  String Dscb;

  @JsonKey(name: 'Qty')
  int Qty;

  @JsonKey(name: 'Cost')
  int Cost;

  @JsonKey(name: 'CToolNo')
  String CToolNo;

  @JsonKey(name: 'FlowCode')
  String FlowCode;

  @JsonKey(name: 'FlowName')
  String FlowName;

  @JsonKey(name: 'Wono')
  String Wono;

  @JsonKey(name: 'OrderNo')
  String OrderNo;

  @JsonKey(name: 'Grade')
  String Grade;

  @JsonKey(name: 'Location')
  String Location;

  @JsonKey(name: 'RepairCode')
  String RepairCode;

  @JsonKey(name: 'ScrapCode')
  String ScrapCode;

  @JsonKey(name: 'FromLot')
  String FromLot;

  @JsonKey(name: 'IntoLot')
  String IntoLot;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'WorkCenterCode')
  String WorkCenterCode;

  @JsonKey(name: 'WorkCenterName')
  String WorkCenterName;

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

  ProjectLotUnlockItemModel(this.ID,this.LotNo,this.Status,this.StatusDesc,this.Hold,this.HoldCode,this.ProcessCode,this.ProcessName,this.ItemCode,this.ItemName,this.Dscb,this.Qty,this.Cost,this.CToolNo,this.FlowCode,this.FlowName,this.Wono,this.OrderNo,this.Grade,this.Location,this.RepairCode,this.ScrapCode,this.FromLot,this.IntoLot,this.LineCode,this.LineName,this.WorkCenterCode,this.WorkCenterName,this.Delflag,this.CreateTime,this.Creator,this.ModifiedTime,this.Modifier,this.Comment,this.RowVersion,);

  factory ProjectLotUnlockItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectLotUnlockItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectLotUnlockItemModelToJson(this);

}

  
