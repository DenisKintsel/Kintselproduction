part of 'my_prof_ad_bloc.dart';

abstract class MyProfAdState extends Equatable {
  const MyProfAdState();

  @override
  List<Object> get props => [];
}

class MyProfAdInitial extends MyProfAdState {
  final List prof;

  MyProfAdInitial({this.prof});
}

class MyProfAdLoading extends MyProfAdState {}

class MyProfAdFailure extends MyProfAdState {
 final String error;

  MyProfAdFailure({this.error});

}