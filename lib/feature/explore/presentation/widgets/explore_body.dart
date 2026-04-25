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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppTextConstants.survey,
            style: TextStyle(
              color: ColorManager.primeColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          const SearchTextField(),
          const SizedBox(height: 30),
          const Text(
            AppTextConstants.browseBySubject,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocConsumer<ExploreCubit, ExploreStates>(
              listenWhen: (prev, curr) =>
                  prev.exploreState?.errorMessage !=
                  curr.exploreState?.errorMessage,
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

                if (explore?.isLoading ?? false) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (explore?.data?.isEmpty ?? true) {
                  return const Center(
                    child: Text(
                      AppTextConstants.noSubjectsFound,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: explore!.data?.length,
                  itemBuilder: (context, index) {
                    final subject = explore.data?[index];
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
