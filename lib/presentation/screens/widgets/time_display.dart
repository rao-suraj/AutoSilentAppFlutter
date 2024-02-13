import 'dart:async';
import 'package:auto_silent_app/gen/fonts.gen.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({super.key});

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  late StreamSubscription<DateTime> _streamSubscription;
  late DateTime _currentTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTime = DateTime.now();
    _streamSubscription =
        Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now())
            .listen((event) {
      setState(() {
        _currentTime = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
              style: theme.h2Medium.copyWith(
                  color: colorScheme.onPrimary, fontFamily: FontFamily.digital),
              children: [
                TextSpan(
                  text: DateFormat("hh:mm").format(_currentTime),
                ),
                TextSpan(
                    text: DateFormat(" a").format(_currentTime),
                    style:
                        theme.h2low.copyWith(fontFamily: FontFamily.digital)),
              ]),
        ),
        AutoSizeText(DateFormat('dd MMM EEE').format(_currentTime),
            style: theme.h2low.copyWith(color: colorScheme.onPrimary),
            minFontSize: theme.h3.fontSize!),
      ],
    );
  }
}
