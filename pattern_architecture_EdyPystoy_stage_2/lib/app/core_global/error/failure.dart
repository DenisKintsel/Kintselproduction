import 'package:equatable/equatable.dart';

 class Failure extends Equatable{
  final String errrorMessage;
 const Failure(this.errrorMessage);
  @override
  String toString(){
   return errrorMessage;
  }
  // TODO: implement props
  List<Object?> get props => [];
}
class ServerFailure extends Failure{
  ServerFailure(super.errrorMessage);
}