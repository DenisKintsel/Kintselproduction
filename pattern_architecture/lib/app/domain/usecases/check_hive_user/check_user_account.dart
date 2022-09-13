import 'package:dartz/dartz.dart';

import 'package:pattern_architecture/app/core_global/error/failure.dart';

import '../../entities/user_model.dart';
import '../../repositories/repository_hive.dart';
import '../NoParams/usecase.dart';

class CheckHiveUseCasesUser extends UseCase<userModel, NoParams> {
  final RepositoryHive repositoryHive;

  CheckHiveUseCasesUser({required this.repositoryHive});

  @override
  Future<Either<Failure, userModel>> call(NoParams params) async {
    try {
      return repositoryHive.checkHiveUser();
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }
}
