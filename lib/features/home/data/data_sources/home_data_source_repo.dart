import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/home/domain/entities/home_entities.dart';

abstract class HomeDataSourceRepo {
  Future<Result<HomeEntity?>> getHomeData();
}
