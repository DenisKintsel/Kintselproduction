import 'package:freezed_annotation/freezed_annotation.dart';
part 'news_detailed_model.g.dart';

@JsonSerializable()
class NewsDetailedModel {
  String? id;
  String? title;
  String? date;
  String? text;
  String? url;
  String? img;

  NewsDetailedModel(
      {this.id, this.title, this.date, this.text, this.url, this.img});

  factory NewsDetailedModel.fromJson(Map<String, dynamic> json) =>
      _$NewsDetailedModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDetailedModelToJson(this);
}