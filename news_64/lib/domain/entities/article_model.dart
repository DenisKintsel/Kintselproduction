import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 2)
class articleModel {
  articleModel(this.newsArticleBD);

  @HiveField(0)
  final List newsArticleBD;

  @override
  articleModel.registerAdapter(this.newsArticleBD);
}