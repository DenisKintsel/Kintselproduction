import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class AddCargoUseCases extends UseCase<NoParams, AddCargo> {
  final Repository addCargoRepository;

  AddCargoUseCases({required this.addCargoRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddCargo params) async {
    return await addCargoRepository.addCargo(params.title, params.cargo, params.data,
        params.notes, params.departure, params.receipt);
  }
}

class AddCargo extends Equatable {
  final String title;
  final String cargo;
  final String data;
  final String notes;
  final String departure;
  final String receipt;

  const AddCargo(
      {required this.title,
        required this.cargo,
        required this.data,
        required this.notes,
        required this.departure,
        required this.receipt});

  @override
  List<Object?> get props => [];
}