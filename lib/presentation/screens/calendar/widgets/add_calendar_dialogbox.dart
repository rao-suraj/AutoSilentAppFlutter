import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:auto_silent_app/presentation/utils/app_icons.dart';
import 'package:auto_silent_app/presentation/utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddCalendarDialogBox extends StatefulWidget {
  const AddCalendarDialogBox({super.key});

  @override
  State<AddCalendarDialogBox> createState() => _AddCalendarDialogBoxState();
}

class _AddCalendarDialogBoxState extends State<AddCalendarDialogBox> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  late String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: colorScheme.surface,
      contentPadding:
          const EdgeInsets.only(top: 25, right: 20, left: 20, bottom: 20),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 190,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 10,
                      style: textTheme.h3Regular.copyWith(color: colorScheme.onPrimary),
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        title = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title can't be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  const Icon(
                    AppIcons.beenhere,
                    size: 28,
                  )
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "Start Time",
                      style: textTheme.h3ExtraBold
                          .copyWith(color: colorScheme.onPrimary),
                    ),
                    const Gap(5),
                    InkWell(
                      splashColor: colorScheme.onPrimary.withOpacity(0.1),
                      radius: 10,
                      onTap: () async {
                        FocusScope.of(context).requestFocus();
                        final time = await DateTimeUtil.showDialogTimePicker(
                            context: context,
                            helpText: "Start Time",
                            initialTime: startTime);
                        setState(() {
                          startTime = time;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colorScheme.onPrimary)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(DateTimeUtil.getFormattedTime(startTime),
                              style: textTheme.h3Medium
                                  .copyWith(color: colorScheme.onPrimary)),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Column(
                  children: [
                    Text(
                      "End Time",
                      style: textTheme.h3ExtraBold
                          .copyWith(color: colorScheme.onPrimary),
                    ),
                    const Gap(5),
                    InkWell(
                      splashColor: colorScheme.onPrimary.withOpacity(0.1),
                      radius: 10,
                      onTap: () async {
                        final time = await DateTimeUtil.showDialogTimePicker(
                            context: context,
                            helpText: "End Time",
                            initialTime: endTime);

                        setState(() {
                          endTime = time;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colorScheme.onPrimary),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            DateTimeUtil.getFormattedTime(endTime),
                            style: textTheme.h3Medium
                                .copyWith(color: colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Date",
                  style: textTheme.h3ExtraBold
                      .copyWith(color: colorScheme.onPrimary),
                ),
                const Gap(5),
                InkWell(
                  splashColor: colorScheme.onPrimary.withOpacity(0.1),
                  radius: 10,
                  onTap: () async {
                    final time = await DateTimeUtil.showDialogPicker(context);
                    setState(() {
                      date = time;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorScheme.onPrimary)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        DateTimeUtil.getFormattedDate(
                            date.millisecondsSinceEpoch),
                        style: textTheme.h3Regular
                            .copyWith(color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onPrimary,
                textStyle: textTheme.h3Regular,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: textTheme.h3Medium,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onPrimary,
                textStyle: textTheme.h3Regular,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // checking if the starting time is less than ending time
                context.read<CalendarCubit>().insertCalendar(
                    title: title.capitalize(),
                    startTime: startTime,
                    endTime: endTime,
                    date: date);
                Navigator.pop(context);
              }
            },
            child: Text(
              "Add",
              style: textTheme.h3Medium,
            ),
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
