part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.notifMsg,
    this.status = Status.initial,
    this.user,
  });
  final NotifMsg? notifMsg;
  final User? user;
  final Status status;

  UserState copyWith({NotifMsg? notifMsg, User? user, Status? status}) {
    return UserState(
      notifMsg: notifMsg ?? this.notifMsg,
      status: status ?? Status.initial,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [notifMsg, status, user];
}

enum Status { error, initial, loading, success }
