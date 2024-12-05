import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamer_tag/common/app_colors.dart';
import 'package:gamer_tag/features/chat/presentation/chat_screen.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBarColor,
        ),
        colorScheme: const ColorScheme.light(
          primaryContainer: AppColors.bubbleCurrentColor,
          secondaryContainer: AppColors.bubbleNextColor,
          tertiaryContainer: AppColors.bubbleTimerColor,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 17,
          ),
          labelSmall: TextStyle(
            fontSize: 11,
          ),
        ),
      ),
      home: const ChatScreen(),
    );
  }
}
