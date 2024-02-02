import 'package:auto_silent_app/gen/assets.gen.dart';
import 'package:auto_silent_app/gen/fonts.gen.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_cubit.dart';
import 'package:auto_silent_app/presentation/screens/calendar/calendar_screen.dart';
import 'package:auto_silent_app/presentation/screens/calendar/widgets/add_calendar_dialogbox.dart';
import 'package:auto_silent_app/presentation/screens/profile/profile_screen.dart';
import 'package:auto_silent_app/presentation/screens/session/session_screen.dart';
import 'package:auto_silent_app/presentation/screens/profile/widgets/add_profile_dialogbox.dart';
import 'package:auto_silent_app/presentation/screens/session/widgets/add_session_dialogbox.dart';
import 'package:auto_silent_app/presentation/utils/app_icons.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  int _selectedPage = 0;

  final List<TabItem> navItems = [
    const TabItem(
      icon: AppIcons.content_copy,
      title: 'Profile',
    ),
    const TabItem(
      icon: AppIcons.access_time,
      title: 'Session',
    ),
    const TabItem(
      icon: AppIcons.beenhere,
      title: 'Calander',
    ),
  ];

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
    final pageOptions = [
      BlocProvider<ProfileCubit>.value(
        value: context.read<ProfileCubit>(),
        child: const ProfileScereen(),
      ),
      BlocProvider<SessionCubit>.value(
          value:context.read<SessionCubit>(),
          child: const SessionScreen()),
      BlocProvider<CalendarCubit>.value(
          value: context.read<CalendarCubit>(), child: const CalendarScreen()),
    ];
    final mediaQuery = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        }
      },
      onVerticalDragUpdate: (details) {
        if (_animationController.isCompleted) {
          _animationController.reverse();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.background,
          scrolledUnderElevation: 5,
          centerTitle: false,
          title: Text(
            "AutoSilent",
            style: TextStyle(
                fontFamily: FontFamily.rubik,
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: colorScheme.primary),
          ),
          toolbarHeight: mediaQuery.height * 0.09,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Assets.images.menuBar.svg(
                width: 40,
                height: 40,
                colorFilter:
                    ColorFilter.mode(colorScheme.onSecondary, BlendMode.srcIn),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: _floatingActionButton(
            context: context,
            animationController: _animationController,
            animation: _animation),
        body: pageOptions[_selectedPage],
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
                    indexSelected: _selectedPage,
                    iconSize: 24,
                    onTap: (int index) => setState(() {
                      _selectedPage = index;
                    }),
                    titleStyle: const TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floatingActionButton(
      {required BuildContext context,
      required AnimationController animationController,
      required Animation animation}) {
    final colorScheme = Theme.of(context).colorScheme;
    return FloatingActionBubble(
      items: [
        Bubble(
          title: "Add Calendar",
          iconColor: colorScheme.onPrimary,
          bubbleColor: colorScheme.surface,
          icon: Icons.add,
          titleStyle: TextStyle(
              fontSize: 18,
              color: colorScheme.onPrimary,
              fontFamily: FontFamily.rubik,
              fontWeight: FontWeight.w600),
          onPress: () {
            showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                      value: context.read<CalendarCubit>(),
                      child: const AddCalendarDialogBox(),
                    ));
          },
        ),
        Bubble(
          title: "Add Profile",
          iconColor: colorScheme.onPrimary,
          bubbleColor: colorScheme.surface,
          icon: Icons.add,
          titleStyle: TextStyle(
              fontSize: 18,
              color: colorScheme.onPrimary,
              fontFamily: FontFamily.rubik,
              fontWeight: FontWeight.w600),
          onPress: () async {
            final List<double?> list =
                await context.read<ProfileCubit>().getCurrentVolumeLevels();
            if (!mounted) return;
            showDialog<void>(
                context: context,
                builder: (_) => BlocProvider<ProfileCubit>.value(
                      value: context.read<ProfileCubit>(),
                      child: AddProfileDialogbox(
                          volumeLevel: list[0] ?? 0.7,
                          ringerLevel: list[1] ?? 0.5),
                    ));
          },
        ),
        Bubble(
          title: "Add Session",
          iconColor: colorScheme.onPrimary,
          bubbleColor: colorScheme.surface,
          icon: Icons.add,
          titleStyle: TextStyle(
              fontSize: 18,
              color: colorScheme.onPrimary,
              fontFamily: FontFamily.rubik,
              fontWeight: FontWeight.w600),
          onPress: () {
              showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                      value: context.read<SessionCubit>(),
                      child: const AddSessionDailogBox(),
                    ));
          },
        )
      ],
      onPress: () => animationController.isCompleted
          ? animationController.reverse()
          : animationController.forward(),
      iconColor: const Color(0xFF303030),
      animation: animation,
      backGroundColor: colorScheme.primary,
      iconData: Icons.add,
    );
  }
}
