import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/search/data/models/request/search_request.dart';
import 'package:manarat_amjad/features/search/domain/entities/search_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_data_source.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<SearchEntity?>> search(SearchRequest searchRequest) {
    return remoteDataSource.search(searchRequest);
  }
}
