import 'package:equatable/equatable.dart';

abstract class DictionaryEvent extends Equatable {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class GetWordDescription extends DictionaryEvent {
  final String word;

  GetWordDescription(this.word);

  @override
  List<Object?> get props => [word];
}

class UpdateSeletedOption extends DictionaryEvent {
  final String word;
  final String value;

  UpdateSeletedOption(this.word, this.value);

  @override
  List<Object?> get props => [word, value];
}

class UpdateSelectedWord extends DictionaryEvent {
  final String word;
  final UpdateType type;

  UpdateSelectedWord(this.word, this.type);
}

enum UpdateType { increment, decrement }
