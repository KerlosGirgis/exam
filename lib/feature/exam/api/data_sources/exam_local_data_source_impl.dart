import 'package:exam/core/storage/hive_storage_contract.dart';
import 'package:injectable/injectable.dart';
import '../../data/data_sources/exam_local_data_source_contract.dart';

@Injectable(as: ExamLocalDataSourceContract)
class ExamLocalDataSourceImpl implements ExamLocalDataSourceContract {
  final HiveStorageContract _hiveStorage;

  ExamLocalDataSourceImpl(this._hiveStorage);

  @override
  Future<void> saveExamResult(Map<String, dynamic> result) async {
    final String uid = DateTime.now().millisecondsSinceEpoch.toString();
    await _hiveStorage.saveData('exams_history', uid, result);
  }
}
