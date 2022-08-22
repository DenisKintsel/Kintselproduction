
import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 1)
class userModel {
  userModel(this.email, this.id, this.password, this.name, this.city);
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String city;

  @override
  userModel.registerAdapter (this.id, this.email, this.password, this.name, this.city);
}