part of 'profile_au_bloc.dart';

abstract class ProfileAuState extends Equatable {
  const ProfileAuState();

  @override
  List<Object> get props => [];
}

class ProfileAuInitial extends ProfileAuState {
  final List userA;

  ProfileAuInitial({this.userA});
}

class ProfileAuLoading extends ProfileAuState {}

class ProfileAuFailure extends ProfileAuState {
 final String error;

  ProfileAuFailure({this.error});

}