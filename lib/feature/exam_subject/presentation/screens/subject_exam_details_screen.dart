import 'package:exam/core/utils/color_manager.dart';
import 'package:exam/core/utils/router/app_routes.dart';
import 'package:exam/core/utils/widgets/custom_elevated_button.dart';
import 'package:exam/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:flutter/material.dart';

class SubjectExamDetailsScreen extends StatelessWidget {
  const SubjectExamDetailsScreen({super.key, required this.modal});
  final ExamSubjectModel modal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorManager.whiteColor,
        elevation: 0,
        title: const Text(
          'Exam Details',
          style: TextStyle(color: ColorManager.blackColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.blackColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ColorManager.primeColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.primeColor.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.assignment_turned_in, color: Colors.white, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          modal.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Programming Assessment',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Stats Section
                  Row(
                    children: [
                      _buildInfoTile(
                        icon: Icons.help_outline,
                        label: 'Questions',
                        value: '${modal.numberOfQuestions}',
                      ),
                      const SizedBox(width: 16),
                      _buildInfoTile(
                        icon: Icons.timer_outlined,
                        label: 'Duration',
                        value: '${modal.duration} Min',
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Instructions Section
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.blackColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInstructionItem('Read each question carefully before answering.'),
                  _buildInstructionItem('You can go back and change your answers.'),
                  _buildInstructionItem('Ensure you have a stable internet connection.'),
                  _buildInstructionItem('The timer will start as soon as you begin.'),
                ],
              ),
            ),
          ),
          // Start Button Footer
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomButton(
              title: 'Start Exam',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.exam,
                  arguments: modal.id,
                );
              },
              isEnabled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String label, required String value}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorManager.whiteBlueColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: ColorManager.primeColor, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: ColorManager.greyColor, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: ColorManager.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.circle, size: 8, color: ColorManager.primeColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: ColorManager.greyColor,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
