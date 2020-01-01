import 'package:json_annotation/json_annotation.dart'; 
  
part 'ProjectScrapItemModel.g.dart';


@JsonSerializable()
  class ProjectScrapItemModel extends Object {

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

  ProjectScrapItemModel(this.ScrapCodeID,this.ScrapCode,this.ScrapObject,this.ApllyLine,this.Description,this.Delflag,this.RowVersion,);

  factory ProjectScrapItemModel.fromJson(Map<String, dynamic> srcJson) => _$ProjectScrapItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProjectScrapItemModelToJson(this);

}

  
