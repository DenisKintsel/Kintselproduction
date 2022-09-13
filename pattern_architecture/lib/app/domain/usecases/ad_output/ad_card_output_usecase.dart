import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class AdCardUseCasesUser extends UseCase<List, AdCardId> {
  final Repository adCardOutputRepository;

  AdCardUseCasesUser({required this.adCardOutputRepository});

  @override
  Future<Either<Failure, List>> call(AdCardId params) async {
    final Either<Failure, List> output =
        await adCardOutputRepository.adCardOutput(params.id);
    return output.fold((failure) => Left(failure), (response) async {
      return Right(response);
    });
  }
}

class AdCardId extends Equatable {
  final int id;

  const AdCardId({required this.id});

  @override
  List<Object?> get props => [];
}
