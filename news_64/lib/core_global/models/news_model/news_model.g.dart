// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) => NewsModel(
      id: json['id'] as String?,
      img: json['img'] as String?,
      date: json['date'] as String?,
      title: json['title'] as String?,
      important: json['important'] as int?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'date': instance.date,
      'title': instance.title,
      'important': instance.important,
      'subtitle': instance.subtitle,
    };
