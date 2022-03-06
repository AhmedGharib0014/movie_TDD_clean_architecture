import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessaeg;
  Failure({required this.errorMessaeg});
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessaeg];
}

class ServerFailure extends Failure {
  ServerFailure(String msg) : super(errorMessaeg: msg);
}

class CacheFailure extends Failure {
  CacheFailure(String msg) : super(errorMessaeg: msg);
}
