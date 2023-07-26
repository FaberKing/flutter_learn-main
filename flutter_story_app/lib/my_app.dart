import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/data/model/flavor_config.dart';
import 'package:flutter_story_app/locale/locale_provider.dart';
import 'package:flutter_story_app/screen/error_page.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter_story_app/screen/map_location_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'common/localizations_call.dart';
import 'locale/localization_state_provider.dart';
import 'data/provider/router_listenable_provider.dart';
import 'screen/home_page.dart';
import 'screen/login_page.dart';
import 'screen/register_page.dart';
import 'screen/setting_page.dart';
import 'screen/splash_screen.dart';
import 'screen/story_detail_page.dart';
import 'screen/story_list_page.dart';
import 'widgets/add_story_page.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      var widgetsBinting = WidgetsBinding.instance;
      // ignore: unnecessary_null_comparison
      if (widgetsBinting != null) {
        widgetsBinting.addPostFrameCallback((_) async {
          ref.read(localizationStateProvider.notifier).initLocale();
        });
      }
      return;
    });

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
                        routes: [
                          GoRoute(
                            path: 'details_map',
                            name: 'details_map',
                            builder: (context, state) {
                              final result = state.extra as Map;
                              return MapLocationPage(
                                loc: result,
                                key: state.pageKey,
                              );
                            },
                          )
                        ],
                      ),
                      GoRoute(
                        path: 'add_story',
                        name: 'add_story',
                        builder: (context, state) {
                          return AddStoryPage(
                            key: state.pageKey,
                          );
                        },
                        routes: [
                          GoRoute(
                            path: 'map',
                            name: 'map',
                            builder: (context, state) {
                              return MapLocationPage(
                                key: state.pageKey,
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
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
        errorBuilder: (context, state) {
          return ErrorPage(error: state.error);
        },
      ),
      [listenRouter],
    );
    Locale locale = ref.watch(localeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: FlavorConfig.instance.values.titleApp,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: FlavorConfig.instance.color,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
        ),
        colorScheme:
            ColorScheme.fromSeed(seedColor: FlavorConfig.instance.color),
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: FlavorConfig.instance.color[100],
            selectedItemColor: FlavorConfig.instance.color),
      ),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
