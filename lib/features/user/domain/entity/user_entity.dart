// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:birdiefy/features/user/domain/entity/user_type.dart';

class User extends Equatable {
  final DateTime dateAdded;
  final String email;
  final String firstname;
  final String handicap;
  final String id;
  final String lastname;
  final UserType userType;

  const User({
    required this.dateAdded,
    required this.email,
    required this.firstname,
    required this.handicap,
    required this.id,
    required this.lastname,
    required this.userType,
  });

  User copyWith({
    DateTime? dateAdded,
    String? email,
    String? firstname,
    String? handicap,
    String? id,
    String? lastname,
    UserType? userType,
  }) {
    return User(
      dateAdded: dateAdded ?? this.dateAdded,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      handicap: handicap ?? this.handicap,
      id: id ?? this.id,
      lastname: lastname ?? this.lastname,
      userType: userType ?? this.userType,
    );
  }

  @override
  String toString() => firstname;

  @override
  List<Object?> get props => [
        dateAdded,
        email,
        firstname,
        handicap,
        id,
        lastname,
        userType,
      ];
}
