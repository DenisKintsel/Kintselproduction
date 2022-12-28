// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_detailed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsDetailedModel _$NewsDetailedModelFromJson(Map<String, dynamic> json) =>
    NewsDetailedModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      date: json['date'] as String?,
      text: json['text'] as String?,
      url: json['url'] as String?,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$NewsDetailedModelToJson(NewsDetailedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'text': instance.text,
      'url': instance.url,
      'img': instance.img,
    };
