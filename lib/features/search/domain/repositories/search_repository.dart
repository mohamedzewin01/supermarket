import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/search/data/models/request/search_request.dart';
import 'package:manarat_amjad/features/search/domain/entities/search_entity.dart';

abstract class SearchRepository {
  Future<Result<SearchEntity?>> search(SearchRequest searchRequest);
}
