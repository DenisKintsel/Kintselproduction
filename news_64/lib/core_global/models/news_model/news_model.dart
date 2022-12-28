import 'package:freezed_annotation/freezed_annotation.dart';
part 'news_model.g.dart';
@JsonSerializable()
class NewsModel {
  String? id;
  String? img;
  String? date;
  String? title;
  int? important;
  String? subtitle;

  NewsModel({this.id,
    this.img,
    this.date,
    this.title,
    this.important,
    this.subtitle});

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);
}