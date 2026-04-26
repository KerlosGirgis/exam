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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorManager.whiteBlueColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorManager.whiteBlueColor.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: hasIcon
                  ? CachedNetworkImage(
                      imageUrl: iconUrl,
                      height: 40,
                      width: 40,
                      placeholder: (_, _) => const SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (_, _, _) => const Icon(
                        Icons.book,
                        color: ColorManager.primeColor,
                        size: 30,
                      ),
                    )
                  : const Icon(
                      Icons.book,
                      color: ColorManager.primeColor,
                      size: 30,
                    ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                (subject?.name != null && subject!.name!.isNotEmpty)
                    ? subject!.name!
                    : AppTextConstants.unknown,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.blackColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
