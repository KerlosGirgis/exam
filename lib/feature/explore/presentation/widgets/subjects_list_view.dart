import 'package:exam/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class SubjectListView extends StatelessWidget {
  final dynamic subject;
  final VoidCallback? onTap;

  const SubjectListView({super.key, required this.subject, this.onTap});

  @override
  Widget build(BuildContext context) {
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
              (subject != null &&
                      subject.icon is String &&
                      (subject.icon as String).isNotEmpty)
                  ? Image.network(
                      subject.icon,
                      height: 48,
                      width: 48,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image),
                    )
                  : const Icon(Icons.image),
              const SizedBox(width: 10),
              Text(
                (subject != null &&
                        subject.name is String &&
                        (subject.name as String).isNotEmpty)
                    ? subject.name
                    : 'Unknown',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
