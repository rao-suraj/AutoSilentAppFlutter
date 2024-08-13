import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;
  const BorderedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
      ),
      child: child,
    );
  }
}
