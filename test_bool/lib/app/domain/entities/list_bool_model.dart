
import 'package:hive/hive.dart';
part 'list_bool_model.g.dart';
@HiveType(typeId: 0)
class listBoolModel {
  listBoolModel(this.listBool);
  @HiveField(0)
  final List listBool;

  @override
  listBoolModel.registerAdapter (this.listBool);
}