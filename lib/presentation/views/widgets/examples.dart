import 'package:dictionary/models/word_description/meaning.dart';
import 'package:flutter/material.dart';
import 'package:dictionary/utils/extensions/iterable.dart';

import 'word_explanations.dart';

class Examples extends StatefulWidget {
  const Examples({super.key, required this.meaning});
  final Meaning meaning;

  @override
  State<Examples> createState() => _ExamplesState();
}

class _ExamplesState extends State<Examples> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final definitions = widget.meaning.definitions ?? [];
    final meanings = definitions
        .map((e) => e.example)
        .where((e) => e != null && e.isNotEmpty)
        .toList();
    if (meanings.isEmpty) return const SizedBox.shrink();
    final hasMoreThanTwo = meanings.length > 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            children: [
              const TextSpan(text: 'EXAMPLES '),
              if (hasMoreThanTwo)
                TextSpan(
                  text: '${definitions.length}',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                )
            ],
          ),
        ),
        ...meanings
            .sublist(0, hasMoreThanTwo ? 1 : 1)
            .mapIndexed((e, i) => DefinitionText(
                  textTheme: textTheme,
                  i: i - 1,
                  e: e ?? '',
                  hasMoreThanOne: hasMoreThanTwo,
                )),
        if (hasMoreThanTwo && expanded)
          ...meanings.sublist(1).mapIndexed(
                (e, i) => DefinitionText(
                  textTheme: textTheme,
                  i: i + 1,
                  e: e ?? '',
                  hasMoreThanOne: hasMoreThanTwo,
                ),
              ),
        if (hasMoreThanTwo)
          GestureDetector(
            child: const Text('...', style: TextStyle(fontSize: 24)),
            onTap: () => setState(() => expanded = !expanded),
          ),
      ],
    );
  }
}
