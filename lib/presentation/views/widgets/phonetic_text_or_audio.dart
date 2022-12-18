import 'package:dictionary/models/word_description/phonetic.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PhoneticTextOrAudio extends StatelessWidget {
  const PhoneticTextOrAudio({
    super.key,
    required this.phonetic,
    this.addComma = true,
    required this.player,
  });
  final Phonetic phonetic;
  final bool addComma;
  final AudioPlayer player;
  void _play(String audio) async {
    final audioSource = LockCachingAudioSource(Uri.parse(audio));
    await player.setAudioSource(audioSource);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final audio = phonetic.audio;
    final text = phonetic.text;
    final isAudioValid = audio?.isNotEmpty ?? false;
    final isTextValid = text?.isNotEmpty ?? false;

    return RichText(
      text: TextSpan(
        style: textTheme.bodyMedium?.copyWith(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
        children: [
          if (isTextValid) TextSpan(text: text!),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Visibility(
              visible: isAudioValid,
              replacement: const SizedBox(height: 24),
              child: GestureDetector(
                  onTap: () => _play(audio!),
                  child:
                      const Icon(Icons.volume_up_rounded, color: Colors.blue)),
            ),
          ),
          if (addComma) const TextSpan(text: ', ')
        ],
      ),
    );
  }
}
