import 'package:equatable/equatable.dart';

class NotifMsg extends Equatable {
  final String message;
  final NotificationType type;

  const NotifMsg({
    this.message = 'Something went wrong',
    this.type = NotificationType.error,
  });

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message, type];
}

class NotifInfo extends NotifMsg {
  const NotifInfo({required String message})
      : super(message: message, type: NotificationType.info);
}

class NotifSuccess extends NotifMsg {
  const NotifSuccess({required String message})
      : super(message: message, type: NotificationType.success);
}

enum NotificationType { error, info, success }
