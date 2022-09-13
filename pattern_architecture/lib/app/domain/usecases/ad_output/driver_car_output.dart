import 'package:dartz/dartz.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class DriverCarOutPutUseCasesUser extends UseCase<List, NoParams> {
  final Repository outputDriverCarRepository;

  DriverCarOutPutUseCasesUser({required this.outputDriverCarRepository});

  @override
  Future<Either<Failure, List>> call(NoParams params) async {
    final Either<Failure, List> output =
        await outputDriverCarRepository.outputDriverCar();
    return output.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }
}
