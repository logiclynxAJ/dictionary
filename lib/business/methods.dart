import 'dart:async';

import 'package:dictionary/models/word_description/word_description.dart';

abstract class DictionaryMethods {
  FutureOr<WordDescriptions> getWordDescription(String word);
}
