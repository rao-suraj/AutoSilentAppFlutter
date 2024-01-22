import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/di/get_it.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_states.dart';
import 'package:auto_silent_app/presentation/screens/session/widgets/session_tile.dart';
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
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<SessionCubit, SessionStates>(
            builder: (context, state) {
              if (state is SessionLoaded) {
                return StreamBuilder(
                    stream: state.sessionStream,
                    builder: (context, stream) {
                      if (stream.data == null) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
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
            getIt<AppDatabase>().sessionDao.insertSession(Session(
                id: 3,
                title: "new",
                startTime: DateTime.now(),
                endTime: DateTime.now(),
                monday: true));
          },
          child: const Text("Add Session"),
        ),
      ],
    );
  }
}
