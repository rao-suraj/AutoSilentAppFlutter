import 'package:auto_silent_app/gen/fonts.gen.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final AnimationController _animationController;
  final Animation _animation;
  const MyFloatingActionButton(this._animationController, this._animation,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingActionBubble(
      items: [
        Bubble(
          title: "Add Settings",
          iconColor: colorScheme.onPrimary,
          bubbleColor: colorScheme.surface,
          icon: Icons.add,
          titleStyle: TextStyle(
              fontSize: 18,
              color: colorScheme.onPrimary,
              fontFamily: FontFamily.rubik,
              fontWeight: FontWeight.w600),
          onPress: () {},
        ),
        Bubble(
          title: "Add Profile",
          iconColor: colorScheme.onPrimary,
          bubbleColor: colorScheme.surface,
          icon: Icons.add,
          titleStyle: TextStyle(
              fontSize: 18,
              color: colorScheme.onPrimary,
              fontFamily: FontFamily.rubik,
              fontWeight: FontWeight.w600),
          onPress: () {},
        ),
        Bubble(
          title: "Add Schedule",
          iconColor: colorScheme.onPrimary,
          bubbleColor: colorScheme.surface,
          icon: Icons.add,
          titleStyle: TextStyle(
              fontSize: 18,
              color: colorScheme.onPrimary,
              fontFamily: FontFamily.rubik,
              fontWeight: FontWeight.w600),
          onPress: () {},
        )
      ],
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),
      iconColor: const Color(0xFF303030),
      animation: _animation,
      backGroundColor: colorScheme.primary,
      iconData: Icons.add,
    );
  }
}
