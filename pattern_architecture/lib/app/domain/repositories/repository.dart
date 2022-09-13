import 'package:dartz/dartz.dart';
import '../../core_global/error/failure.dart';
import '../entities/user_model.dart';
import '../usecases/NoParams/usecase.dart';

abstract class Repository {
  Future<Either<Failure, NoParams>> registrationUsers(
      String email, String password, String name, String city);

  Future<Either<Failure, userModel>> autorizationUsers(
      String email, String password);

  Future<Either<Failure, NoParams>> addAd(String title, String car, String data,
      String notes, String departure, String receipt);

  Future<Either<Failure, List>> outputDriverCar();

  Future<Either<Failure, List>> outputCargo();

  Future<Either<Failure, NoParams>> addCargo(String title, String cargo, String data,
      String notes, String departure, String receipt);

  Future<Either<Failure, List>> adCardOutput(int id);

  Future<Either<Failure, NoParams>> adStatusRespond(int idAd,int idUserClient,int statusOrder);
}
