import 'package:birdiefy/core/domain/entity/app_error.dart';
import 'package:birdiefy/core/domain/typedef.dart';
import 'package:birdiefy/features/round/domain/entity/round_entity.dart';
import 'package:birdiefy/features/round/domain/repo.dart';
import 'package:birdiefy/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'round_event.dart';
part 'round_state.dart';

class RoundBloc extends Bloc<RoundEvent, RoundState> {
  RoundBloc({required RoundRepo roundRepo})
      : _roundRepo = roundRepo,
        super(const RoundState()) {
    on<Init>(_init);
  }
  final _auth = locator<FirebaseAuth>();
  final RoundRepo _roundRepo;

  Future<void> _init(Init event, Emitter<RoundState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final userId = _auth.currentUser!.uid;
    await emit.forEach<ErrorOrType<List<Round>>>(
      _roundRepo.stream(userId: userId),
      onData: (stream) => stream.fold(
        (l) => state.copyWith(status: Status.error, error: l),
        (r) => state.copyWith(rounds: r, status: Status.success),
      ),
      onError: (error, stackTrace) => state.copyWith(status: Status.error),
    );
  }
}
