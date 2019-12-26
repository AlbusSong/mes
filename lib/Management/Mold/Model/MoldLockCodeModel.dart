import 'package:json_annotation/json_annotation.dart';

part 'MoldLockCodeModel.g.dart';


@JsonSerializable()
class MoldLockCodeModel extends Object {

  @JsonKey(name: 'LockCodeID')
  int LockCodeID;

  @JsonKey(name: 'LockCode')
  String LockCode;

  @JsonKey(name: 'LockObject')
  int LockObject;

  @JsonKey(name: 'ApllyLine')
  String ApllyLine;

  @JsonKey(name: 'Description')
  String Description;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  MoldLockCodeModel(this.LockCodeID,this.LockCode,this.LockObject,this.ApllyLine,this.Description,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory MoldLockCodeModel.fromJson(Map<String, dynamic> srcJson) => _$MoldLockCodeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MoldLockCodeModelToJson(this);

}