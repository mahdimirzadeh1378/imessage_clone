import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamer_tag/features/chat/presentation/widgets/chat_appbar.dart';
import 'package:gamer_tag/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:gamer_tag/features/chat/presentation/chat_screen_controller.dart';
import 'package:gamer_tag/features/chat/presentation/widgets/chat_text_field.dart';
import 'package:gamer_tag/features/chat/presentation/widgets/chat_timer_icon.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatControllerProvider);
    return Scaffold(
      appBar: ChatAppbar(state: state),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: state.listKey,
              itemBuilder: (context, index, animation) {
                return ChatBubble(
                  tail: ref
                      .read(chatControllerProvider.notifier)
                      .isNextMessageMine(index),
                  animation: animation,
                  message: state.messages[index],
                  onDelete: () {
                    ref
                        .read(chatControllerProvider.notifier)
                        .deleteMessage(state.messages[index].id);
                  },
                  isSender:
                      state.messages[index].sender.id == state.currentUser.id,
                );
              },
              initialItemCount: state.messages.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const ChatTimerIcon(),
                Expanded(
                  child: ChatTextField(textController: textController),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
