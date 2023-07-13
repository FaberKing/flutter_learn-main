import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomePage(),
    );
  }
}

enum City {
  stockholm,
  paris,
  tokyo,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.stockholm: 'snow',
      City.paris: 'rain',
      City.tokyo: 'wind',
    }[city]!,
  );
}

// will be changed by the UI / UI writes to this and read from this
final currentCityProvider = StateProvider<City?>(
  (ref) {
    return null;
  },
);

// Listen change on above provider and change its value to current value / UI reads this

const unknownWeatherEmoji = '??';

final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) async {
    final city = ref.watch(currentCityProvider);

    if (city != null) {
      return getWeather(city);
    } else {
      return unknownWeatherEmoji;
    }
  },
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(
      weatherProvider,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
        ),
      ),
      body: Column(children: [
        currentWeather.when(
          data: (data) {
            return Text(
              data,
              style: const TextStyle(
                fontSize: 40,
              ),
            );
          },
          error: (error, stackTrace) => const Text('Error ??'),
          loading: () => const Padding(
              padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            final city = City.values[index];
            final isSelected = city == ref.watch(currentCityProvider);

            return ListTile(
              title: Text(city.toString()),
              // change the state to given city in currentCityProvider
              onTap: () => ref
                  .read(
                    currentCityProvider.notifier,
                  )
                  .state = city,
              trailing: isSelected
                  ? const Icon(
                      Icons.check,
                    )
                  : null,
            );
          },
          itemCount: City.values.length,
        ))
      ]),
    );
  }
}
