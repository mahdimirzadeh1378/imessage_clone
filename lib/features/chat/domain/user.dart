import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String avatar;
  final int id;

  const User({required this.name, required this.avatar, required this.id});

  @override
  List<Object?> get props => [name, avatar, id];
}
