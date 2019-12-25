import 'package:json_annotation/json_annotation.dart'; 
  
part 'MoldInModel.g.dart';


@JsonSerializable()
  class MoldInModel extends Object {

  @JsonKey(name: 'HoldStateDes')
  String HoldStateDes;

  @JsonKey(name: 'StorageStateDes')
  String StorageStateDes;

  @JsonKey(name: 'ID')
  int ID;

  @JsonKey(name: 'MouldNo')
  String MouldNo;

  @JsonKey(name: 'MouldCode')
  String MouldCode;

  @JsonKey(name: 'MouldName')
  String MouldName;

  @JsonKey(name: 'Qty')
  int Qty;

  @JsonKey(name: 'ActUseCount')
  int ActUseCount;

  @JsonKey(name: 'MouldStatus')
  String MouldStatus;

  @JsonKey(name: 'Location')
  String Location;

  @JsonKey(name: 'HoldState')
  bool HoldState;

  @JsonKey(name: 'HoldReasonCode')
  String HoldReasonCode;

  @JsonKey(name: 'HoldPerson')
  String HoldPerson;

  @JsonKey(name: 'HoldRemark')
  String HoldRemark;

  @JsonKey(name: 'UnHoldRemark')
  String UnHoldRemark;

  MoldInModel(this.HoldStateDes,this.StorageStateDes,this.ID,this.MouldNo,this.MouldCode,this.MouldName,this.Qty,this.ActUseCount,this.MouldStatus,this.Location,this.HoldState,this.HoldReasonCode,this.HoldPerson,this.HoldRemark,this.UnHoldRemark,);

  factory MoldInModel.fromJson(Map<String, dynamic> srcJson) => _$MoldInModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MoldInModelToJson(this);

}

  
