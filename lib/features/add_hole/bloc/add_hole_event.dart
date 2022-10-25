part of 'add_hole_bloc.dart';

abstract class AddHoleEvent extends Equatable {
  const AddHoleEvent();

  @override
  List<Object> get props => [];
}

class CourseChanged extends AddHoleEvent {
  const CourseChanged({required this.course});
  final String course;

  @override
  List<Object> get props => [course];
}

class DateChanged extends AddHoleEvent {
  const DateChanged({required this.date});
  final DateTime date;

  @override
  List<Object> get props => [date];
}

class NumberOfHolesChanged extends AddHoleEvent {
  const NumberOfHolesChanged({required this.numberOfHoles});
  final int numberOfHoles;

  @override
  List<Object> get props => [numberOfHoles];
}

class ScreenHeightChanged extends AddHoleEvent {
  const ScreenHeightChanged({required this.height});
  final double height;

  @override
  List<Object> get props => [height];
}

class Submit extends AddHoleEvent {
  const Submit();

  @override
  List<Object> get props => [];
}
