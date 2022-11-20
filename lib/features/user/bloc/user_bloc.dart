// Package imports:
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:birdiefy/core/typedef.dart';
import 'package:birdiefy/features/notifications/services/models/notif_msg.dart';
import 'package:birdiefy/features/user/domain/entity/user_entity.dart';
import 'package:birdiefy/features/user/domain/repo.dart';
import 'package:birdiefy/features/user/services/models/user_model.dart';
import 'package:birdiefy/injection.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepo userRepo})
      : _userRepo = userRepo,
        super(const UserState()) {
    on<Init>(_init);
    on<Logout>(_logout);
  }
  final _auth = locator<FirebaseAuth>();
  final UserRepo _userRepo;

  Future<void> _init(Init event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach<ErrorOrType<UserModel?>>(
      _userRepo.stream(id: _auth.currentUser!.uid),
      onData: (stream) => stream.fold(
        (l) => state.copyWith(
          status: Status.error,
          notifMsg: const NotifMsg(message: 'Something went wrong.'),
        ),
        (r) => state.copyWith(user: r, status: Status.success),
      ),
      onError: (error, stackTrace) => state.copyWith(status: Status.error),
    );
  }

  void _logout(Logout event, Emitter<UserState> emit) {
    _auth.signOut();
  }
}
