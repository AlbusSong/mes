import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectTodayWorkOrderModel.g.dart';


@JsonSerializable()
  class ProjectTodayWorkOrderModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'Wono')
  String Wono;

  @JsonKey(name: 'Pdno')
  String Pdno;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'WorkCenterCode')
  String WorkCenterCode;

  @JsonKey(name: 'ProjectCode')
  String ProjectCode;

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'ItemName')
  String ItemName;

  @JsonKey(name: 'WoDate')
  String WoDate;

  @JsonKey(name: 'PdFTime')
  String PdFTime;

  @JsonKey(name: 'Shift')
  String Shift;

  @JsonKey(name: 'WoPlanQty')
  double WoPlanQty;

  @JsonKey(name: 'State')
  int State;

  @JsonKey(name: 'StateDesc')
  String StateDesc;

  @JsonKey(name: 'WoOutPutQty')
  double WoOutPutQty;

  @JsonKey(name: 'WoReturnQty')
  double WoReturnQty;

  @JsonKey(name: 'WoBadQty')
  double WoBadQty;

  @JsonKey(name: 'WoScrapQty')
  double WoScrapQty;

  @JsonKey(name: 'WoRepareQty')
  double WoRepareQty;

  @JsonKey(name: 'PreState')
  int PreState;

  @JsonKey(name: 'Rpno')
  String Rpno;

  @JsonKey(name: 'ProductCode')
  String ProductCode;

  @JsonKey(name: 'SWareHouse')
  String SWareHouse;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'Modifier')
  String Modifier;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  @JsonKey(name: 'DataGroup')
  String DataGroup;

  ProjectTodayWorkOrderModel(this.ID,this.Wono,this.Pdno,this.LineCode,this.WorkCenterCode,this.ProjectCode,this.ItemCode,this.ItemName,this.WoDate,this.PdFTime,this.Shift,this.WoPlanQty,this.State,this.StateDesc,this.WoOutPutQty,this.WoReturnQty,this.WoBadQty,this.WoScrapQty,this.WoRepareQty,this.PreState,this.Rpno,this.ProductCode,this.SWareHouse,this.Delflag,this.CreateTime,this.Creator,this.Modifier,this.Comment,this.RowVersion,this.DataGroup,);

  factory ProjectTodayWorkOrderModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectTodayWorkOrderModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectTodayWorkOrderModelToJson(this);

}

  
