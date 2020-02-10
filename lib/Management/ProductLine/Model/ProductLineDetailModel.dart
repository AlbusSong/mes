import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProductLineDetailModel.g.dart';


@JsonSerializable()
  class ProductLineDetailModel extends Object {

  @JsonKey(name: 'CurrProductName')
  String CurrProductName;

  @JsonKey(name: 'CurrStateName')
  String CurrStateName;

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'CurrState')
  String CurrState;

  @JsonKey(name: 'CurrStateDesc')
  int CurrStateDesc;

  @JsonKey(name: 'PreState')
  String PreState;

  @JsonKey(name: 'PreStateDesc')
  int PreStateDesc;

  @JsonKey(name: 'Remark')
  String Remark;

  @JsonKey(name: 'ExceptionType')
  String ExceptionType;

  @JsonKey(name: 'ExceptionWorkOrder')
  String ExceptionWorkOrder;

  @JsonKey(name: 'BADALARMType')
  String BADALARMType;

  @JsonKey(name: 'BADALARMTypeDesc')
  int BADALARMTypeDesc;

  @JsonKey(name: 'BADALARMDate')
  String BADALARMDate;

  @JsonKey(name: 'CurrTime')
  String CurrTime;

  @JsonKey(name: 'PreTime')
  String PreTime;

  @JsonKey(name: 'CurrProductCode')
  String CurrProductCode;

  @JsonKey(name: 'PreProductCode')
  String PreProductCode;

  @JsonKey(name: 'FirstQCType')
  String FirstQCType;

  @JsonKey(name: 'LineOEE')
  double LineOEE;

  @JsonKey(name: 'LineMobility')
  double LineMobility;

  @JsonKey(name: 'LineYield')
  double LineYield;

  @JsonKey(name: 'LineExpressivity')
  double LineExpressivity;

  @JsonKey(name: 'ProductNo')
  String ProductNo;

  @JsonKey(name: 'PlanNumber')
  int PlanNumber;

  @JsonKey(name: 'ActualNumber')
  int ActualNumber;

  @JsonKey(name: 'PassageRate')
  double PassageRate;

  @JsonKey(name: 'DirectPassRate')
  double DirectPassRate;

  @JsonKey(name: 'Progress')
  double Progress;

  @JsonKey(name: 'ReworkNumber')
  int ReworkNumber;

  @JsonKey(name: 'ScrapNumber')
  int ScrapNumber;

  @JsonKey(name: 'LockNumber')
  int LockNumber;

  @JsonKey(name: 'BadNumber')
  int BadNumber;

  @JsonKey(name: 'LineYieldPlan')
  double LineYieldPlan;

  @JsonKey(name: 'ProgressPlan')
  double ProgressPlan;

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

  ProductLineDetailModel(this.CurrProductName,this.CurrStateName,this.ID,this.LineCode,this.LineName,this.CurrState,this.CurrStateDesc,this.PreState,this.PreStateDesc,this.Remark,this.ExceptionType,this.ExceptionWorkOrder,this.BADALARMType,this.BADALARMTypeDesc,this.BADALARMDate,this.CurrTime,this.PreTime,this.CurrProductCode,this.PreProductCode,this.FirstQCType,this.LineOEE,this.LineMobility,this.LineYield,this.LineExpressivity,this.ProductNo,this.PlanNumber,this.ActualNumber,this.PassageRate,this.DirectPassRate,this.Progress,this.ReworkNumber,this.ScrapNumber,this.LockNumber,this.BadNumber,this.LineYieldPlan,this.ProgressPlan,this.Delflag,this.CreateTime,this.Creator,this.ModifiedTime,this.Modifier,this.RowVersion,);

  factory ProductLineDetailModel.fromJson(Map<String, dynamic> srcJson) => _$ProductLineDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductLineDetailModelToJson(this);

}

  
