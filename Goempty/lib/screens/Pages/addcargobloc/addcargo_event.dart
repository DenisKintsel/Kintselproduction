part of 'addcargo_bloc.dart';


abstract class AddCargoEvent extends Equatable {
  const AddCargoEvent();
}

class AddCargoButtonPressed extends AddCargoEvent {
  final String city1;
  final String city2;
  final String cargo;
  final String price;
  final String phone;
  final String note;
  final String id;

  const AddCargoButtonPressed({@required this.city1, @required this.city2, @required this.cargo,@required this.price,@required this.phone,@required this.note,@required this.id});

  @override
  List<Object> get props => [city1, city2,cargo,price,phone,note,id];

  @override
  String toString() => 'LoginButtonPressed { email: $city1, password: $city2 }';
}