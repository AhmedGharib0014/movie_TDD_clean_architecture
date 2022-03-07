import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:movie_app/core/use_cases/use_cases_params_use_case_contract.dart';

abstract class UseCasesContract<Type, Params> {
  Future<Either<Failure, Type>> call(Params? params);
}
