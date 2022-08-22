import 'package:dartz/dartz.dart';
import '../../core_global/error/failure.dart';
import '../entities/user_model.dart';
import '../usecases/NoParams/usecase.dart';

abstract class RegistrationsRepository {
  Future<Either<Failure, NoParams>> registrationUsers(
      String email, String password, String name, String city);
  Future<Either<Failure, userModel>> autorizationUsers(
      String email, String password);
}

