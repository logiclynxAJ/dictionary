import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'license.dart';

part 'phonetic.g.dart';

@JsonSerializable()
class Phonetic extends Equatable implements Comparable<Phonetic> {
  final String? audio;
  final String? sourceUrl;
  final License? license;
  final String? text;

  const Phonetic({this.audio, this.sourceUrl, this.license, this.text});

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return _$PhoneticFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PhoneticToJson(this);

  Phonetic copyWith({
    String? audio,
    String? sourceUrl,
    License? license,
    String? text,
  }) {
    return Phonetic(
      audio: audio ?? this.audio,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      license: license ?? this.license,
      text: text ?? this.text,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [audio, sourceUrl, license, text];

  @override
  int compareTo(other) {
    final isAudioValid = audio?.isNotEmpty ?? false;
    final isOtherAudioValid = other.audio?.isNotEmpty ?? false;

    if (isAudioValid && !isOtherAudioValid) return 1;

    return -1;
  }
}
