import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam/core/constant/app_text_constants.dart';
import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/feature/explore/domain/model/subject_entity.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key, required this.subject, this.onTap});

  final SubjectEntity? subject;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconUrl = subject?.icon;
    final hasIcon = iconUrl != null && iconUrl.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorManager.greyColor.withAlpha(60),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              hasIcon
                  ? CachedNetworkImage(
                      imageUrl: iconUrl,
                      height: 48,
                      width: 48,
                      placeholder: (_, _) => const SizedBox(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                      errorWidget: (_, _, _) => const Icon(Icons.image),
                    )
                  : const Icon(Icons.image),
              const SizedBox(width: 10),
              Text(
                (subject?.name != null && subject!.name!.isNotEmpty)
                    ? subject!.name!
                    : AppTextConstants.unknown,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
