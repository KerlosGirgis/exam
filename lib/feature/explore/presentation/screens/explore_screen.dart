import 'package:exam/config/di/di.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_cubit.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_intent.dart';
import 'package:exam/feature/explore/presentation/widgets/explore_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ExploreCubit>()..doIntent(LoadSubjectsIntent()),
      child: Scaffold(body: SafeArea(child: const ExplorePageBody())),
    );
  }
}
