import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamer_tag/features/chat/presentation/widgets/chat_bubble.dart';

import 'package:gamer_tag/features/chat/domain/message.dart';
import 'package:gamer_tag/features/chat/domain/user.dart';

class ChatScreenController extends Notifier<ChatScreenState> {
  @override
  ChatScreenState build() {
    const user1 = User(name: 'A', avatar: 'assets/images/avatar1.jpg', id: 1);
    const user2 = User(name: 'B', avatar: 'assets/images/avatar2.jpg', id: 2);
    return ChatScreenState(
      users: [user1, user2],
      currentUserIndex: 0,
      itemIdCounter: 1,
      messages: [],
      timers: {},
      listKey: GlobalKey<AnimatedListState>(),
    );
  }

  void sendMessage(String text, {int? duration}) {
    final messages = state.messages;
    final id = state.itemIdCounter;
    messages.add(
      Message(
          id: id,
          text: text,
          sender: state.currentUser,
          durationInSecond: duration),
    );
    if (duration != null) {
      final timers = state.timers;
      timers[id] = Timer.periodic(const Duration(seconds: 1), (timer) {
        final item = state.messages.firstWhere((item) => item.id == id);
        if (item.durationInSecond! > 1) {
          final newItem =
              item.copyWith(durationInSecond: item.durationInSecond! - 1);
          final messages = state.messages;
          messages[messages.indexOf(item)] = newItem;
          state = state.copyWith(messages: messages);
        } else {
          timer.cancel();
          deleteMessage(
            id,
            builder: (context, animation) {
              return ChatBubble(
                animation: animation,
                message: item,
                isSender: item.sender.id == state.currentUser.id,
              );
            },
          );
        }
      });
    }
    state = state.copyWith(
      messages: messages,
      itemIdCounter: state.itemIdCounter + 1,
    );
    state.listKey.currentState?.insertItem(messages.length - 1);
  }

  void switchUser() {
    state = state.copyWith(
      currentUserIndex: state.nextIndex,
    );
  }

  void deleteMessage(
    int id, {
    Widget Function(BuildContext, Animation<double>)? builder,
  }) async {
    state.listKey.currentState?.removeItem(
      state.messages.indexOf(state.messages.firstWhere(
        (element) => element.id == id,
      )),
      builder ??
          (context, animation) {
            return Container();
          },
    );
    final messages = state.messages;
    messages.removeWhere((item) => item.id == id);
    state = state.copyWith(messages: messages);
  }

  bool isNextMessageMine(int index) {
    final messages = state.messages;
    if (index + 1 == messages.length) return true;
    if (messages[index + 1].sender.id == messages[index].sender.id) {
      return false;
    }
    return true;
  }
}

class ChatScreenState {
  final List<User> users;
  final int currentUserIndex;
  final List<Message> messages;
  final int itemIdCounter;
  final Map<int, Timer> timers;
  final GlobalKey<AnimatedListState> listKey;

  ChatScreenState({
    required this.users,
    required this.currentUserIndex,
    required this.messages,
    required this.itemIdCounter,
    required this.timers,
    required this.listKey,
  });

  User get currentUser => users[currentUserIndex];
  User get nextUser => users[nextIndex];
  int get nextIndex =>
      currentUserIndex + 1 == users.length ? 0 : currentUserIndex + 1;

  ChatScreenState copyWith({
    List<User>? users,
    User? user2,
    int? currentUserIndex,
    int? itemIdCounter,
    Map<int, Timer>? timers,
    List<Message>? messages,
  }) {
    return ChatScreenState(
      users: users ?? this.users,
      currentUserIndex: currentUserIndex ?? this.currentUserIndex,
      itemIdCounter: itemIdCounter ?? this.itemIdCounter,
      messages: messages ?? this.messages,
      timers: timers ?? this.timers,
      listKey: listKey,
    );
  }
}

final chatControllerProvider =
    NotifierProvider<ChatScreenController, ChatScreenState>(
        ChatScreenController.new);
