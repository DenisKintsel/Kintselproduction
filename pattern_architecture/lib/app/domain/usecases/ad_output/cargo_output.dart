import 'package:dartz/dartz.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class CargoOutPutUseCasesUser extends UseCase<List, NoParams> {
  final Repository outputCargoRepository;

  CargoOutPutUseCasesUser({required this.outputCargoRepository});

  @override
  Future<Either<Failure, List>> call(NoParams params) async {
    final Either<Failure, List> output =
    await outputCargoRepository.outputCargo();
    return output.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }
}