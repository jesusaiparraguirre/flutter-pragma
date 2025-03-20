import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pragma_test/models/responses/breed_response.dart';
import 'package:pragma_test/ui/screens/detail_screen.dart';
import 'package:pragma_test/utils/extensions/color_extension.dart';

typedef SearchBreedCallback = Future<BreedResponse> Function(String query);
typedef GetBreedsCallback = Future<List<BreedResponse>> Function();

class SearchBreedDelegate extends SearchDelegate<BreedResponse?> {
  final SearchBreedCallback searchBreed;
  final GetBreedsCallback getBreeds;
  final List<BreedResponse> initialBreeds;
  
  final StreamController<BreedResponse?> debouncedBreed = StreamController.broadcast();
  final StreamController<bool> isLoadingStream = StreamController.broadcast();
  final StreamController<List<BreedResponse>> debouncedBreeds = StreamController.broadcast();
  final StreamController<String?> errorStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchBreedDelegate({
  required this.searchBreed,
  required this.getBreeds,
  required this.initialBreeds,
}) : super(
  searchFieldLabel: 'Buscar razas por codigo',
);

  void clearStreams() {
    debouncedBreeds.close();
    isLoadingStream.close();
    errorStream.close();
  }

  void _onQueryChanged(String query) {
    if (query.isEmpty) return;

    isLoadingStream.add(true);
    errorStream.add(null);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        final breed = await searchBreed(query);
        debouncedBreeds.add([breed]);
        errorStream.add(null);
      } catch (e) {
        debouncedBreeds.add([]);
        errorStream.add('Error al buscar la raza');
      }
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder<List<BreedResponse>>(
      initialData: initialBreeds,
      stream: debouncedBreeds.stream,
      builder: (context, snapshot) {
        final data = snapshot.data;

        return StreamBuilder<String?>(
          stream: errorStream.stream,
          builder: (context, errorSnapshot) {
            final errorMessage = errorSnapshot.data;

            if (errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
                    const SizedBox(height: 10),
                    Text(errorMessage, style: const TextStyle(color: Colors.red)),
                  ],
                ),
              );
            }

            if (isLoadingStream.hasListener && (data == null || data.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (data == null || data.isEmpty) {
              return const Center(child: Text('No se encontraron razas.'));
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final breed = data[index];
                return _BreedItem(
                  breed: breed,
                  onBreedSelected: (context, selectedBreed) {
                    clearStreams();
                    close(context, selectedBreed);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () async {
                query = '';
                isLoadingStream.add(true);
                final breeds = await getBreeds();
                debouncedBreeds.add(breeds);
                isLoadingStream.add(false);
              },
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: AppColor.scaffoldBGColor,
      child: buildResultsAndSuggestions()
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return Container(
      color: AppColor.scaffoldBGColor,
      child: buildResultsAndSuggestions()
    );
  }
}

class _BreedItem extends StatelessWidget {
  final BreedResponse breed;
  final Function(BuildContext, BreedResponse) onBreedSelected;

  const _BreedItem({
    required this.breed,
    required this.onBreedSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onBreedSelected(context, breed);

        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                breed: breed,
              ),
            ),
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: 'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg',
                httpHeaders: {
                  'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'
                },
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.error, size: 30),
                ),
              ),
            ),
            const SizedBox(width: 10),

            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(breed.id, style: textStyles.titleMedium),
                  Text(
                    breed.origin,
                    style: textStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}