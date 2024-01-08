import 'package:auto_silent_app/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  const ProfileTile({super.key});

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    final colorScheme= Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(color: colorScheme.surface,borderRadius: BorderRadius.circular(30)),
      child: Column(children: []),
    );
  }
}
