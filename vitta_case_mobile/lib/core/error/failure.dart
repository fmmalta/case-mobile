import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFail extends Failure {
  @override
  List<Object> get props => <dynamic>[];
}
