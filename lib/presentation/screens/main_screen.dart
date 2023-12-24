import 'package:auto_silent_app/gen/assets.gen.dart';
import 'package:auto_silent_app/gen/fonts.gen.dart';
import 'package:auto_silent_app/presentation/screens/widgets/floating_action_button.dart';
import 'package:auto_silent_app/presentation/utils/app_icons.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

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
        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat,
        floatingActionButton: MyFloatingActionButton(_animationController, _animation),
            bottomNavigationBar:  SizedBox(
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
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        ThemeProvider.controllerOf(context).nextTheme();
                      },
                      child: const Text("Change Theme"),
                    ),
                  ),
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
