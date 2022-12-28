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
    )..gallery = (json['gallery'] as List<dynamic>?)
        ?.map((e) => Gallery.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$NewsDetailedModelToJson(NewsDetailedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'text': instance.text,
      'url': instance.url,
      'gallery': instance.gallery,
      'img': instance.img,
    };
