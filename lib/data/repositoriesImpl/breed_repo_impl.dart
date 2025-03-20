
import 'package:pragma_test/data/repositories/breed_repo.dart';
import 'package:pragma_test/models/responses/breed_response.dart';
import 'package:dio/dio.dart';

class BreedRepositoryImpl extends BreedRepository {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.thecatapi.com/v1',
    queryParameters: {
      'api_key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'
    }
  ));

  List<BreedResponse> _jsonToBreeds(List<dynamic> jsonList) {
    return jsonList.map((e) => BreedResponse.fromJson(e)).toList();
  }

  BreedResponse _jsonToBreed(dynamic json) {
    return BreedResponse.fromJson(json);
  }
  
  @override
  Future<List<BreedResponse>> getBreeds() async {
  final response = await dio.get('/breeds');
  final allBreeds = _jsonToBreeds(response.data);
  final limitedBreeds = allBreeds.take(20).toList();
  return limitedBreeds;
}

  @override
  Future<BreedResponse> searchBreed(String breed) async {
    if (breed.isEmpty) throw Exception('Empty breed');
    final response = await dio.get('/breeds/$breed');
    final searchedBreed = _jsonToBreed(response.data);
    return searchedBreed;
  }

}