import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/themes/extensions.dart';
import 'package:auto_silent_app/presentation/utils/app_icons.dart';
import 'package:auto_silent_app/presentation/utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AddSessionDailogBox extends StatefulWidget {
  const AddSessionDailogBox({super.key});

  @override
  State<AddSessionDailogBox> createState() => _AddSessionDailogBoxState();
}

class _AddSessionDailogBoxState extends State<AddSessionDailogBox> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  late String title;
  final daysOfWeek = [true, true, true, true, true, true, true];
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
                    AppIcons.access_time,
                    size: 34,
                  )
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "Start Time",
                      style: textTheme.h3Bold.copyWith(color: colorScheme.onPrimary),
                    ),
                    const Gap(5),
                    InkWell(
                      splashColor: colorScheme.onPrimary.withOpacity(0.1),
                      radius: 10,
                      onTap: () async {
                        FocusScope.of(context).requestFocus();
                        final time =
                            await DateTimeUtil.showDialogTimePicker(context);
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
                          child: Text(DateTimeUtil.getFormattedTime(startTime),style: textTheme.h3Medium.copyWith(color: colorScheme.onPrimary),),
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
                      style:textTheme.h3Bold.copyWith(color: colorScheme.onPrimary),
                    ),
                    const Gap(5),
                    InkWell(
                      splashColor: colorScheme.onPrimary.withOpacity(0.1),
                      radius: 10,
                      onTap: () async {
                        final time =
                            await DateTimeUtil.showDialogTimePicker(context);

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
                          child: Text(DateTimeUtil.getFormattedTime(endTime),style: textTheme.h3Medium.copyWith(color: colorScheme.onPrimary),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            WeekdaySelector(
              selectedColor: colorScheme.surface,
              selectedFillColor: colorScheme.onPrimary,
              disabledColor: colorScheme.surface,
              disabledFillColor: colorScheme.onPrimary,
              selectedSplashColor: Colors.grey.withOpacity(0.2),
              onChanged: (int day) {
                setState(() {
                  // Use module % 7 as Sunday's index in the array is 0 and
                  // DateTime.sunday constant integer value is 7.
                  final index = day % 7;
                  // We "flip" the value in this example, but you may also
                  // perform validation, a DB write, an HTTP call or anything
                  // else before you actually flip the value,
                  // it's up to your app's needs.
                  daysOfWeek[index] = !daysOfWeek[index];
                });
              },
              values: daysOfWeek,
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
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
                if ((startTime.hour * 60 + startTime.minute) <
                    (endTime.hour * 60 + endTime.minute)) {
                  context.read<SessionCubit>().insertSession(
                      title: title,
                      startTime: startTime,
                      endTime: endTime,
                      daysOfWeek: daysOfWeek);
                  Navigator.pop(context);
                } else {
                  // have to do something about this
                  print("Invalid");
                }
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
