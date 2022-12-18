import 'package:dictionary/app.dart';
import 'package:dictionary/business/respository.dart';
import 'package:dictionary/config/configs.dart';
import 'package:dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter().then((value) async {
    await Hive.openBox<String>(AppConfigs.strings.recentsBox);
  });
  runApp(RepositoryProvider(
    create: (context) => DictionaryRepository.instance,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DictionaryBloc>(
      create: (context) => DictionaryBloc(context.read<DictionaryRepository>()),
      child: const Dictionary(),
    );
  }
}
