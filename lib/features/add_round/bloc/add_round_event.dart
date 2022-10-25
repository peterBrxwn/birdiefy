part of 'add_round_bloc.dart';

abstract class AddRoundEvent extends Equatable {
  const AddRoundEvent();

  @override
  List<Object> get props => [];
}

class CourseChanged extends AddRoundEvent {
  const CourseChanged({required this.course});
  final String course;

  @override
  List<Object> get props => [course];
}

class DateChanged extends AddRoundEvent {
  const DateChanged({required this.date});
  final DateTime date;

  @override
  List<Object> get props => [date];
}

class NumberOfHolesChanged extends AddRoundEvent {
  const NumberOfHolesChanged({required this.numberOfHoles});
  final int numberOfHoles;

  @override
  List<Object> get props => [numberOfHoles];
}

class ScreenHeightChanged extends AddRoundEvent {
  const ScreenHeightChanged({required this.height});
  final double height;

  @override
  List<Object> get props => [height];
}

class Submit extends AddRoundEvent {
  const Submit();

  @override
  List<Object> get props => [];
}
