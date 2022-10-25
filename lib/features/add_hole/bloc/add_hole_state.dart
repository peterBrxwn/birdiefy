part of 'add_hole_bloc.dart';

class AddHoleState extends Equatable {
  const AddHoleState({
    required this.courses,
    this.date,
    this.course,
    required this.coursesDropdownParams,
    this.notifMsg,
    this.numberOfHoles,
    this.status = Status.initial,
  });
  final DateTime? date;
  final String? course;
  final List<String> courses;
  final DropdownParams coursesDropdownParams;
  final NotifMsg? notifMsg;
  final int? numberOfHoles;
  final Status status;

  AddHoleState copyWith({
    DateTime? date,
    String? course,
    List<String>? courses,
    DropdownParams? coursesDropdownParams,
    NotifMsg? notifMsg,
    int? numberOfHoles,
    Status? status,
  }) {
    return AddHoleState(
      date: date ?? this.date,
      course: course ?? this.course,
      courses: courses ?? this.courses,
      coursesDropdownParams:
          coursesDropdownParams ?? this.coursesDropdownParams,
      notifMsg: notifMsg,
      numberOfHoles: numberOfHoles ?? this.numberOfHoles,
      status: status ?? Status.initial,
    );
  }

  @override
  List<Object?> get props => [
        date,
        course,
        courses,
        coursesDropdownParams,
        notifMsg,
        numberOfHoles,
        status,
      ];
}

enum Status {
  initial,
  loading,
  submitError,
  submitSuccess,
}
