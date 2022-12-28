import 'package:freezed_annotation/freezed_annotation.dart';
part 'gallery.g.dart';

@JsonSerializable()
class Gallery {
  int? sortId;
  String? smallImg;
  String? bigImg;

  Gallery({this.sortId, this.smallImg, this.bigImg});

  factory Gallery.fromJson(Map<String, dynamic> json) =>
      _$GalleryFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryToJson(this);
}