import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectScrapScrapCodeItemModel.g.dart';


@JsonSerializable()
  class ProjectScrapScrapCodeItemModel extends Object {

  @JsonKey(name: 'ScrapCodeID')
  int ScrapCodeID;

  @JsonKey(name: 'ScrapCode')
  String ScrapCode;

  @JsonKey(name: 'ScrapObject')
  int ScrapObject;

  @JsonKey(name: 'ApllyLine')
  String ApllyLine;

  @JsonKey(name: 'Description')
  String Description;

  @JsonKey(name: 'Delflag')
  bool Delflag;

  @JsonKey(name: 'RowVersion')
  String RowVersion;

  ProjectScrapScrapCodeItemModel(this.ScrapCodeID,this.ScrapCode,this.ScrapObject,this.ApllyLine,this.Description,this.Delflag,this.RowVersion,);

  factory ProjectScrapScrapCodeItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectScrapScrapCodeItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectScrapScrapCodeItemModelToJson(this);

}

  
