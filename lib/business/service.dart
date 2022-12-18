import 'dart:async';

import 'package:dictionary/models/word_description/word_description.dart';
import 'package:dio/dio.dart';

import 'methods.dart';

class DictionaryService implements DictionaryMethods {
  DictionaryService._internal();
  static final DictionaryService instance = DictionaryService._internal();

  final String baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';
  final Dio _dio = Dio();

  @override
  FutureOr<WordDescriptions> getWordDescription(String word) async {
    final response = await _dio.get<List>(baseUrl + word);
    return response.data?.map((e) => WordDescription.fromJson(e)).toList() ??
        [];
  }
}
