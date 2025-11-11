import 'package:manarat_amjad/features/search/data/models/response/search_dto.dart';

class SearchEntity {
  final bool? status;

  final String? message;

  final int? totalCount;

  final int? page;

  final int? limit;

  final List<DataSearch>? data;

  SearchEntity({
    this.status,
    this.message,
    this.totalCount,
    this.page,
    this.limit,
    this.data,
  });
}
