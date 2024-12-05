import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gamer_tag/common/app_icons.dart';
import 'package:gamer_tag/common/extensions.dart';
import 'package:gamer_tag/features/chat/presentation/chat_screen_controller.dart';
import 'package:gamer_tag/features/chat/presentation/widgets/chat_timer_icon.dart';

const messageDuration = 60;

class ChatTextField extends ConsumerWidget {
  final TextEditingController textController;

  const ChatTextField({
    super.key,
    required this.textController,
  });

  @override
  Widget build(BuildContext context, ref) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          hintText: 'Message...',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 40,
            maxWidth: 40,
          ),
          suffixIcon: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                int? duration;
                if (ref.read(sendWithTimerProvider)) {
                  duration = messageDuration;
                }
                ref
                    .read(chatControllerProvider.notifier)
                    .sendMessage(textController.text, duration: duration);
                textController.clear();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.center,
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppIcons.sendIcon),
              ),
            ),
          )),
    );
  }
}
