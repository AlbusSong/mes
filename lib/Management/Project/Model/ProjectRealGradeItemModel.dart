import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectRealGradeItemModel.g.dart';


@JsonSerializable()
  class ProjectRealGradeItemModel extends Object {

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

  ProjectRealGradeItemModel(this.LevelMatchID,this.ProdClassCode,this.Level,this.IsDefaultLevel,this.Delflag,this.RowVersion,);

  factory ProjectRealGradeItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectRealGradeItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectRealGradeItemModelToJson(this);

}

  
