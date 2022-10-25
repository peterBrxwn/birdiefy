import 'package:birdiefy/core/domain/entity/dropdown_params.dart';
import 'package:birdiefy/features/notifications/services/models/notif_msg.dart';
import 'package:birdiefy/features/round/domain/entity/round_entity.dart';
import 'package:birdiefy/features/round/domain/repo.dart';
import 'package:birdiefy/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_hole_event.dart';
part 'add_hole_state.dart';

class AddHoleBloc extends Bloc<AddHoleEvent, AddHoleState> {
  AddHoleBloc({required RoundRepo roundRepo})
      : _roundRepo = roundRepo,
        super(_initState()) {
    on<CourseChanged>(_courseChanged);
    on<DateChanged>(_dateChanged);
    on<NumberOfHolesChanged>(_numberOfHolesChanged);
    on<ScreenHeightChanged>(_screenHeightChanged);
    on<Submit>(_submit);
  }
  static final _auth = locator<FirebaseAuth>();
  static final _localData = locator<SharedPreferences>();
  final RoundRepo _roundRepo;

  void _courseChanged(CourseChanged event, Emitter<AddHoleState> emit) {
    emit(state.copyWith(course: event.course));
  }

  void _dateChanged(DateChanged event, Emitter<AddHoleState> emit) {
    emit(state.copyWith(date: event.date));
  }

  static AddHoleState _initState() {
    final courses = _localData.getStringList('courses') ?? [];
    final coursesDropdownParams = DropdownParams(
      itemCount: courses.length,
      screenHeight: 0,
    );
    return AddHoleState(
      courses: courses,
      coursesDropdownParams: coursesDropdownParams,
    );
  }

  void _numberOfHolesChanged(
    NumberOfHolesChanged event,
    Emitter<AddHoleState> emit,
  ) {
    emit(state.copyWith(numberOfHoles: event.numberOfHoles));
  }

  void _screenHeightChanged(
    ScreenHeightChanged event,
    Emitter<AddHoleState> emit,
  ) {
    emit(
      state.copyWith(
        coursesDropdownParams: state.coursesDropdownParams.copyWith(
          screenHeight: event.height,
        ),
      ),
    );
  }

  void _submit(Submit event, Emitter<AddHoleState> emit) {
    emit(state.copyWith(status: Status.loading));
    try {
      if (state.date == null) {
        throw 'Please select date of round';
      }

      final round = Round(
        course: state.course!,
        date: state.date!,
        dateAdded: DateTime.now(),
        numberOfHoles: state.numberOfHoles!,
      );
      final userId = _auth.currentUser!.uid;
      final result = _roundRepo.add(round: round, userId: userId);
      result.fold(
        (l) => throw l.message,
        (r) => emit(state.copyWith(status: Status.submitSuccess)),
      );
    } catch (e) {
      return emit(
        state.copyWith(
          notifMsg: NotifMsg(
            message: e is String && e.isNotEmpty ? e : 'Something went wrong',
          ),
          status: Status.submitError,
        ),
      );
    }
  }
}
