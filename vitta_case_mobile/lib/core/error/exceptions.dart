import 'package:vitta_case_mobile/core/error/failure.dart';

class ServerException implements Exception {}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}
