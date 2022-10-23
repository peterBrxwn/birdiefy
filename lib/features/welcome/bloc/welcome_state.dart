part of 'welcome_bloc.dart';

class WelcomeState extends Equatable {
  const WelcomeState({
    this.error,
    this.nextRoute = LoginPage.routeName,
    this.status = Status.initial,
    this.user,
  });
  final AppError? error;
  final String nextRoute;
  final Status status;
  final User? user;

  WelcomeState copyWith({
    AppError? error,
    String? nextRoute,
    Status? status,
    User? user,
  }) {
    return WelcomeState(
      error: error,
      nextRoute: nextRoute ?? this.nextRoute,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        error,
        nextRoute,
        status,
        user,
      ];
}

enum Status { initial, loadComplete }
