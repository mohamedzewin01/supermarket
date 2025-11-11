import 'package:bloc/bloc.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/core/functions/extenstions.dart';
import 'package:manarat_amjad/core/uses_cases/search/search_use_case_repo.dart';

import 'package:manarat_amjad/features/search/data/models/request/search_request.dart';
import 'package:manarat_amjad/features/search/data/models/response/search_dto.dart';
import 'package:manarat_amjad/features/search/domain/entities/search_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

@injectable
// class SearchCubit extends Cubit<SearchState> {
//   SearchCubit(this._searchUseCaseRepo) : super(SearchInitial());
//
//   final SearchUseCaseRepo _searchUseCaseRepo;
//
//   static SearchCubit get(context) => BlocProvider.of(context);
//
//   int? selectedIndex;
//   TextEditingController searchController = TextEditingController();
//   List<DataSearch> productsSuggested = [];
//   int currentPage = 1;
//   bool isLoadingMore = false;
//
//
//   Future<void> searchProducts({
//     categoryId,
//     minPrice,
//     maxPrice,
//     sortBy,
//     order,
//     limit,
//     search
//
//   }) async {
//     var result = await _searchUseCaseRepo.search(
//       SearchRequest(
//         limit: limit,
//         search: search,
//         minPrice: minPrice,
//         maxPrice: maxPrice,
//         sortBy: sortBy,
//         order: order,
//         categoryId: categoryId,
//         pagination: true
//       ),
//     );
//     switch (result) {
//       case Success<SearchEntity?>():
//         {
//           if (!isClosed) {
//             productsSuggested.clear();
//             productsSuggested.addAll(result.data!.data!);
//             emit(SearchSuccess(result.data!));
//           }
//         }
//
//       case Fail<SearchEntity?>():
//         {
//           emit(SearchFailure(result.exception));
//         }
//     }
//   }
//
//
// }
@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._searchUseCaseRepo) : super(SearchInitial());

  final SearchUseCaseRepo _searchUseCaseRepo;

  static SearchCubit get(context) => BlocProvider.of(context);

  int currentPage = 1;

  int? minPrice;
  int? maxPrice;
  String? sortBy ;
  String order = "desc";



  bool isLoadingMore = false;
  List<DataSearch> allProducts = [];
  String? lastSearchText;
  int? selectedIndex;
  TextEditingController searchController = TextEditingController();
  List<DataSearch> productsSuggested = [];

  Future<void> searchProducts({
    String? search,
    int? categoryId,
    int page = 1,




    int limit = 10,
    bool isLoadMore = false,
  }) async {
    if (isLoadingMore) {
      print("تحميل جاري بالفعل، تجاهل الطلب الجديد");
      return;
    }

    if (!isLoadMore) {
      currentPage = 1;
      allProducts.clear();
      lastSearchText = search;
      emit(SearchLoading());
    } else {
      currentPage++;
      isLoadingMore = true;
      print("تحميل صفحة جديدة: $currentPage");
    }

    var result = await _searchUseCaseRepo.search(
      SearchRequest(
        limit: limit,
        search: lastSearchText,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortBy: sortBy,
        order: order,
        categoryId: categoryId,
        pagination: true,
        page: currentPage,
      ),
    );
    if (result is Success<SearchEntity?>) {
      if (!isClosed) {
        allProducts.addAll(result.data!.data!);
        productsSuggested.clear();
        productsSuggested.addAll(result.data!.data!);
        emit(SearchSuccess(SearchEntity(data: allProducts)));
      }
      isLoadingMore = false;
    } else if (result is Fail<SearchEntity?>) {
      isLoadingMore = false;
      emit(SearchFailure(result.exception));
    }
  }

  Future<void> loadNextPage() async {
    await searchProducts(search: lastSearchText, isLoadMore: true);
  }
}
