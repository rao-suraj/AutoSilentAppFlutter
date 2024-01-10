import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LevelIndicator extends StatelessWidget {
  final int level;
  const LevelIndicator({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 6,
      width: 57,
      child: Row(children: [
        Expanded(
          flex: 25,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: level >= 1 ? colorScheme.onPrimary : colorScheme.surface,
                border:level >= 1 ? null : Border.all(width: 2, color: colorScheme.onPrimary)),
          ),
        ),
        const Gap(2),
        Expanded(
          flex: 25,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: level >= 2 ? colorScheme.onPrimary : colorScheme.surface,
                border:level >= 2 ? null: Border.all(width: 2, color: colorScheme.onPrimary)),
          ),
        ),
        const Gap(2),
        Expanded(
          flex: 25,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: level >= 3 ? colorScheme.onPrimary : colorScheme.surface,
                border: level >= 3 ? null : Border.all(width: 2, color: colorScheme.onPrimary)),
          ),
        ),
      ]),
    );
  }
}
