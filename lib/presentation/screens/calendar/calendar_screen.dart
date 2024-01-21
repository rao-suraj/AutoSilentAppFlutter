import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_states.dart';
import 'package:auto_silent_app/presentation/screens/calendar/widgets/calendar_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    context.read<CalendarCubit>().getCalendarStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BlocConsumer<CalendarCubit, CalendarStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CalendarLoaded) {
                    return StreamBuilder(
                        stream: state.calendarStream,
                        builder: (context, stream) {
                          if (stream.data == null) {
                            // in the starting stream gives null
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1 / 0.92,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: stream.data!.length,
                              itemBuilder: (context, index) {
                                return CalendarTile(
                                  calendar: stream.data![index],
                                );
                              });
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              AndroidAlarmManager.cancel(10);
              print("Set");

              context.read<CalendarCubit>().switchCalendar(
                  calendar: Calendar(
                      id: 12,
                      title: "Suraj",
                      startTime: DateTime.now().add(
                        const Duration(minutes: 2),
                      ),
                      endTime: DateTime.now().add(const Duration(minutes: 4)),
                      dateTime: DateTime.now()));
              // final time = DateTime.now().add(Duration(minutes: 2));
              // print(time);
              // AndroidAlarmManager.oneShotAt(
              //     time, 2, AlarmManagerFunctions.setSilent);
            },
            child: const Text("Add Calander"),
          )
        ],
      ),
    );
  }
}
