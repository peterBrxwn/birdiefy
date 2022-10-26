part of 'add_round_bloc.dart';

class AddRoundState extends Equatable {
  const AddRoundState({
    required this.courses,
    required this.coursesDropdownParams,
    this.date,
    this.course,
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

  AddRoundState copyWith({
    DateTime? date,
    String? course,
    List<String>? courses,
    DropdownParams? coursesDropdownParams,
    NotifMsg? notifMsg,
    int? numberOfHoles,
    Status? status,
  }) {
    return AddRoundState(
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
