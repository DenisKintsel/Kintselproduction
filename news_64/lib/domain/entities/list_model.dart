import 'package:hive/hive.dart';
import 'package:news_64/core_global/models/news_model/news_model.dart';

part 'list_model.g.dart';

@HiveType(typeId: 0)
class listModel {
  listModel(this.newsBD);

  @HiveField(0)
  final List newsBD;

  @override
  listModel.registerAdapter(this.newsBD);
}
