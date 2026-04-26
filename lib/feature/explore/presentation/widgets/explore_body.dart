import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_cubit.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_states.dart';
import 'package:exam/feature/explore/presentation/widgets/search_text_field.dart';
import 'package:exam/feature/explore/presentation/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePageBody extends StatelessWidget {
  const ExplorePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreCubit, ExploreStates>(
      listenWhen: (prev, curr) =>
          prev.exploreState?.errorMessage != curr.exploreState?.errorMessage,
      listener: (context, state) {
        final explore = state.exploreState;
        if (explore?.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(explore!.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final explore = state.exploreState;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore',
                      style: TextStyle(
                        color: ColorManager.primeColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SearchTextField(),
                    const SizedBox(height: 24),
                    const Text(
                      AppTextConstants.browseBySubject,
                      style: TextStyle(
                        color: ColorManager.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            if (explore?.isLoading ?? false)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: ColorManager.primeColor),
                ),
              )
            else if (explore?.data?.isEmpty ?? true)
              const SliverFillRemaining(
                child: Center(
                  child: Text(
                    AppTextConstants.noSubjectsFound,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final subject = explore!.data?[index];
                      return SubjectCard(
                        subject: subject,
                        onTap: () {
                          if (subject?.id != null) {
                            Navigator.of(context).pushNamed(
                              AppRoutes.subjectExamScreen,
                              arguments: subject!.id,
                            );
                          }
                        },
                      );
                    },
                    childCount: explore?.data?.length ?? 0,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }
}
