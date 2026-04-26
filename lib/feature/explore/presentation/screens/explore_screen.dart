import 'package:exam/config/di/di.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_cubit.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_intent.dart';
import 'package:exam/feature/explore/presentation/widgets/explore_body.dart';
import 'package:exam/feature/profile/presentation/screens/profile_screen.dart';
import 'package:exam/feature/results/presentation/bloc/results_bloc.dart';
import 'package:exam/feature/results/presentation/bloc/results_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../results/presentation/screens/results_screen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentIndex = 0;
  late ResultsBloc _resultsBloc;

  @override
  void initState() {
    super.initState();
    _resultsBloc = getIt<ResultsBloc>();
  }

  late final List<Widget> _tabs = [
    BlocProvider(
      create: (_) => getIt<ExploreCubit>()..doIntent(LoadSubjectsIntent()),
      child: const SafeArea(child: ExplorePageBody()),
    ),
    const ResultsScreen(),
    ProfileScreen(onBack: () => setState(() => _currentIndex = 0)),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _resultsBloc,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          backgroundColor: ColorManager.whiteColor,
          body: IndexedStack(index: _currentIndex, children: _tabs),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: NavigationBar(
              backgroundColor: Colors.white,
              indicatorColor: ColorManager.activeNavBarColor,
              elevation: 0,
              selectedIndex: _currentIndex,
              onDestinationSelected: (i) {
                setState(() => _currentIndex = i);
                if (i == 1) {
                  _resultsBloc.add(LoadResultsEvent());
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home, color: ColorManager.primeColor),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(
                    Icons.assignment,
                    color: ColorManager.primeColor,
                  ),
                  label: 'Result',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person, color: ColorManager.primeColor),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
