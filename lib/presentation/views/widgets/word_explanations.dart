import 'package:dictionary/models/word_description/meaning.dart';
import 'package:dictionary/utils/extensions/iterable.dart';
import 'package:flutter/material.dart';

class WordDefinition extends StatefulWidget {
  const WordDefinition({super.key, required this.meaning});
  final Meaning meaning;

  @override
  State<WordDefinition> createState() => _WordDefinitionState();
}

class _WordDefinitionState extends State<WordDefinition> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final definitions = widget.meaning.definitions ?? [];
    final hasMoreThanOne = definitions.length > 1;
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
              const TextSpan(text: 'DEFINITIONS '),
              if (hasMoreThanOne)
                TextSpan(
                  text: '${definitions.length}',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                )
            ],
          ),
        ),
        DefinitionText(
          textTheme: textTheme,
          e: definitions.first.definition ?? '',
          i: -1,
          hasMoreThanOne: hasMoreThanOne,
        ),
        if (hasMoreThanOne && expanded)
          ...definitions.sublist(1).mapIndexed(
                (e, i) => DefinitionText(
                  textTheme: textTheme,
                  i: i,
                  e: e.definition ?? '',
                  hasMoreThanOne: hasMoreThanOne,
                ),
              ),
        if (hasMoreThanOne)
          GestureDetector(
            child: const Text('...', style: TextStyle(fontSize: 24)),
            onTap: () => setState(() => expanded = !expanded),
          ),
      ],
    );
  }
}

class DefinitionText extends StatelessWidget {
  const DefinitionText({
    Key? key,
    required this.textTheme,
    required this.i,
    required this.e,
    this.hasMoreThanOne = false,
  }) : super(key: key);

  final TextTheme textTheme;
  final int i;
  final String e;
  final bool hasMoreThanOne;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w400,
          ),
          children: [
            if (hasMoreThanOne)
              TextSpan(
                text: '${i + 2}. ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            TextSpan(text: e),
          ],
        ),
      ),
    );
  }
}
