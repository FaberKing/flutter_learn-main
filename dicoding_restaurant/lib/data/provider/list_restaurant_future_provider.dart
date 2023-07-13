import 'package:dicoding_restaurant/data/api/api_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDataProvider = FutureProvider<dynamic>((ref) async {
  ApiService apiService = ApiService();

  // ref.watch(restaurantListFullProvider.notifier).allRestaurantList();

  // return ref.watch(restaurantListFullProvider.notifier).result.restaurants;

  // final state = ref.watch(restaurantListFullProvider.notifier);
  // try {
  // final restaurant = ref.watch(listProvider).fullRestaurantList();
  final restaurant = await apiService.fullRestaurantList();

  return restaurant;
  // } on SocketException catch (_) {
  //   return state.errorMessage('No Internet Conntection');
  // } catch (e) {
  //   return state.errorMessage(e.toString());
  // }
  // return ref.watch(listProvider).fullRestaurantList();
});
