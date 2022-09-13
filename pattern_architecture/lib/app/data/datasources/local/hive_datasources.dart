import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:pattern_architecture/app/core_global/error/failure.dart';
import 'package:pattern_architecture/app/domain/entities/user_model.dart';
import 'package:pattern_architecture/app/domain/repositories/repository_hive.dart';
import 'package:pattern_architecture/app/domain/usecases/NoParams/usecase.dart';

class HiveDataSourceImpl implements RepositoryHive {
  @override
  Future<Either<Failure, userModel>> checkHiveUser() async {
    try {
      final userBox = Hive.box<userModel>('user');
      if (userBox.values.isNotEmpty) {
        print('7777777777777777');
        print(userBox
            .get('user')
            ?.email);
        print('777777777777777777');
        final userModel user = userModel(
            userBox.values.last.email, userBox.values.last.id,
            userBox.values.last.password, userBox.values.last.name,
            userBox.values.last.city);
        return Right(user);
      }
      else {
        print("Пусто");
        return Left(Failure("ddddd"));
      }
    }
    catch (error) {
      return Left(Failure(error.toString()));
    }
  }

}