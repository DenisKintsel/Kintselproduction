import 'package:dartz/dartz.dart';

import '../../core_global/error/failure.dart';
import '../entities/user_model.dart';

abstract class RepositoryHive {
  Future<Either<Failure, userModel>> checkHiveUser();
}