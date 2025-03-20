
import 'package:pragma_test/models/responses/breed_response.dart';

abstract class BreedRepository {

  Future<List<BreedResponse>> getBreeds();

  Future<BreedResponse> searchBreed(String breed);
  
}