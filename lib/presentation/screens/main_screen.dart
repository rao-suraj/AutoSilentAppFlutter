import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/di/get_it.dart';
import 'package:auto_silent_app/gen/assets.gen.dart';
import 'package:auto_silent_app/gen/fonts.gen.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_states.dart';
import 'package:auto_silent_app/presentation/screens/widgets/app_functions.dart';
import 'package:auto_silent_app/presentation/screens/widgets/my_floating_action_button.dart';
import 'package:auto_silent_app/presentation/utils/app_icons.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  int visit = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    final curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton:
            MyFloatingActionButton(_animationController, _animation),
        bottomNavigationBar: SizedBox(
          height: mediaQuery.height * 0.1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: colorScheme.surface,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: colorScheme.surface,
                  child: BottomBarDefault(
                    items: navItems,
                    backgroundColor: Colors.transparent,
                    color: colorScheme.onSecondary,
                    colorSelected: colorScheme.primary,
                    indexSelected: visit,
                    iconSize: 24,
                    onTap: (int index) => setState(() {
                      visit = index;
                    }),
                    titleStyle: const TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Auto Silent",
                          style: TextStyle(
                              fontFamily: FontFamily.rubik,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.primary),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Assets.images.menuBar.svg(
                          width: 40,
                          height: 40,
                          colorFilter: ColorFilter.mode(
                              colorScheme.onSecondary, BlendMode.srcIn),
                        ),
                      )
                    ]),
              ),
              Expanded(
                flex: 80,
                child: Center(
                  child: Column(children: [
                    Row(
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
                        TextButton(
                          onPressed: () {
                            getIt<AppDatabase>().sessionDao.insertSession(
                                Session(
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
                    TextButton(
                        onPressed: () {
                          Workmanager().registerOneOffTask(
                              "task-identifier", "simpleTask",
                              initialDelay: const Duration(minutes: 15),
                              constraints: Constraints(
                                  networkType: NetworkType.not_required,
                                  requiresBatteryNotLow: false,
                                  requiresCharging: false,
                                  requiresDeviceIdle: false,
                                  requiresStorageNotLow: false));
                        },
                        child: const Text("Click Here")),
                    TextButton(
                        onPressed: () {
                          Workmanager().cancelAll();
                        },
                        child: const Text("Cancle All")),
                    TextButton(
                      child: Text("Add Alarm"),
                      onPressed: () {
                        // AndroidAlarmManager.oneShot(
                        //     Duration(seconds: 5), 2, AppFunctions.printHello);
                      },
                    ),
                    TextButton(onPressed: (){
                      AndroidAlarmManager.cancel(1);
                    }, child: Text("Cancle All Alarm")),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<TabItem> navItems = [
  TabItem(
    icon: AppIcons.access_time,
    title: 'Schedule',
  ),
  TabItem(
    icon: AppIcons.content_copy,
    title: 'Profile',
  ),
  TabItem(
    icon: AppIcons.beenhere,
    title: 'Calander',
  ),
];

