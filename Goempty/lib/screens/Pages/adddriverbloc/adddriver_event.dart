part of 'adddriver_bloc.dart';


abstract class AddDriverEvent extends Equatable {
  const AddDriverEvent();
}

class AddDriverButtonPressed extends AddDriverEvent {
  final String city1;
  final String city2;
  final String car;
  final String price;
  final String phone;
  final String note;
  final String data;
  final String id;

  const AddDriverButtonPressed({@required this.city1, @required this.city2, @required this.car,@required this.price,@required this.phone,@required this.note,@required this.data,@required this.id});

  @override
  List<Object> get props => [city1, city2,car,price,phone,note,data,id];

  @override
  String toString() => 'DriverButtonPressed { email: $city1, password: $city2 }';
}