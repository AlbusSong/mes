import 'package:json_annotation/json_annotation.dart'; 
  
part 'QualityMachineTypeItemModel.g.dart';


@JsonSerializable()
  class QualityMachineTypeItemModel extends Object {

  @JsonKey(name: 'ItemCode')
  String ItemCode;

  @JsonKey(name: 'ItemName')
  String ItemName;

  @JsonKey(name: 'State')
  int State;

  @JsonKey(name: 'AppState')
  String AppState;

  QualityMachineTypeItemModel(this.ItemCode,this.ItemName,this.State,this.AppState,);

  factory QualityMachineTypeItemModel.fromJson(Map<String, dynamic> srcJson) => _$QualityMachineTypeItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$QualityMachineTypeItemModelToJson(this);

}

  
