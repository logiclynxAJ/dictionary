import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'definition.dart';

part 'meaning.g.dart';

@JsonSerializable()
class Meaning extends Equatable {
  final String? partOfSpeech;
  final List<Definition>? definitions;
  final List<String>? synonyms;
  final List<dynamic>? antonyms;

  const Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return _$MeaningFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MeaningToJson(this);

  Meaning copyWith({
    String? partOfSpeech,
    List<Definition>? definitions,
    List<String>? synonyms,
    List<dynamic>? antonyms,
  }) {
    return Meaning(
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitions: definitions ?? this.definitions,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      partOfSpeech,
      definitions,
      synonyms,
      antonyms,
    ];
  }
}
