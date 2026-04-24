abstract interface class ExamLocalDataSourceContract {
  Future<void> saveExamResult(Map<String, dynamic> result);
}
