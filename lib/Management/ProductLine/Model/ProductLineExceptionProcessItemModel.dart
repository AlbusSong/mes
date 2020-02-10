import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProductLineExceptionProcessItemModel.g.dart';


@JsonSerializable()
  class ProductLineExceptionProcessItemModel extends Object {

  @JsonKey(name: 'StepID')
  int StepID;

  @JsonKey(name: 'StepCode')
  String StepCode;

  @JsonKey(name: 'StepName')
  String StepName;

  @JsonKey(name: 'StepType')
  String StepType;

  @JsonKey(name: 'ProcessCode')
  String ProcessCode;

  @JsonKey(name: 'Line')
  String Line;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  @JsonKey(name: 'Creator')
  String Creator;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProductLineExceptionProcessItemModel(this.StepID,this.StepCode,this.StepName,this.StepType,this.ProcessCode,this.Line,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProductLineExceptionProcessItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProductLineExceptionProcessItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductLineExceptionProcessItemModelToJson(this);

}

  
