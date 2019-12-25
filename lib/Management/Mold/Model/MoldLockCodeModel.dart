import 'package:json_annotation/json_annotation.dart'; 
  
part 'MoldLockCodeModel.g.dart';


@JsonSerializable()
  class MoldLockCodeModel extends Object {

  @JsonKey(name: 'LockCode')
  String LockCode;

  @JsonKey(name: 'Description')
  String Description;

  @JsonKey(name: 'LockCodeID')
  String LockCodeID;

  MoldLockCodeModel(this.LockCode,this.Description,this.LockCodeID,);

  factory MoldLockCodeModel.fromJson(Map<String, dynamic> srcJson) => _$MoldLockCodeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MoldLockCodeModelToJson(this);

}

  
