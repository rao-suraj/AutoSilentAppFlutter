import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/progile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScereen extends StatefulWidget {
  const ProfileScereen({super.key});

  @override
  State<ProfileScereen> createState() => _ProfileScereenState();
}

class _ProfileScereenState extends State<ProfileScereen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileStates>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return Expanded(
                  child: StreamBuilder(
                      stream: state.prfileStream,
                      builder: (context, stream) {
                        if (stream.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return GridView.count(crossAxisCount: 2,children: [],);
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
          TextButton(
            onPressed: () {
              context.read<ProfileCubit>().insertProfile(
                      profile: Profile(
                    id: 5,
                    title: "old",
                  ));
            },
            child: const Text("Add Profile"),
          ),
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
