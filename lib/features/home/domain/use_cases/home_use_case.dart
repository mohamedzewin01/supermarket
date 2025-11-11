import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/home/domain/entities/home_entities.dart';
import 'package:manarat_amjad/features/home/domain/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeUseCase {
  HomeRepo homeRepo;

  HomeUseCase(this.homeRepo);

  Future<Result<HomeEntity?>> getHomeData() {
    return homeRepo.getHomeData();
  }
}
