import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectItemModel.g.dart';


@JsonSerializable()
  class ProjectItemModel extends Object {

  @JsonKey(name: 'LOTSize')
  int LOTSize;

  @JsonKey(name: 'StatusDesc')
  String StatusDesc;

  @JsonKey(name: 'HoldDesc')
  String HoldDesc;

  @JsonKey(name: 'CTime')
  String CTime;

  @JsonKey(name: 'OTime')
  String OTime;

  @JsonKey(name: 'LevelManage')
  String LevelManage;

  @JsonKey(name: 'ProdClassCode')
  String ProdClassCode;

  @JsonKey(name: 'LotNo')
  String LotNo;

  @JsonKey(name: 'Status')
  int Status;

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

  @JsonKey(name: 'Wono')
  String Wono;

  @JsonKey(name: 'OrderNo')
  String OrderNo;

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

  @JsonKey(name: 'Barcode')
  String Barcode;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'ModifiedTime')
  String ModifiedTime;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'DataGroup')
  String DataGroup;

  ProjectItemModel(this.LOTSize,this.StatusDesc,this.HoldDesc,this.CTime,this.OTime,this.LevelManage,this.ProdClassCode,this.LotNo,this.Status,this.Hold,this.HoldCode,this.ProcessCode,this.ProcessName,this.ItemCode,this.ItemName,this.Dscb,this.Qty,this.Cost,this.CToolNo,this.Wono,this.OrderNo,this.Grade,this.LineCode,this.LineName,this.WorkCenterCode,this.WorkCenterName,this.Barcode,this.Delflag,this.CreateTime,this.ModifiedTime,this.Comment,this.DataGroup,);

  factory ProjectItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectItemModelToJson(this);

}

  
