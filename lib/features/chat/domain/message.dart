import 'package:equatable/equatable.dart';

import 'package:gamer_tag/features/chat/domain/user.dart';

class Message extends Equatable {
  final int id;
  final String text;
  final User sender;
  final int? durationInSecond;

  const Message({
    required this.id,
    required this.text,
    required this.sender,
    this.durationInSecond,
  });

  @override
  List<Object?> get props => [id, text, sender, durationInSecond];

  Message copyWith({
    int? id,
    String? text,
    User? sender,
    int? durationInSecond,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      durationInSecond: durationInSecond ?? this.durationInSecond,
    );
  }
}
