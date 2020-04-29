import 'package:json_annotation/json_annotation.dart'; 
  
part 'NotificationItemModel.g.dart';


@JsonSerializable()
  class NotificationItemModel extends Object {

  @JsonKey(name: 'PushCode')
  String PushCode;

  @JsonKey(name: 'PushType')
  int PushType;

  @JsonKey(name: 'PushSubject')
  String PushSubject;

  @JsonKey(name: 'PushText')
  String PushText;

  @JsonKey(name: 'PushFunctionCode')
  String PushFunctionCode;

  @JsonKey(name: 'PushStatus')
  int PushStatus;

  @JsonKey(name: 'CreateTime')
  String CreateTime;

  NotificationItemModel(this.PushCode,this.PushType,this.PushSubject,this.PushText,this.PushFunctionCode,this.PushStatus,);

  factory NotificationItemModel.fromJson(Map<String, dynamic> srcJson) => _$NotificationItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NotificationItemModelToJson(this);

}

  
