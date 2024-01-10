import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/gen/assets.gen.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/presentation/screens/widgets/level_indicator_widget.dart';
import 'package:auto_silent_app/presentation/themes/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileTile extends StatefulWidget {
  final Profile profile;
  const ProfileTile({super.key, required this.profile});

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
          color: colorScheme.surface, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10,right: 10, top: 15, bottom: 10),
        child: Column(children: [
          Expanded(
            flex: 36,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.profile.title,
                style: theme.h1Medium.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
          Expanded(
            flex: 17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.volumeIcon.svg(
                    height: 25,
                    colorFilter: ColorFilter.mode(
                        colorScheme.onPrimary, BlendMode.srcIn)),
                const Gap(5),
                LevelIndicator(
                    level: widget.profile.volumeLevel ??
                        2), // this will display the volume level based on the value provided 1-3
              ],
            ),
          ),
          Expanded(
            flex: 17,
            child: Row(
              children: [
                Assets.images.ringerIcon.svg(
                    height: 22,
                    colorFilter: ColorFilter.mode(
                        colorScheme.onPrimary, BlendMode.srcIn)),
                const Gap(5),
                LevelIndicator(level: widget.profile.ringerLevel ?? 2),
              ],
            ),
          ),
          Expanded(
            flex: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Assets.images.dndIcon.svg(
                    height: 26,
                    colorFilter: ColorFilter.mode(
                        (widget.profile.isDNDActive ?? false)
                            ? colorScheme.primary
                            : colorScheme.onPrimary,
                        BlendMode.srcIn)),
                GestureDetector(
                  onTap: () {
                    context
                        .read<ProfileCubit>()
                        .switchIsActive(profile: widget.profile);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 4, color: colorScheme.onPrimary),
                        color: widget.profile.isActive
                            ? colorScheme.primary
                            : colorScheme.surface),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
