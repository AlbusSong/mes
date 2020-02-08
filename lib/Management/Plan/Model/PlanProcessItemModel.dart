import 'package:json_annotation/json_annotation.dart'; 
  
part 'PlanProcessItemModel.g.dart';


@JsonSerializable()
  class PlanProcessItemModel extends Object {

  @JsonKey(name: 'WoGoodQty')
  double WoGoodQty;

  @JsonKey(name: 'ProductName')
  String ProductName;

  @JsonKey(name: 'ProcessName')
  String ProcessName;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'CompRate')
  double CompRate;

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'Wono')
  String Wono;

  @JsonKey(name: 'Pdno')
  String Pdno;

  @JsonKey(name: 'LineCode')
  String LineCode;

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

  @JsonKey(name: 'WoStartDate')
  String WoStartDate;

  @JsonKey(name: 'PreState')
  int PreState;

  @JsonKey(name: 'Rpno')
  String Rpno;

  @JsonKey(name: 'BopVersion')
  String BopVersion;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'DataGroup')
  String DataGroup;

  PlanProcessItemModel(this.WoGoodQty,this.ProductName,this.ProcessName,this.LineName,this.CompRate,this.ID,this.Wono,this.Pdno,this.LineCode,this.ProjectCode,this.ItemCode,this.ItemName,this.WoDate,this.PdFTime,this.Shift,this.WoPlanQty,this.State,this.StateDesc,this.WoOutPutQty,this.WoReturnQty,this.WoBadQty,this.WoScrapQty,this.WoRepareQty,this.WoStartDate,this.PreState,this.Rpno,this.BopVersion,this.Delflag,this.CreateTime,this.Comment,this.DataGroup,);

  factory PlanProcessItemModel.fromJson(Map<String, dynamic> srcJson) => _$PlanProcessItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlanProcessItemModelToJson(this);

}

  
