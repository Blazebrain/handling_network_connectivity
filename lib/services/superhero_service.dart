import '../app/app.locator.dart';
import '../models/superhero_response_model.dart';
import '../utils/api_constant.dart';
import 'api_service.dart';

class SuperheroService {
  final _apiService = locator<ApiService>();

  Future<SuperheroResponseModel?> getCharactersDetails() async {
    try {
      final response = await _apiService.get(ApiConstants.getSuperhero);

      if (response != null) {
        final superheroData = SuperheroResponseModel.fromJson(response);

        return superheroData;
      }
    } catch (e) {
      rethrow;
    }
  }
}
