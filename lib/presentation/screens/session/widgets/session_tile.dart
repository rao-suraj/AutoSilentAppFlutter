import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/screens/widgets/custom_switch_auto.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

class SessionTile extends StatefulWidget {
  final Session session;
  const SessionTile({super.key, required this.session});

  @override
  State<SessionTile> createState() => _SessionTileState();
}

class _SessionTileState extends State<SessionTile> {
  late List<bool> daysOfWeek;

  @override
  void initState() {
    daysOfWeek = [
      widget.session.sunday,
      widget.session.monday,
      widget.session.tuesday,
      widget.session.wednesday,
      widget.session.thursday,
      widget.session.friday,
      widget.session.saturday,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ]),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      widget.session.title,
                      style: textTheme.h1Medium
                          .copyWith(color: colorScheme.onSecondary),
                    ),
                    const Gap(15),
                    Text(
                      "Everyday",
                      style: textTheme.h2low
                          .copyWith(color: colorScheme.onSecondary),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    context
                        .read<SessionCubit>()
                        .switchIsActive(session: widget.session);
                  },
                  child: CustomSwitchAuto(
                    value: widget.session.isActive,
                    width: 66,
                    height: 32,
                  ),
                ),
              ],
            ),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  style:
                      textTheme.h1Medium.copyWith(color: colorScheme.onPrimary),
                  children: [
                    TextSpan(
                      text:
                          DateFormat("hh:mm").format(widget.session.startTime),
                    ),
                    TextSpan(
                        text: DateFormat(" a").format(widget.session.startTime),
                        style: textTheme.h3),
                    TextSpan(text: " - ", style: textTheme.h2),
                    TextSpan(
                      text: DateFormat("hh:mm").format(widget.session.endTime),
                    ),
                    TextSpan(
                        text: DateFormat(" a").format(widget.session.endTime),
                        style: textTheme.h3),
                  ]),
            ),
            const Gap(5),
            SizedBox(
              height: 25,
              width: 230,
              child: WeekdaySelector(
                selectedColor: colorScheme.surface,
                selectedFillColor: colorScheme.onPrimary,
                disabledColor: colorScheme.surface,
                disabledFillColor: colorScheme.onPrimary,
                selectedSplashColor: Colors.grey.withOpacity(0.2),
                selectedTextStyle:
                    TextStyle(fontSize: 14, color: colorScheme.surface),
                disabledTextStyle:
                    TextStyle(fontSize: 14, color: colorScheme.onPrimary),
                onChanged: (int day) {
                  // only for viewing purposes
                },
                values: daysOfWeek,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
