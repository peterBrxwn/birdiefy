part of 'round_bloc.dart';

class RoundState extends Equatable {
  const RoundState({
    this.error,
    this.rounds = const [],
    this.status = Status.initial,
  });
  final AppError? error;
  final List<Round> rounds;
  final Status status;

  RoundState copyWith({
    AppError? error,
    List<Round>? rounds,
    Status? status,
  }) {
    return RoundState(
      error: error ?? this.error,
      rounds: rounds ?? this.rounds,
      status: status ?? Status.initial,
    );
  }

  @override
  List<Object?> get props => [error, rounds, status];
}

enum Status { error, initial, loading, success }
