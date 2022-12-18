import 'dart:developer';

import 'package:dictionary/business/event.dart';
import 'package:dictionary/business/state.dart';
import 'package:dictionary/models/word_description/meaning.dart';
import 'package:dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:dictionary/presentation/views/widgets/word_explanations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dictionary/utils/extensions/iterable.dart';
import 'package:just_audio/just_audio.dart';

import 'widgets/appbar.dart';
import 'widgets/error.dart';
import 'widgets/examples.dart';
import 'widgets/loader.dart';
import 'widgets/phonetic_text_or_audio.dart';
import 'widgets/synonyms_or_antonyms.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({
    Key? key,
    required this.query,
  }) : super(key: key);
  final String query;
  final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<DictionaryBloc, DictionaryState>(
      builder: (context, state) {
        final hasError = state.isError(query);
        final isLoading = state.isLoading(query);
        final description = state.getDescription(query);
        final words = description.map((e) => e.word!);
        final selectedOption = state.getSelectedWord(query);
        void increment() {
          context.read<DictionaryBloc>().add(UpdateSelectedWord(
                query,
                UpdateType.increment,
              ));
        }

        void decrement() {
          context.read<DictionaryBloc>().add(UpdateSelectedWord(
                query,
                UpdateType.decrement,
              ));
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: getAppBar(
            context,
            textTheme,
            actions: description.isNotEmpty && words.length > 1
                ? [
                    Row(
                      children: [
                        IconButton(
                          onPressed: selectedOption == 0 ? null : decrement,
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                        IconButton(
                          onPressed: (selectedOption == words.length - 1)
                              ? null
                              : increment,
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    )
                  ]
                : null,
          ),
          body: Visibility(
            visible: !hasError && !isLoading,
            replacement: hasError ? const ErrorPage() : const Loader(),
            child: Builder(builder: (context) {
              final phonetics = description[selectedOption].phonetics ?? [];

              phonetics.sort();

              final List<Meaning> allMeanings = (description.isNotEmpty
                  ? description[selectedOption].meanings ?? []
                  : []);
              final allPartOfSpeech =
                  allMeanings.map((e) => e.partOfSpeech ?? '').toList();
              allPartOfSpeech.sort();
              final selectedValue =
                  state.getSelectedSpeechValue(query, allPartOfSpeech.first);

              final entries = {
                for (final v in allPartOfSpeech)
                  v: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      v,
                      style: textTheme.bodyMedium?.copyWith(
                        color: selectedValue == v ? Colors.white : Colors.blue,
                      ),
                    ),
                  )
              };

              return SingleChildScrollView(
                child: DefaultTextStyle(
                  style: textTheme.headline3!.copyWith(color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(query),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: phonetics
                              .mapIndexed((e, i) => PhoneticTextOrAudio(
                                    phonetic: e,
                                    addComma: i != phonetics.length - 1,
                                    player: player,
                                  ))
                              .toList(),
                        ),
                        if (entries.length >= 2) ...[
                          const SizedBox(height: 48),
                          CupertinoSegmentedControl<String>(
                            groupValue: selectedValue,
                            children: entries,
                            onValueChanged: (value) {
                              context
                                  .read<DictionaryBloc>()
                                  .add(UpdateSeletedOption(query, value));
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ],
                        const SizedBox(height: 36),
                        WordDefinition(
                          meaning: allMeanings.lastWhere(
                              (e) => e.partOfSpeech == selectedValue),
                        ),
                        const SizedBox(height: 36),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Synonyms(
                              meaning: allMeanings.lastWhere(
                                  (e) => e.partOfSpeech == selectedValue),
                            )),
                            Expanded(
                                child: Antonyms(
                              meaning: allMeanings.lastWhere(
                                  (e) => e.partOfSpeech == selectedValue),
                            )),
                          ],
                        ),
                        const SizedBox(height: 36),
                        Examples(
                          meaning: allMeanings.lastWhere(
                              (e) => e.partOfSpeech == selectedValue),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
