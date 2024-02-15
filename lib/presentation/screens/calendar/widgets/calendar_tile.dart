import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/screens/widgets/custom_switch_auto.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarTile extends StatefulWidget {
  final Calendar calendar;
  const CalendarTile({super.key, required this.calendar});

  @override
  State<CalendarTile> createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  Offset? tapXY;
  RenderBox? overlay;
  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTapDown: (position) {
        getPosition(position);
      },
      onLongPress: () async {
        await showMenu(
          context: context,
          position: relRectSize,
          items: [
            PopupMenuItem(
              child: Text(
                "Delete",
                style: textTheme.h3,
              ),
              onTap: () {
                context
                    .read<CalendarCubit>()
                    .deleteCalendar(calendar: widget.calendar);
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
              )
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 30,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      widget.calendar.title,
                      style: textTheme.h1Medium
                          .copyWith(color: colorScheme.onPrimary),
                      minFontSize: textTheme.h2.fontSize!,
                    ),
                  ),
                ),
                Expanded(
                  flex: 17,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  style: textTheme.h2
                                      .copyWith(color: colorScheme.onPrimary),
                                  children: [
                                    TextSpan(
                                      text: DateFormat("h:mm")
                                          .format(widget.calendar.startTime),
                                    ),
                                    TextSpan(
                                        text: DateFormat("a")
                                            .format(widget.calendar.startTime),
                                        style: textTheme.h4),
                                    TextSpan(text: "-", style: textTheme.h3),
                                    TextSpan(
                                      text: DateFormat("h:mm")
                                          .format(widget.calendar.endTime),
                                    ),
                                    TextSpan(
                                        text: DateFormat("a")
                                            .format(widget.calendar.endTime),
                                        style: textTheme.h4),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 2, child: Container()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            child: AutoSizeText(
                              DateFormat('dd MMM yyyy')
                                  .format(widget.calendar.dateTime),
                              style: textTheme.h2low
                                  .copyWith(color: colorScheme.onPrimary),
                              minFontSize: textTheme.h3.fontSize!,
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 3, child: Container()),
                    ],
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<CalendarCubit>()
                            .switchCalendar(calendar: widget.calendar);
                      },
                      child: CustomSwitchAuto(
                        value: widget.calendar.isActive,
                        width: 50,
                        height: 26,
                      ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  RelativeRect get relRectSize =>
      RelativeRect.fromSize(tapXY! & const Size(40, 40), overlay!.size);
}
