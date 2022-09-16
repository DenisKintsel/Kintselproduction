import 'package:dartz/dartz.dart';
import '../../core_global/error/failure.dart';
import '../entities/list_bool_model.dart';
import '../usecases/NoParams/usecase.dart';

abstract class Repository {
  Future<Either<Failure, listBoolModel>> outBool();

  Future<Either<Failure, NoParams>> addBool(
      int id,
      int switchQ,
      int radio,
      int check,
      int id2,
      int switchQ2,
      int radio2,
      int check2,
      int id3,
      int switchQ3,
      int radio3,
      int check3);
}
