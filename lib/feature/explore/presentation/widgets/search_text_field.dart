import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_cubit.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        context.read<ExploreCubit>().doIntent(FilterSubjectsIntent(value));
      },
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: ColorManager.greyColor,
          size: 24,
        ),
        hintText: AppTextConstants.search,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
