import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../../core_global/error/failure.dart';
import '../../entities/user_model.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class AutorizationUseCasesUser extends UseCase<userModel, AutorizationUser> {
  final Repository registrationsRepository;

  AutorizationUseCasesUser({required this.registrationsRepository});

  @override
  Future<Either<Failure, userModel>> call(AutorizationUser params) async {
    final Either<Failure,userModel> qwer = await registrationsRepository.autorizationUsers(
        params.email, params.password);
    return qwer.fold(
            (failure) => Left(failure),
            (response) async {
            print("успешно добавлено1");
             //var user = await Hive.openBox('user');
             // Hive.registerAdapter(registerAdapter());
            var users = await Hive.openBox<userModel>('user');
            Hive.box<userModel>('user');
            users.delete('user');
             users.put('user', response);
               print(users.get('user')?.email);
              print("успешно добавлено2");
            return Right(response);});
  }
}

class AutorizationUser extends Equatable {
  final String email;
  final String password;

  const AutorizationUser(
      {required this.email,
        required this.password});

  @override
  List<Object?> get props => [];
}