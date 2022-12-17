import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'license.dart';
import 'meaning.dart';
import 'phonetic.dart';

part 'word_description.g.dart';

@JsonSerializable()
class WordDescription extends Equatable {
  final String? word;
  final List<Phonetic>? phonetics;
  final List<Meaning>? meanings;
  final License? license;
  final List<String>? sourceUrls;

  const WordDescription({
    this.word,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  factory WordDescription.fromJson(Map<String, dynamic> json) {
    return _$WordDescriptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WordDescriptionToJson(this);

  WordDescription copyWith({
    String? word,
    List<Phonetic>? phonetics,
    List<Meaning>? meanings,
    License? license,
    List<String>? sourceUrls,
  }) {
    return WordDescription(
      word: word ?? this.word,
      phonetics: phonetics ?? this.phonetics,
      meanings: meanings ?? this.meanings,
      license: license ?? this.license,
      sourceUrls: sourceUrls ?? this.sourceUrls,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      word,
      phonetics,
      meanings,
      license,
      sourceUrls,
    ];
  }
}
