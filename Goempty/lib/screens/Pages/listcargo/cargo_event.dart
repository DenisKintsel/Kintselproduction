part of 'cargo_bloc.dart';

abstract class CargoEvent extends Equatable {
  const CargoEvent();

  @override
  List<Object> get props => [];
}

class Init extends CargoEvent {
  final Map searchG ; 
  Init({this.searchG});
  
}