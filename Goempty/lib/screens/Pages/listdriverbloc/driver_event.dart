part of 'driver_bloc.dart';


abstract class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object> get props => [];
}

class Init extends DriverEvent {
  final Map searchD ; 
  Init({this.searchD});
  
}