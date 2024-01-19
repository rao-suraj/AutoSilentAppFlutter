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
                  if (state is CalendarLaoded) {
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
              context.read<CalendarCubit>().updateCalendar(
                    calendar: Calendar(
                        id: 4,
                        title: "Nothing",
                        startTime: DateTime.now(),
                        endTime: DateTime.now(),
                        dateTime: DateTime.now()),
                  );
              context.read<CalendarCubit>().getCalendarStream();
            },
            child: const Text("Add Calander"),
          )
        ],
      ),
    );
  }
}
