import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core_global/error/failure.dart';
import '../../repositories/repository.dart';
import '../NoParams/usecase.dart';

class AddBoolUseCases extends UseCase<NoParams, AddBool> {
  final Repository addBoolRepository;

  AddBoolUseCases({required this.addBoolRepository});

  @override
  Future<Either<Failure, NoParams>> call(AddBool params) async {
    return await addBoolRepository.addBool(
        params.id,
        params.switchQ,
        params.radio,
        params.check,
        params.id2,
        params.switchQ2,
        params.radio2,
        params.check2,
        params.id3,
        params.switchQ3,
        params.radio3,
        params.check3);
  }
}

class AddBool extends Equatable {
  final int id;
  final int switchQ;
  final int radio;
  final int check;
  final int id2;
  final int switchQ2;
  final int radio2;
  final int check2;
  final int id3;
  final int switchQ3;
  final int radio3;
  final int check3;

  const AddBool({
    required this.id,
    required this.switchQ,
    required this.radio,
    required this.check,
    required this.id2,
    required this.switchQ2,
    required this.radio2,
    required this.check2,
    required this.id3,
    required this.switchQ3,
    required this.radio3,
    required this.check3,
  });

  @override
  List<Object?> get props => [];
}