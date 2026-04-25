import 'package:injectable/injectable.dart';
import '../../../../core/storage/hive_storage_contract.dart';
import '../../data/data_sources/results_local_data_source_contract.dart';

@Injectable(as: ResultsLocalDataSourceContract)
class ResultsLocalDataSourceImpl implements ResultsLocalDataSourceContract {
  final HiveStorageContract _hiveStorage;

  ResultsLocalDataSourceImpl(this._hiveStorage);

  @override
  Future<Map<String, dynamic>> getSavedExams() async {
    return await _hiveStorage.getAllData('exams_history');
  }
}
