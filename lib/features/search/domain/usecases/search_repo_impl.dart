
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/core/uses_cases/search/search_use_case_repo.dart';
import 'package:manarat_amjad/features/search/data/models/request/search_request.dart';
import 'package:manarat_amjad/features/search/domain/entities/search_entity.dart';
import 'package:manarat_amjad/features/search/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: SearchUseCaseRepo)
class SearchUseCase implements SearchUseCaseRepo{
  final SearchRepository _repository;
  SearchUseCase(this._repository);
  @override
  Future<Result<SearchEntity?>> search(SearchRequest searchRequest) {
 return _repository.search(searchRequest);
  }

}