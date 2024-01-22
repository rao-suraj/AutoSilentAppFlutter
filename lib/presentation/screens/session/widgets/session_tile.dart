import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/presentation/screens/widgets/custom_switch_auto.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

class SessionTile extends StatefulWidget {
  final Session session;
  const SessionTile({super.key, required this.session});

  @override
  State<SessionTile> createState() => _SessionTileState();
}

class _SessionTileState extends State<SessionTile> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final values = List.filled(7, true);
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
            const EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.session.title,
                  style:
                      textTheme.h2Medium.copyWith(color: colorScheme.onPrimary),
                ),
                Text(
                  "Everyday",
                  style:
                      textTheme.h3Medium.copyWith(color: colorScheme.onPrimary),
                ),
                GestureDetector(
                  onTap: () {
                    // context
                    // .read<CalendarCubit>()
                    // .switchCalendar(calendar: widget.calendar);
                  },
                  child: CustomSwitchAuto(
                    value: widget.session.isActive,
                    width: 50,
                    height: 26,
                  ),
                ),
              ],
            ),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  style: textTheme.h2low.copyWith(color: colorScheme.onPrimary),
                  children: [
                    TextSpan(
                      text:
                          DateFormat("hh:mm").format(widget.session.startTime),
                    ),
                    TextSpan(
                        text: DateFormat("a").format(widget.session.startTime),
                        style: textTheme.h4),
                    TextSpan(text: "-", style: textTheme.h3),
                    TextSpan(
                      text: DateFormat("hh:mm").format(widget.session.endTime),
                    ),
                    TextSpan(
                        text: DateFormat("a").format(widget.session.endTime),
                        style: textTheme.h4),
                  ]),
            ),
            WeekdaySelector(
              onChanged: (int day) {
                setState(() {
                  // Use module % 7 as Sunday's index in the array is 0 and
                  // DateTime.sunday constant integer value is 7.
                  final index = day % 7;
                  // We "flip" the value in this example, but you may also
                  // perform validation, a DB write, an HTTP call or anything
                  // else before you actually flip the value,
                  // it's up to your app's needs.
                  values[index] = !values[index];
                });
                print(values);
              },
              values: values,
            ),
          ],
        ),
      ),
    );
  }
}
