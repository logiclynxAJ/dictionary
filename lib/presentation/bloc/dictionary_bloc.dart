import 'dart:developer';

import 'package:dictionary/business/event.dart';
import 'package:dictionary/business/respository.dart';
import 'package:dictionary/business/state.dart';
import 'package:dictionary/config/configs.dart';
import 'package:dictionary/models/word_description/word_description.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  DictionaryBloc(DictionaryRepository repository)
      : _repository = repository,
        super(const DictionaryState()) {
    on<GetWordDescription>(_handleWordDescriptionRequest);
    on<UpdateSeletedOption>(_updateSelectedOption);
    on<UpdateSelectedWord>(_updateSelectedWord);
  }

  final Box<String> recentsBox = Hive.box(AppConfigs.strings.recentsBox);

  ValueListenable<Box<String>> get recentsStream => recentsBox.listenable();

  bool listenerAttached = false;

  final DictionaryRepository _repository;

  void _updateSelectedWord(
    UpdateSelectedWord event,
    Emitter<DictionaryState> emit,
  ) {
    final existingState = Map.of(state.selectedWordMap);
    final currentValue = existingState[event.word.toLowerCase()] ?? 0;
    emit(state.copyWith(
      selectedWordMap: {
        ...existingState,
        event.word.toLowerCase(): event.type == UpdateType.increment
            ? currentValue + 1
            : currentValue - 1,
      },
    ));
  }

  void _updateSelectedOption(
    UpdateSeletedOption event,
    Emitter<DictionaryState> emit,
  ) {
    final existingState = Map.of(state.speechSelectedValues);
    final currentOptionState = existingState[event.word.toLowerCase()] ?? {};
    final selectedIndex = state.getSelectedWord(event.word);
    emit(state.copyWith(
      speechSelectedValues: {
        ...existingState,
        event.word.toLowerCase(): {
          ...currentOptionState,
          selectedIndex: event.value,
        }
      },
    ));
  }

  void _handleWordDescriptionRequest(
    GetWordDescription event,
    Emitter<DictionaryState> emit,
  ) async {
    final index =
        recentsBox.values.toList().lastIndexOf(event.word.toLowerCase());
    if (index != -1) {
      await recentsBox.deleteAt(index);
    }
    recentsBox.add(event.word.toLowerCase());
    _repository.getWordDescription(event.word.toLowerCase());

    if (!listenerAttached) {
      try {
        listenerAttached = true;
        final combinedStream = CombineLatestStream(
          [_repository.wordStatusStream, _repository.wordsStream],
          (values) => {
            "status": values[0],
            "descriptions": values[1],
          },
        );
        await emit.forEach(
          combinedStream,
          onData: (status) {
            return state.copyWith(
              wordStatusMap: status['status'] as WordStatusMap,
              decriptionMap: status['descriptions'] as WordDecriptionMap,
            );
          },
        );
      } catch (e) {
        listenerAttached = false;
      }
    }
  }
}
