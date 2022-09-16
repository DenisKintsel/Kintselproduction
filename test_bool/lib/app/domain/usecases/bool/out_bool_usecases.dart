import 'package:dartz/dartz.dart';
import '../../../core_global/error/failure.dart';
import '../../entities/list_bool_model.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class OutBoolUseCases extends UseCase<listBoolModel, NoParams> {
  final Repository outBoolRepository;

  OutBoolUseCases({required this.outBoolRepository});

  @override
  Future<Either<Failure, listBoolModel>> call(NoParams params) async {
    final Either<Failure, listBoolModel> output =
    await outBoolRepository.outBool();
    return output.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }
}