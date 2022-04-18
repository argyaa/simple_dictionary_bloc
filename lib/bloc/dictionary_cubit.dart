import 'package:dictionary_bloc/models/dictionary_model.dart';
import 'package:dictionary_bloc/repo/dictionary_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final DictionaryRepository _repository;

  DictionaryCubit(this._repository) : super(NoWordSearchedState());

  final queryController = TextEditingController();

  Future getWordSearched(String query) async {
    emit(WordSearchingState());

    try {
      final dictionary = await _repository.getWordsFromDictionary(query);

      emit(WordSearchedState(dictionary));
      // emit(NoWordSearchedState());
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class DictionaryState {}

class NoWordSearchedState extends DictionaryState {}

class WordSearchingState extends DictionaryState {}

class WordSearchedState extends DictionaryState {
  final List<DictionaryModel> words;

  WordSearchedState(this.words);
}

class ErrorState extends DictionaryState {
  final String error;
  ErrorState(this.error);
}
