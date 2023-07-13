import 'dart:async';

import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:dicoding_restaurant/data/model/restaurant.dart';
import 'package:dicoding_restaurant/data/model/restaurant_list.dart';
import 'package:dicoding_restaurant/data/model/restaurant_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fetch_restaurant_list_test.mocks.dart';

class FakeRestaurantNotifier extends AsyncNotifier<RestaurantList> {
  Future<RestaurantList> _getFakeRestaurantList() async =>
      RestaurantList(error: false, message: "success", count: 2, restaurants: [
        Restaurant(
            id: "rqdv5juczeskfw1e867",
            name: "Melting Pot",
            description:
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            pictureId: "14",
            city: "Medan",
            rating: 4.2),
        Restaurant(
            id: "s1knt6za9kkfw1e867",
            name: "Kafe Kita",
            description:
                "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            pictureId: "25",
            city: "Gorontalo",
            rating: 4)
      ]);

  @override
  FutureOr<RestaurantList> build() async {
    return _getFakeRestaurantList();
  }
}

final fakeRestaurantNotifier =
    AsyncNotifierProvider<FakeRestaurantNotifier, RestaurantList>(
        FakeRestaurantNotifier.new);

@GenerateMocks([http.Client])
void main() {
  group('fetch restaurant and restaurant list page widget test', () {
    test('returns a Restaurant if the http call completes successfully',
        () async {
      final ApiService apiService = ApiService();
      final client = MockClient();

      when(client.get(
        Uri.parse("https://restaurant-api.dicoding.dev/list"),
      )).thenAnswer((realInvocation) async => http.Response(
          '{"error": false,"message":"success","count": 1,"restaurants":[{"id":"rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId": "14","city": "Medan","rating":4.2}]}',
          200));

      expect(
          await apiService.fullRestaurantList(client), isA<RestaurantList>());
    });

    testWidgets('ListView test', (widgetTester) async {
      await widgetTester.pumpWidget(ProviderScope(child: MaterialApp(
        home: Scaffold(body: Consumer(
          builder: (context, ref, child) {
            final restaurants = ref.watch(fakeRestaurantNotifier);

            return restaurants.when(
              data: (data) {
                if (data.runtimeType == RestaurantList ||
                    data.runtimeType == RestaurantSearch) {
                  if (data.restaurants.isNotEmpty) {
                    return ListView.builder(
                      itemCount: data.restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = data.restaurants[index];
                        return Card(
                          child: ListTile(
                            title: Text(restaurant.name),
                          ),
                        );
                      },
                    );
                  } else if (data.restaurants.isEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  } else {
                    return const Text('Something is Wrong');
                  }
                } else {
                  return const Center(
                    child: Text('error'),
                  );
                }
              },
              error: (error, stackTrace) => Center(
                child: Text('error ===>$error'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            );
          },
        )),
      )));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);

      expect(find.byType(ListView), findsWidgets);
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      final ApiService apiService = ApiService();

      when(client.get(
        Uri.parse("https://restaurant-api.dicoding.dev/list"),
      )).thenAnswer((realInvocation) async => http.Response('Not Found', 404));

      expect(apiService.fullRestaurantList(client), throwsException);
    });
  });
}
