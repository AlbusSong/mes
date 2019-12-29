import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectLineModel.g.dart';


@JsonSerializable()
  class ProjectLineModel extends Object {

  @JsonKey(name: 'LineID')
  int LineID;

  @JsonKey(name: 'WShopCode')
  String WShopCode;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'LineName')
  String LineName;

  @JsonKey(name: 'YieldTarget')
  double YieldTarget;

  @JsonKey(name: 'Description')
  String Description;

  @JsonKey(name: 'ValidStatus')
  String ValidStatus;

  @JsonKey(name: 'FileName')
  String FileName;

  @JsonKey(name: 'Length')
  int Length;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectLineModel(this.LineID,this.WShopCode,this.LineCode,this.LineName,this.YieldTarget,this.Description,this.ValidStatus,this.FileName,this.Length,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProjectLineModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectLineModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectLineModelToJson(this);

}

  
