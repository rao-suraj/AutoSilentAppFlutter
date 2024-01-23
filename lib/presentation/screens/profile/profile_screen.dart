import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/progile_states.dart';
import 'package:auto_silent_app/presentation/screens/profile/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_provider/theme_provider.dart';

class ProfileScereen extends StatefulWidget {
  const ProfileScereen({super.key});
  @override
  State<ProfileScereen> createState() => _ProfileScereenState();
}

class _ProfileScereenState extends State<ProfileScereen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {
                if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  return StreamBuilder(
                      stream: state.profileStream,
                      builder: (context, stream) {
                        if (stream.data == null) {
                          // stream gives null for some time in the starting
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1 / 1.02,
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
                }else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
        TextButton(child:const Text("Change Theme"),onPressed: (){
              ThemeProvider.controllerOf(context).nextTheme();
          },)
      ],
    );
  }
}
