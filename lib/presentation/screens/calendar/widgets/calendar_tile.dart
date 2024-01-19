import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/presentation/screens/widgets/custom_switch_auto.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CalendarTile extends StatefulWidget {
  final Calendar calendar;
  const CalendarTile({super.key, required this.calendar});

  @override
  State<CalendarTile> createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            flex: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.calendar.title,
                style:
                    textTheme.h2Medium.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
          Expanded(
            flex: 17,
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                    style:
                        textTheme.h2low.copyWith(color: colorScheme.onPrimary),
                    children: [
                      TextSpan(
                          text: "6:40",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Tap");
                            }),
                      TextSpan(text: "AM", style: textTheme.h4),
                      TextSpan(text: "-", style: textTheme.h3),
                      TextSpan(
                          text: "6:40",
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      TextSpan(text: "AM", style: textTheme.h4),
                    ]),
              ),
            ),
          ),
          Expanded(
              flex: 20,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "21 Sep 2024",
                  style: textTheme.h3,
                ),
              )),
          Expanded(
              flex: 20,
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: CustomSwitchAuto(
                    value: widget.calendar.isActive,
                    width: 50,
                    height: 26,
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
