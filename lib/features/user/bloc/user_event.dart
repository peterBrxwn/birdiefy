part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class Init extends UserEvent {
  const Init();

  @override
  List<Object> get props => [];
}

class Logout extends UserEvent {
  const Logout();

  @override
  List<Object> get props => [];
}
