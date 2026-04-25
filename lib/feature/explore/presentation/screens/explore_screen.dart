import 'package:exam/config/di/di.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_cubit.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_intent.dart';
import 'package:exam/feature/explore/presentation/widgets/explore_body.dart';
import 'package:exam/feature/profile/presentation/screens/profile_screen.dart';
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
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        backgroundColor: ColorManager.navBarColor,
        indicatorColor: ColorManager.activeNavBarColor,
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: 'Result',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
