import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectPushPersonItemModel.g.dart';


@JsonSerializable()
  class ProjectPushPersonItemModel extends Object {

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'LineCode')
  String LineCode;

  @JsonKey(name: 'UserID')
  String UserID;

  @JsonKey(name: 'StartDateTime')
  String StartDateTime;

  @JsonKey(name: 'EndDateTime')
  String EndDateTime;

  @JsonKey(name: 'KaoQinDate')
  String KaoQinDate;

  @JsonKey(name: 'WorkTime')
  double WorkTime;

  @JsonKey(name: 'Shift')
  String Shift;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'Comment')
  String Comment;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectPushPersonItemModel(this.ID,this.LineCode,this.UserID,this.StartDateTime,this.EndDateTime,this.KaoQinDate,this.WorkTime,this.Shift,this.Delflag,this.CreateTime,this.Creator,this.Comment,this.RowVersion,);

  factory ProjectPushPersonItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectPushPersonItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectPushPersonItemModelToJson(this);

}

  
