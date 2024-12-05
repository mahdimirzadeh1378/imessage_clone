import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamer_tag/common/extensions.dart';

class ChatTimerIcon extends ConsumerWidget {
  const ChatTimerIcon({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isOn = ref.watch(sendWithTimerProvider);
    return IconButton(
      onPressed: () {
        ref.read(sendWithTimerProvider.notifier).state = !isOn;
      },
      icon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isOn
              ? context.colors.tertiaryContainer.withOpacity(0.08)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.timer_outlined,
          color: isOn ? context.colors.tertiaryContainer : Colors.grey,
        ),
      ),
    );
  }
}

final sendWithTimerProvider = StateProvider<bool>((ref) {
  return false;
});
