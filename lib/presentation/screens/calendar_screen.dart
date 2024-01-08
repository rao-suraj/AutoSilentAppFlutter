import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          BlocBuilder<CalendarsCubit, CalendarStates>(
            builder: (context, state) {
              if (state is CalendarLaoded) {
                return SizedBox(
                  height: 170,
                  width: 100,
                  child: StreamBuilder(
                      stream: state.calendarStream,
                      builder: (context, stream) {
                        if (stream.data == null) {
                          return CircularProgressIndicator();
                        }
                        return SizedBox(
                          height: 140,
                          child: ListView.builder(
                              itemCount: stream.data!.length,
                              itemBuilder: (context, index) {
                                return Text(
                                    "Id ${stream.data!.elementAt(index).id.toString()} title ${stream.data!.elementAt(index).title}");
                              }),
                        );
                      }),
                );
              }
              return Container();
            },
          ),
          // TextButton(
          //   onPressed: () {
          //     getIt<AppDatabase>().sessionDao.insertSession(Session(
          //         id: 3,
          //         title: "new",
          //         startTime: DateTime.now(),
          //         endTime: DateTime.now(),
          //         monday: true));
          //   },
          //   child: const Text("Add Session"),
          // ),
          // TextButton(
          //   onPressed: () {
          //     context.read<ProfileCubit>().updateProfile(
          //             profile: Profile(
          //           id: 25,
          //           title: "old",
          //         ));
          //   },
          //   child: const Text("Add Profile"),
          // ),
          TextButton(
            onPressed: () {
              context.read<CalendarsCubit>().insertCalendar(
                    calendar: Calendar(
                        id: 4,
                        title: "nothing",
                        startTime: DateTime.now(),
                        endTime: DateTime.now(),
                        dateTime: DateTime.now()),
                  );
            },
            child: const Text("Add Calander"),
          )
        ],
      ),
    );
  }
}
