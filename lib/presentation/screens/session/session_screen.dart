import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_states.dart';
import 'package:auto_silent_app/presentation/screens/session/widgets/session_tile.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<SessionCubit, SessionStates>(
              builder: (context, state) {
                if (state is SessionLoaded) {
                  return StreamBuilder(
                      stream: state.sessionStream,
                      builder: (context, stream) {
                        if (stream.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return ListView.separated(
                            separatorBuilder: (context, intex) =>
                                const SizedBox(
                                  height: 13,
                                ),
                            itemCount: stream.data!.length,
                            itemBuilder: (context, index) {
                              return SessionTile(session: stream.data![index]);
                            });
                      });
                }
                return Container();
              },
            ),
          ),
          TextButton(
            onPressed: () {
              // getIt<AppDatabase>().sessionDao.insertSession(Session(
              //     id: 3,
              //     title: "new",
              //     startTime: DateTime.now(),
              //     endTime: DateTime.now(),
              //     monday: true));
              Workmanager().cancelAll();
            },
            child: const Text("Add Session"),
          ),
        ],
      ),
    );
  }
}
