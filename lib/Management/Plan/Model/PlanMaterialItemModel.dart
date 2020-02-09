import 'package:json_annotation/json_annotation.dart'; 
  
part 'PlanMaterialItemModel.g.dart';


@JsonSerializable()
  class PlanMaterialItemModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'ExportNo')
  String ExportNo;

  @JsonKey(name: 'State')
  String State;

  @JsonKey(name: 'DestWareHouseID')
  String DestWareHouseID;

  @JsonKey(name: 'WorkOrderNo')
  String WorkOrderNo;

  @JsonKey(name: 'Line')
  String Line;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'Compounder')
  String Compounder;

  @JsonKey(name: 'NeedDate')
  String NeedDate;

  @JsonKey(name: 'PrepareTime')
  String PrepareTime;

  @JsonKey(name: 'MoutTime')
  String MoutTime;

  @JsonKey(name: 'ReceiveTime')
  String ReceiveTime;

  @JsonKey(name: 'AprTime')
  String AprTime;

  @JsonKey(name: 'Approver')
  String Approver;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  PlanMaterialItemModel(this.ID,this.ExportNo,this.State,this.DestWareHouseID,this.WorkOrderNo,this.Line,this.LineName,this.Compounder,this.NeedDate,this.PrepareTime,this.MoutTime,this.ReceiveTime,this.AprTime,this.Approver,this.CreateTime,this.Creator,);

  factory PlanMaterialItemModel.fromJson(Map<String, dynamic> srcJson) => _$PlanMaterialItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlanMaterialItemModelToJson(this);

}

  
