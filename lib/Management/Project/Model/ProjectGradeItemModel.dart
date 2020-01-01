import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectGradeItemModel.g.dart';


@JsonSerializable()
  class ProjectGradeItemModel extends Object {

  @JsonKey(name: 'ProdClassID')
  int ProdClassID;

  @JsonKey(name: 'ProdClassCode')
  String ProdClassCode;

  @JsonKey(name: 'ProdClassName')
  String ProdClassName;

  @JsonKey(name: 'Cwar')
  String Cwar;

  @JsonKey(name: 'LevelManage')
  String LevelManage;

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

  ProjectGradeItemModel(this.ProdClassID,this.ProdClassCode,this.ProdClassName,this.Cwar,this.LevelManage,this.Description,this.Delflag,this.CreateTime,this.Creator,this.RowVersion,);

  factory ProjectGradeItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectGradeItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectGradeItemModelToJson(this);

}

  
