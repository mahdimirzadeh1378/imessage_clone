import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamer_tag/common/app_colors.dart';
import 'package:gamer_tag/common/extensions.dart';
import 'package:gamer_tag/features/chat/presentation/chat_screen_controller.dart';

class ChatAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final ChatScreenState state;
  const ChatAppbar({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.appBarTheme.backgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: AppColors.appBarBorderColor,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          ref.read(chatControllerProvider.notifier).switchUser();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundImage: Image.asset(state.nextUser.avatar).image,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.nextUser.name,
                  style: context.theme.textTheme.labelSmall,
                ),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 18,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
