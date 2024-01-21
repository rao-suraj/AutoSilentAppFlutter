import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/data/utils/work_manager_constants.dart';
import 'package:auto_silent_app/di/get_it.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
                          return const CircularProgressIndicator();
                        }
                        return SizedBox(
                          height: 140,
                          child: ListView.builder(
                              itemCount: stream.data!.length,
                              itemBuilder: (context, index) {
                                return Text(
                                    "Id ${stream.data!.elementAt(index).id.toString()} title ${stream.data!.elementAt(index).title} days ${stream.data!.elementAt(index).sunday}");
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
                  id: 15,
                  title: "Sunday",
                  startTime: DateTime.now().add(const Duration(minutes: 1)),
                  endTime: DateTime.now().add(const Duration(minutes: 2)),
                  sunday: true));
            },
            child: const Text("Add Session 1"),
          ),
          TextButton(
            onPressed: () {
              getIt<AppDatabase>().sessionDao.insertSession(Session(
                  id: 16,
                  title: "Sunday 2",
                  startTime: DateTime.now().add(const Duration(minutes: 4)),
                  endTime: DateTime.now().add(const Duration(minutes: 5)),
                  sunday: true));
            },
            child: const Text("Add Session 2"),
          ),
          TextButton(
              onPressed: () async {
                await Workmanager().registerPeriodicTask(
                    WorkManagerConstants.workManagerTaskName, WorkManagerConstants.workManagerTaskName,
                    existingWorkPolicy: ExistingWorkPolicy.replace,
                    backoffPolicy: BackoffPolicy.linear,
                    backoffPolicyDelay: const Duration(minutes: 10),
                    constraints: Constraints(
                        networkType: NetworkType.not_required,
                        requiresBatteryNotLow: false,
                        requiresCharging: false,
                        requiresDeviceIdle: false,
                        requiresStorageNotLow: false));
              },
              child: const Text("Add Session")),
          TextButton(
            onPressed: () {
              Workmanager().cancelAll();
            },
            child: const Text("Cancel All Sessions"),
          ),
          TextButton(
            onPressed: () {
              context.read<SessionCubit>().updateSession(
                  session: Session(
                      id: 15,
                      title: "Sunday",
                      startTime: DateTime.now().add(const Duration(minutes: 1)),
                      endTime: DateTime.now().add(const Duration(minutes: 2)),
                      sunday: true));
            },
            child: const Text("Update Session 1"),
          ),
          TextButton(
            onPressed: () {
              context.read<SessionCubit>().updateSession(
                  session: Session(
                      id: 16,
                      title: "Sunday 2",
                      startTime: DateTime.now().add(const Duration(minutes: 3)),
                      endTime: DateTime.now().add(const Duration(minutes: 4)),
                      sunday: true));
            },
            child: const Text("Update Session 2"),
          ),
        ],
      ),
    );
  }
}
