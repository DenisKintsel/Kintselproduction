import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class RegistrationUseCasesUser extends UseCase<NoParams, RegistrUser> {
  final RegistrationsRepository registrationsRepository;

  RegistrationUseCasesUser({required this.registrationsRepository});

  @override
  Future<Either<Failure, NoParams>> call(RegistrUser params) async {
    return await registrationsRepository.registrationUsers(
        params.email, params.password,params.name,params.city);
  }
}

class RegistrUser extends Equatable {
  final String email;
  final String password;
  final String name;
  final String city;

  const RegistrUser(
      {required this.email,
      required this.password,
      required this.name,
      required this.city});

  @override
  List<Object?> get props => [];
}
