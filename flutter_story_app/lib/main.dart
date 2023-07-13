import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/data/provider/shared_preference_provider.dart';
import 'package:flutter_story_app/utils/state_logger.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/localizations_call.dart';
import 'data/provider/localization_provider.dart';
import 'data/provider/router_listenable_provider.dart';
import 'screen/home_page.dart';
import 'screen/login_page.dart';
import 'screen/register_page.dart';
import 'screen/setting_page.dart';
import 'screen/splash_screen.dart';
import 'screen/story_detail_page.dart';
import 'screen/story_list_page.dart';
import 'widgets/add_story_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    observers: const [StateLogger()],
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localizationProvider);
    final listenRouter = ref.watch(routerListenableProvider.notifier);
    final rootNavigatorKey =
        useRef(GlobalKey<NavigatorState>(debugLabel: 'rootKey'));

    final router = useMemoized(
        () => GoRouter(
              navigatorKey: rootNavigatorKey.value,
              refreshListenable: listenRouter,
              initialLocation: '/splash',
              debugLogDiagnostics: true,
              routes: <RouteBase>[
                GoRoute(
                  path: '/splash',
                  name: 'splash',
                  builder: (context, state) {
                    return const SplashScreen();
                  },
                ),
                GoRoute(
                  path: '/register',
                  name: 'register',
                  builder: (context, state) {
                    return const RegisterPage();
                  },
                ),
                GoRoute(
                  path: '/login',
                  name: 'login',
                  builder: (context, state) {
                    return const LoginPage();
                  },
                ),
                StatefulShellRoute.indexedStack(
                  builder: (context, state, navigationShell) {
                    return HomePage(
                        key: state.pageKey, navigationShell: navigationShell);
                  },
                  branches: <StatefulShellBranch>[
                    StatefulShellBranch(
                      routes: <RouteBase>[
                        GoRoute(
                            path: '/story',
                            name: 'story',
                            builder: (context, state) {
                              return StoryListPage(key: state.pageKey);
                            },
                            routes: <RouteBase>[
                              GoRoute(
                                path: 'details/:sid',
                                name: 'details',
                                builder: (context, state) {
                                  return StoryDetailsPage(
                                      key: state.pageKey,
                                      id: state.pathParameters['sid']);
                                },
                              ),
                              GoRoute(
                                path: 'add_story',
                                name: 'add_story',
                                builder: (context, state) {
                                  return AddStoryPage(
                                    key: state.pageKey,
                                  );
                                },
                              )
                            ]),
                      ],
                    ),
                    StatefulShellBranch(
                      routes: <RouteBase>[
                        GoRoute(
                          path: '/setting',
                          name: 'setting',
                          builder: (context, state) {
                            return SettingPage(
                              key: state.pageKey,
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
              redirect: listenRouter.redirect,
            ),
        [listenRouter]);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'flutter story app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      locale: localeState,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
