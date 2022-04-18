import 'package:dictionary_bloc/models/dictionary_model.dart';
import 'package:dictionary_bloc/services/http_service.dart';

class DictionaryRepository {
  Future<List<DictionaryModel>> getWordsFromDictionary(String query) async {
    try {
      final response = await HttpService.getRequest(query);
      print(query);
      print(response.statusCode);
      print("Repository" + response.body);

      if (response.statusCode == 200) {
        final result = dictionaryModelFromJson(response.body);
        return result;
      } else {
        throw Exception("faileed");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
