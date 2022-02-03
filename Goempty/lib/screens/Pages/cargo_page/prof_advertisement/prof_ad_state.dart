part of 'prof_ad_bloc.dart';

abstract class ProfAdState extends Equatable {
  const ProfAdState();

  @override
  List<Object> get props => [];
}

class ProfAdInitial extends ProfAdState {
  final List prof;

  ProfAdInitial({this.prof});
}

class ProfAdLoading extends ProfAdState {}

class ProfAdFailure extends ProfAdState {
 final String error;

  ProfAdFailure({this.error});

}