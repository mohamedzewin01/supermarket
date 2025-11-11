import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/home/data/data_sources/home_data_source_repo.dart';
import 'package:manarat_amjad/features/home/domain/entities/home_entities.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/home_repo.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  HomeDataSourceRepo homeDataSourceRepo;

  HomeRepoImpl(this.homeDataSourceRepo);

  @override
  Future<Result<HomeEntity?>> getHomeData() {
    return homeDataSourceRepo.getHomeData();
  }
}
