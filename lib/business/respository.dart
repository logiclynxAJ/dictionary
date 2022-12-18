import 'dart:async';

import 'package:dictionary/business/service.dart';
import 'package:dictionary/models/word_description/word_description.dart';
import 'package:rxdart/subjects.dart';

import 'methods.dart';

enum WordStatus { loading, error, success, idle }

typedef WordStatusMap = Map<String, WordStatus>;

class DictionaryRepository implements DictionaryMethods {
  DictionaryRepository._internal();
  static final DictionaryRepository instance = DictionaryRepository._internal();

  final DictionaryService _service = DictionaryService.instance;

  final wordsController = BehaviorSubject<WordDecriptionMap>.seeded({});

  Stream<WordDecriptionMap> get wordsStream => wordsController.stream;

  WordDecriptionMap get allWords => wordsController.value;

  final wordStatusController = BehaviorSubject<WordStatusMap>.seeded({});

  Stream<WordStatusMap> get wordStatusStream => wordStatusController.stream;

  WordStatusMap get statuses => wordStatusController.value;

  @override
  FutureOr<WordDescriptions> getWordDescription(String word) async {
    try {
      //If cached then return
      if (allWords.containsKey(word)) return allWords[word]!;
      //else fetch from api and update the stream
      wordStatusController.add({...statuses, word: WordStatus.loading});
      final response = await _service.getWordDescription(word);
      wordsController.add({...allWords, word: response});
      wordStatusController.add({...statuses, word: WordStatus.success});
      return response;
    } catch (e) {
      wordStatusController.add({...statuses, word: WordStatus.error});
      return [];
    }
  }
}
