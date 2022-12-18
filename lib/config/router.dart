part of 'configs.dart';

final routerConfig = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/home',
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/search/:query',
      builder: (context, state) =>
          SearchResultPage(query: state.params['query']!),
    ),
  ],
);
