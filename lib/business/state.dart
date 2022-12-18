// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:dictionary/business/respository.dart';
import 'package:dictionary/models/word_description/word_description.dart';

typedef PartOfSpeechSelectedValues = Map<String, Map<int, String>>;
typedef SelectedWordMap = Map<String, int>;

class DictionaryState extends Equatable {
  final WordDecriptionMap decriptionMap;
  final WordStatusMap wordStatusMap;
  final PartOfSpeechSelectedValues speechSelectedValues;
  final SelectedWordMap selectedWordMap;

  const DictionaryState({
    this.decriptionMap = const {},
    this.wordStatusMap = const {},
    this.speechSelectedValues = const {},
    this.selectedWordMap = const {},
  });

  DictionaryState copyWith({
    WordDecriptionMap? decriptionMap,
    WordStatusMap? wordStatusMap,
    PartOfSpeechSelectedValues? speechSelectedValues,
    SelectedWordMap? selectedWordMap,
  }) {
    return DictionaryState(
      decriptionMap: decriptionMap ?? this.decriptionMap,
      wordStatusMap: wordStatusMap ?? this.wordStatusMap,
      speechSelectedValues: speechSelectedValues ?? this.speechSelectedValues,
      selectedWordMap: selectedWordMap ?? this.selectedWordMap,
    );
  }

  bool isLoading(String word) {
    return (wordStatusMap[word.toLowerCase()] ?? WordStatus.idle) ==
        WordStatus.loading;
  }

  bool isError(String word) {
    return (wordStatusMap[word.toLowerCase()] ?? WordStatus.idle) ==
        WordStatus.error;
  }

  WordDescriptions getDescription(String word) {
    return decriptionMap[word.toLowerCase()] ?? [];
  }

  int getSelectedWord(String word) {
    return selectedWordMap[word.toLowerCase()] ?? 0;
  }

  String getSelectedSpeechValue(String word, String defaultValue) =>
      speechSelectedValues[word.toLowerCase()]?[getSelectedWord(word)] ??
      defaultValue;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        decriptionMap,
        wordStatusMap,
        speechSelectedValues,
        selectedWordMap,
      ];
}
