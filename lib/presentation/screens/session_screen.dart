import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/di/get_it.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          BlocBuilder<SessionCubit, SessionStates>(
            builder: (context, state) {
              if (state is SessionLoaded) {
                return SizedBox(
                  height: 170,
                  width: 100,
                  child: StreamBuilder(
                      stream: state.sessionStream,
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
          TextButton(
            onPressed: () {
              getIt<AppDatabase>().sessionDao.insertSession(Session(
                  id: 3,
                  title: "new",
                  startTime: DateTime.now(),
                  endTime: DateTime.now(),
                  monday: true));
            },
            child: const Text("Add Session"),
          ),
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
          // TextButton(
          //   onPressed: () {
          //     context.read<CalendarsCubit>().insertCalendar(
          //           calendar: Calendar(
          //               id: 4,
          //               title: "nothing",
          //               startTime: DateTime.now(),
          //               endTime: DateTime.now(),
          //               dateTime: DateTime.now()),
          //         );
          //   },
          //   child: const Text("Add Calander"),
          // )
        ],
      ),
    );
  }
}
