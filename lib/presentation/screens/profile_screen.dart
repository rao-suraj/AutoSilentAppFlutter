import 'package:auto_silent_app/data/models/profile.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/progile_states.dart';
import 'package:auto_silent_app/presentation/screens/widgets/profile_tile.dart';
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
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<ProfileCubit, ProfileStates>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return StreamBuilder(
                      stream: state.prfileStream,
                      builder: (context, stream) {
                        if (stream.data == null) {
                          // stream gives null for some time in the starting
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: stream.data!.length,
                            itemBuilder: (context, index) {
                              return ProfileTile(
                                profile: stream.data![index],
                              );
                            });
                      });
                }
                if (state is ProfileError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
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
            // context.read<ProfileCubit>().insertProfile(
            //       profile: Profile(
            //         id: 6,
            //         title: "Hello",
            //         isActive: false,
            //       ),
            //     );
          },
          child: const Text("Add Profile"),
        ),
      ],
    );
  }
}
