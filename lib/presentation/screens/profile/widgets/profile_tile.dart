import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/gen/assets.gen.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/presentation/screens/widgets/custom_switch_auto.dart';
import 'package:auto_silent_app/presentation/screens/profile/widgets/level_indicator_widget.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
  Offset? tapXY;
  RenderBox? overlay;
  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final theme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTapDown: (position) {
        getPosition(position);
      },
      onLongPress: () async {
        await showMenu(
          context: context,
          position: relRectSize ,
          items: [
            PopupMenuItem(
              child: Text(
                "Delete",
                style: theme.h3,
              ),
              onTap: () {
                context
                    .read<ProfileCubit>()
                    .deleteProfile(profile: widget.profile);
              },
            )
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: colorScheme.background,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
          child: Column(children: [
            Expanded(
              flex: 36,
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  widget.profile.title,
                  style: theme.h1Medium.copyWith(color: colorScheme.onPrimary),
                  minFontSize: theme.h2.fontSize!,
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
                      height: 27,
                      colorFilter: ColorFilter.mode(
                          colorScheme.onPrimary, BlendMode.srcIn)),
                  const Gap(5),
                  LevelIndicator(
                      level: getLevel(widget.profile
                          .volumeLevel)), // this will display the volume level based on the value provided 1-3
                ],
              ),
            ),
            Expanded(
              flex: 17,
              child: Row(
                children: [
                  Assets.images.ringerIcon.svg(
                      height: 26,
                      colorFilter: ColorFilter.mode(
                          colorScheme.onPrimary, BlendMode.srcIn)),
                  const Gap(5),
                  LevelIndicator(level: getLevel(widget.profile.ringerLevel)),
                ],
              ),
            ),
            Expanded(
              flex: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Assets.images.dndIcon.svg(
                        height: 32,
                        colorFilter: ColorFilter.mode(
                            (widget.profile.isDNDActive)
                                ? colorScheme.primary
                                : colorScheme.onPrimary,
                            BlendMode.srcIn),
                      ),
                      const Gap(5),
                      Assets.images.vibrationIcon.svg(
                        height: 32,
                        colorFilter: ColorFilter.mode(
                            (widget.profile.isVibrationActive)
                                ? colorScheme.primary
                                : colorScheme.onPrimary,
                            BlendMode.srcIn),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ProfileCubit>()
                          .switchIsActive(profile: widget.profile);
                    },
                    child: CustomSwitchAuto(
                      value: widget.profile.isActive,
                      width: 57,
                      height: 29,
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  // takes level in double(0.0 to 1.0) and converts it to int(1 to 3)
  int getLevel(double x) {
    if (x == 0) {
      return 0;
    } else if (x > 0 && x <= 0.4) {
      return 1;
    } else if (x > 0.4 && x <= 0.7) {
      return 2;
    } else {
      return 3;
    }
  }

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  RelativeRect get relRectSize => RelativeRect.fromSize(tapXY! & const Size(40,40), overlay!.size);
}
