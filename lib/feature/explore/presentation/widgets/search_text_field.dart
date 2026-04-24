import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_cubit.dart';
import 'package:exam/feature/explore/presentation/view_model/explore_intent.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final ExploreCubit exploreCubit;
  const SearchTextField({super.key, required this.exploreCubit});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        exploreCubit.doIntent(FilterSubjectsIntent(value));
      },
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: ColorManager.greyColor, size: 24),
        hintText: "Search",
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
