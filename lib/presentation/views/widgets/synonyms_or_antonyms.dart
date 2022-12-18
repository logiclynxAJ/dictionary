import 'package:dictionary/business/event.dart';
import 'package:dictionary/models/word_description/meaning.dart';
import 'package:dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Synonyms extends StatelessWidget {
  const Synonyms({super.key, required this.meaning});
  final Meaning meaning;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final definitions = meaning.definitions ?? [];
    final synonyms = [
      ...(meaning.synonyms ?? []),
      ...definitions
          .map((e) => e.synonyms ?? [])
          .reduce((value, element) => [...value, ...element])
          .toList()
    ];
    final hasMoreThanTwo = synonyms.length > 2;
    return SynonymOrAntonym(
      textTheme: textTheme,
      hasMoreThanTwo: hasMoreThanTwo,
      list: synonyms,
      title: 'SYNONYMS',
    );
  }
}

class Antonyms extends StatelessWidget {
  const Antonyms({super.key, required this.meaning});
  final Meaning meaning;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final definitions = meaning.definitions ?? [];
    final antonyms = [
      ...(meaning.antonyms ?? []),
      ...definitions
          .map((e) => e.antonyms ?? [])
          .reduce((value, element) => [...value, ...element])
          .toList()
    ];
    final hasMoreThanTwo = antonyms.length > 2;
    return SynonymOrAntonym(
      textTheme: textTheme,
      hasMoreThanTwo: hasMoreThanTwo,
      list: antonyms,
      title: 'ANTONYMS',
    );
  }
}

class SynonymOrAntonym extends StatefulWidget {
  const SynonymOrAntonym({
    Key? key,
    required this.textTheme,
    required this.hasMoreThanTwo,
    required this.list,
    required this.title,
  }) : super(key: key);

  final TextTheme textTheme;
  final bool hasMoreThanTwo;
  final List list;
  final String title;

  @override
  State<SynonymOrAntonym> createState() => _SynonymOrAntonymState();
}

class _SynonymOrAntonymState extends State<SynonymOrAntonym> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    int? length = expanded
        ? null
        : widget.list.length > 5
            ? 5
            : widget.list.length;
    int nonNullLength = length ?? 0;
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: widget.textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
              children: [
                TextSpan(text: '${widget.title} '),
                if (widget.hasMoreThanTwo)
                  TextSpan(
                    text: '${widget.list.length}',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  )
              ],
            ),
          ),
          if (widget.list.isEmpty) ...[
            Text(
              'No Data',
              style: widget.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            )
          ],
          if (widget.list.isNotEmpty)
            ...widget.list.sublist(0, length).map((e) => GestureDetector(
                  onTap: () {
                    context.read<DictionaryBloc>().add(GetWordDescription(e));
                    context.replace('/search/$e');
                  },
                  child: Text(
                    e,
                    style: widget.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ),
                )),
          if (nonNullLength > 5)
            GestureDetector(
              child: const Text('...', style: TextStyle(fontSize: 24)),
              onTap: () => setState(() => expanded = !expanded),
            ),
        ],
      ),
    );
  }
}
