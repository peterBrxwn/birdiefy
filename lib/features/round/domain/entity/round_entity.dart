// Package imports:
import 'package:equatable/equatable.dart';

class Round extends Equatable {
  final String course;
  final DateTime date;
  final DateTime dateAdded;
  final String? id;
  final int numberOfHoles;

  const Round({
    required this.course,
    required this.date,
    required this.dateAdded,
    required this.numberOfHoles,
    this.id,
  });

  Round copyWith({
    String? course,
    DateTime? date,
    DateTime? dateAdded,
    String? id,
    int? numberOfHoles,
  }) {
    return Round(
      course: course ?? this.course,
      date: date ?? this.date,
      dateAdded: dateAdded ?? this.dateAdded,
      id: id ?? this.id,
      numberOfHoles: numberOfHoles ?? this.numberOfHoles,
    );
  }

  @override
  List<Object?> get props => [
        course,
        date,
        dateAdded,
        id,
        numberOfHoles,
      ];
}
