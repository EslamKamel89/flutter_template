import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedTextWidget extends StatelessWidget {
  final String text;
  final Duration letterAnimationDuration;
  final Duration recombineDuration;
  final TextStyle? textStyle;

  const AnimatedTextWidget({
    Key? key,
    required this.text,
    this.letterAnimationDuration = const Duration(milliseconds: 300),
    this.recombineDuration = const Duration(milliseconds: 500),
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: letterAnimationDuration * text.length + recombineDuration,
      builder: (context, progress, child) {
        final visibleCharacters = (progress * text.length).floor();
        final isRecombining = progress >= 1;

        if (isRecombining) {
          return Text(
            text,
            style: textStyle,
          );
        }

        // Build animated letters
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(text.length, (index) {
            if (index < visibleCharacters) {
              final animationProgress = (progress - index / text.length).clamp(0.0, 1.0);
              return Text(
                text[index],
                style: textStyle?.copyWith(
                      color: textStyle?.color?.withOpacity(animationProgress),
                    ) ??
                    TextStyle(color: Colors.black.withOpacity(animationProgress)),
              ).animate()
                  .fadeIn(duration: letterAnimationDuration)
                  .scale(
                    duration: letterAnimationDuration,
                    curve: Curves.easeInOutBack,
                  );
            }
            return const SizedBox();
          }),
        );
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Animated Text Example'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: AnimatedTextWidget(
            text: 'Flutter Rocks!',
            textStyle: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
