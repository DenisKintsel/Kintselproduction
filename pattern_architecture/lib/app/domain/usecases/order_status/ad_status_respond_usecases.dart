import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class AdStatusRespondUseCases extends UseCase<NoParams, AdStatusRespond> {
  final Repository adStatusRespondRepository;

  AdStatusRespondUseCases({required this.adStatusRespondRepository});

  @override
  Future<Either<Failure, NoParams>> call(AdStatusRespond params) async {
    return await adStatusRespondRepository.adStatusRespond(params.idAd, params.idUserClient, params.statusOrder);
  }
}

class AdStatusRespond extends Equatable {
  final int idAd;
  final int idUserClient;
  final int statusOrder;

  const AdStatusRespond(
      {required this.idAd,required this.idUserClient,required this.statusOrder});

  @override
  List<Object?> get props => [];
}