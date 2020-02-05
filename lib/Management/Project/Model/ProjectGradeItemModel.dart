import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectGradeItemModel.g.dart';


@JsonSerializable()
  class ProjectGradeItemModel extends Object {

  @JsonKey(name: 'LevelMatchID')
  int LevelMatchID;

  @JsonKey(name: 'ProdClassCode')
  String ProdClassCode;

  @JsonKey(name: 'Level')
  String Level;

  @JsonKey(name: 'IsDefaultLevel')
  bool IsDefaultLevel;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectGradeItemModel(this.LevelMatchID,this.ProdClassCode,this.Level,this.IsDefaultLevel,this.Delflag,this.RowVersion,);

  factory ProjectGradeItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectGradeItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectGradeItemModelToJson(this);

}

  
