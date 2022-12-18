import 'package:dictionary/business/event.dart';
import 'package:dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              primary: true,
              expandedHeight: 300,
              collapsedHeight: 100,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dictionary',
                      style: theme.headline4?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CupertinoSearchTextField(
                      placeholder: 'Search here',
                      onSubmitted: (value) {
                        context
                            .read<DictionaryBloc>()
                            .add(GetWordDescription(value));
                        context.push('/search/$value');
                      },
                    ),
                  ],
                ),
                expandedTitleScale: 1.25,
                centerTitle: false,
                titlePadding:
                    const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: constraints.maxHeight - 300,
                  width: constraints.maxWidth * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent',
                        style: theme.headline4?.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable:
                              context.read<DictionaryBloc>().recentsStream,
                          builder: (context, value, _) {
                            final setValues =
                                value.values.toSet().toList().reversed.toList();
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: setValues.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (c, i) => ListTile(
                                onTap: () {
                                  context
                                      .read<DictionaryBloc>()
                                      .add(GetWordDescription(setValues[i]));
                                  context.push('/search/${setValues[i]}');
                                },
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  setValues[i],
                                  style: theme.headline5
                                      ?.copyWith(color: Colors.black87),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
