import 'package:auto_silent_app/presentation/themes/theme_extensions.dart';
import 'package:auto_silent_app/presentation/utils/app_icons.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatefulWidget {
  const ProfileTile({super.key});

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: colorScheme.surface, borderRadius: BorderRadius.circular(30)),
      child: Column(children: [
        Text("Title", style: theme.h2),
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(AppIcons.book),
            Container(),
          ],
        )
      ]),
    );
  }
}
