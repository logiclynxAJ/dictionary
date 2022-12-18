import 'package:dictionary/presentation/views/home.dart';
import 'package:dictionary/presentation/views/search.dart';
import 'package:go_router/go_router.dart';

part 'router.dart';
part 'strings.dart';

class AppConfigs {
  static GoRouter get router => routerConfig;
  static AppStrings strings = AppStrings();
}
