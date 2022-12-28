import 'package:hive/hive.dart';

part 'important_model.g.dart';

@HiveType(typeId: 1)
class importantModel {
  importantModel(this.newsImportantBD);

  @HiveField(0)
  final List newsImportantBD;

  @override
  importantModel.registerAdapter(this.newsImportantBD);
}