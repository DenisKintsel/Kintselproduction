import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class AddAdUseCases extends UseCase<NoParams, AddAd> {
  final Repository addAdRepository;

  AddAdUseCases({required this.addAdRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddAd params) async {
    return await addAdRepository.addAd(params.title, params.car, params.data,
        params.notes, params.departure, params.receipt);
  }
}

class AddAd extends Equatable {
  final String title;
  final String car;
  final String data;
  final String notes;
  final String departure;
  final String receipt;

  const AddAd(
      {required this.title,
      required this.car,
      required this.data,
      required this.notes,
      required this.departure,
      required this.receipt});

  @override
  List<Object?> get props => [];
}
