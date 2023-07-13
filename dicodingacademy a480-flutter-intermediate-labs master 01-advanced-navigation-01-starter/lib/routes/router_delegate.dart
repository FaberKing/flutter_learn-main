import 'package:declarative_navigation/model/quote.dart';
import 'package:declarative_navigation/screen/form_screen.dart';
import 'package:declarative_navigation/screen/quote_detail_screen.dart';
import 'package:declarative_navigation/screen/quotes_list_screen.dart';
import 'package:flutter/material.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  String? selectedQuote;
  bool isForm = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: QuotesListScreen(
            quotes: quotes,
            onTapped: (String quotesId) {
              selectedQuote = quotesId;
              notifyListeners();
            },
            toFormScreen: () {
              isForm = true;
              notifyListeners();
            },
          ),
          key: const ValueKey('QuotesListScreen'),
        ),
        if (selectedQuote != null)
          MaterialPage(
            child: QuoteDetailsScreen(
              quoteId: selectedQuote!,
            ),
            key: ValueKey("QuoteDetailsPage-$selectedQuote"),
          ),
        if (isForm)
          MaterialPage(
            child: FormScreen(
              onSend: () {
                isForm = false;
                notifyListeners();
              },
            ),
            key: ValueKey("FormScreen"),
          ),
      ],
      onPopPage: (route, result) {
        final didPod = route.didPop(result);
        if (!didPod) {
          return false;
        }

        selectedQuote = null;
        isForm = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
