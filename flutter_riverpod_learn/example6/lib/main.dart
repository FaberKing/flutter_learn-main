import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavotire;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavotire,
  });

  Film copy({required bool isFavotire}) => Film(
        id: id,
        title: title,
        description: description,
        isFavotire: isFavotire,
      );

  @override
  String toString() => 'Film(id: $id, '
      'title: $title, '
      'description: $description, '
      'isFavotire: $isFavotire,)';

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavotire == other.isFavotire;

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll(
        [
          id,
          isFavotire,
        ],
      );
}

const allFilms = [
  Film(
      id: '1',
      title: 'The tai besarr',
      description: 'Description all dasdj oasji',
      isFavotire: false),
  Film(
      id: '2',
      title: 'The tai kanada',
      description: 'Description all dasdj oasji',
      isFavotire: false),
  Film(
      id: '3',
      title: 'The tai alaska',
      description: 'Description all dasdj oasji',
      isFavotire: false),
  Film(
      id: '4',
      title: 'djaisdjias',
      description: 'Description all dasdj oasji',
      isFavotire: false),
  Film(
      id: '5',
      title: 'The tai besarr wawaw',
      description: 'Description all dasdj oasji',
      isFavotire: false),
];

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(allFilms);

  void update(Film film, bool isFavorite) {
    state = state
        .map((e) => e.id == film.id
            ? e.copy(
                isFavotire: isFavorite,
              )
            : e)
        .toList();
  }
}

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

enum FavotireStatus {
  all,
  favorite,
  notFavotire,
}

final favoriteStatusProvider = StateProvider<FavotireStatus>(
  (ref) => FavotireStatus.all,
);

final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>(
  (ref) => FilmsNotifier(),
);

final favoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => film.isFavotire,
      ),
);

final notFavoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => !film.isFavotire,
      ),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Films',
        ),
      ),
      body: Column(
        children: [
          const Filter(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusProvider);
              switch (filter) {
                case FavotireStatus.all:
                  return FilmsList(
                    provider: allFilmsProvider,
                  );
                case FavotireStatus.favorite:
                  return FilmsList(
                    provider: favoriteFilmsProvider,
                  );
                case FavotireStatus.notFavotire:
                  return FilmsList(
                    provider: notFavoriteFilmsProvider,
                  );
              }
            },
          )
        ],
      ),
    );
  }
}

class FilmsList extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsList({required this.provider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
        child: ListView.builder(
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films.elementAt(index);
        final favoriteIcon = film.isFavotire
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border);
        return ListTile(
          title: Text(film.title),
          subtitle: Text(film.description),
          trailing: IconButton(
            icon: favoriteIcon,
            onPressed: () {
              final isFavorite = !film.isFavotire;
              ref.read(allFilmsProvider.notifier).update(
                    film,
                    isFavorite,
                  );
            },
          ),
        );
      },
    ));
  }
}

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavotireStatus.values
              .map(
                (fs) => DropdownMenuItem(
                  value: fs,
                  child: Text(
                    fs.toString().split('.').last,
                  ),
                ),
              )
              .toList(),
          onChanged: (FavotireStatus? fs) {
            ref
                .read(
                  favoriteStatusProvider.notifier,
                )
                .state = fs!;
          },
        );
      },
    );
  }
}
