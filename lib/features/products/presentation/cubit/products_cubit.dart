// // import 'package:bloc/bloc.dart';
// // import 'package:fada_alhalij_web/core/common/api_result.dart';
// // import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
// // import 'package:fada_alhalij_web/features/products/domain/use_cases/products_use_case.dart';
// // import 'package:injectable/injectable.dart';
// // import 'package:meta/meta.dart';
// //
// // part 'products_state.dart';
// //
// // @injectable
// // class ProductsCubit extends Cubit<ProductsState> {
// //   ProductsCubit(this._productsUseCase) : super(ProductsInitial());
// //   final ProductsUseCase _productsUseCase;
// //
// //   Future<void> getProductsData({required String idCategory}) async {
// //     emit(ProductsLoading());
// //
// //     final result = await _productsUseCase.getHomeData(idCategory,1,3);
// //     switch (result) {
// //       case Success<GetProductsByCategoryEntity?>():
// //         {
// //           if (!isClosed) {
// //             emit(ProductsSuccess(result.data));
// //           }
// //         }
// //
// //       case Fail<GetProductsByCategoryEntity?>():
// //         {
// //           emit(ProductsFail(result.exception));
// //         }
// //     }
// //   }
// // }
//
// import 'package:bloc/bloc.dart';
// import 'package:fada_alhalij_web/core/common/api_result.dart';
//
// import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
// import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
// import 'package:fada_alhalij_web/features/products/domain/use_cases/products_use_case.dart';
// import 'package:injectable/injectable.dart';
// import 'package:meta/meta.dart';
//
// part 'products_state.dart';
//
// @injectable
// class ProductsCubit extends Cubit<ProductsState> {
//   ProductsCubit(this._productsUseCase) : super(ProductsInitial());
//   final ProductsUseCase _productsUseCase;
//
//   // متغيرات الـ pagination
//   int _currentPage = 1;
//   bool _hasMoreData = true;
//   bool _isLoadingMore = false;
//   List<ProductsRelations> _allProducts = [];
//   String? _currentCategoryId;
//
//   // Getters
//   bool get hasMoreData => _hasMoreData;
//   bool get isLoadingMore => _isLoadingMore;
//
//   Future<void> getProductsData({
//     required String idCategory,
//     bool isRefresh = false,
//   }) async {
//     // إذا كان refresh، نعيد تعيين كل شيء
//     if (isRefresh) {
//       _currentPage = 1;
//       _hasMoreData = true;
//       _allProducts = [];
//       _currentCategoryId = idCategory;
//     }
//
//     // إذا تغير الـ category، نعيد تعيين
//     if (_currentCategoryId != idCategory) {
//       _currentPage = 1;
//       _hasMoreData = true;
//       _allProducts = [];
//       _currentCategoryId = idCategory;
//     }
//
//     // إذا لا يوجد المزيد من البيانات، لا نفعل شيء
//     if (!_hasMoreData) return;
//
//     // إذا كانت الصفحة الأولى، نعرض loading
//     if (_currentPage == 1) {
//       emit(ProductsLoading());
//     }
//
//     final result = await _productsUseCase.getHomeData(
//       idCategory,
//       page: _currentPage,
//       limit: 8,
//     );
//
//     switch (result) {
//       case Success<GetProductsByCategoryEntity?>():
//         {
//           if (!isClosed) {
//             List<ProductsRelations> newProducts =
//                 result.data?.productsData?.productsRelations ?? [];
//
//             // إذا كانت القائمة فارغة أو أقل من الـ limit، لا يوجد المزيد
//             if (newProducts.isEmpty || newProducts.length < 20) {
//               _hasMoreData = false;
//             }
//
//             // إضافة المنتجات الجديدة للقائمة
//             _allProducts.addAll(newProducts);
//
//             // إنشاء entity جديد مع كل المنتجات
//             final updatedEntity = GetProductsByCategoryEntity(
//               productsData: ProductsData(
//                 status: result.data?.productsData?.status,
//                 productsRelations: _allProducts,
//               ),
//             );
//
//             emit(ProductsSuccess(
//               updatedEntity,
//               hasMoreData: _hasMoreData,
//             ));
//
//             _currentPage++;
//           }
//         }
//
//       case Fail<GetProductsByCategoryEntity?>():
//         {
//           // إذا فشل التحميل ولدينا منتجات موجودة، نحتفظ بها
//           if (_allProducts.isNotEmpty) {
//             final currentEntity = GetProductsByCategoryEntity(
//               productsData: ProductsData(
//                 status: null,
//                 productsRelations: _allProducts,
//               ),
//             );
//             emit(ProductsSuccess(currentEntity, hasMoreData: false));
//           } else {
//             emit(ProductsFail(result.exception));
//           }
//         }
//     }
//   }
//
//   // دالة لتحميل المزيد من المنتجات
//   Future<void> loadMoreProducts() async {
//     // منع التحميل المكرر
//     if (_isLoadingMore || !_hasMoreData || _currentCategoryId == null) return;
//
//     _isLoadingMore = true;
//     emit(ProductsLoadingMore(_allProducts)); // ← حالة تحميل إضافي
//
//     await getProductsData(idCategory: _currentCategoryId!);
//
//     _isLoadingMore = false;
//   }
//
//   // إعادة تعيين الـ pagination
//   void resetPagination() {
//     _currentPage = 1;
//     _hasMoreData = true;
//     _allProducts = [];
//     _currentCategoryId = null;
//   }
//
//   @override
//   Future<void> close() {
//     resetPagination();
//     return super.close();
//   }
// }


import 'package:bloc/bloc.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';

import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
import 'package:fada_alhalij_web/features/products/domain/entities/products_entities.dart';
import 'package:fada_alhalij_web/features/products/domain/use_cases/products_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

@injectable
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsUseCase) : super(ProductsInitial());
  final ProductsUseCase _productsUseCase;

  // Variables للـ pagination
  List<ProductsRelations> allProducts = [];
  int currentPage = 1;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  String? currentCategoryId;

  // تحميل الصفحة الأولى
  Future<void> getProductsData({required String idCategory}) async {
    // Reset pagination عند تغيير الفئة
    if (currentCategoryId != idCategory) {
      allProducts.clear();
      currentPage = 1;
      hasMoreData = true;
      currentCategoryId = idCategory;
    }

    emit(ProductsLoading());

    final result = await _productsUseCase.getHomeData(
      idCategory,
      page: currentPage,
      limit: 10,
    );

    switch (result) {
      case Success<GetProductsByCategoryEntity?>():
        {
          if (!isClosed) {
            final newProducts =
                result.data?.productsData?.productsRelations ?? [];

            allProducts = newProducts;

            // إذا كان عدد المنتجات أقل من limit، معناه لا يوجد المزيد
            if (newProducts.length < 10) {
              hasMoreData = false;
            }

            emit(ProductsSuccess(result.data, hasMore: hasMoreData));
          }
        }

      case Fail<GetProductsByCategoryEntity?>():
        {
          emit(ProductsFail(result.exception));
        }
    }
  }

  // تحميل المزيد من المنتجات
  Future<void> loadMoreProducts() async {
    if (!hasMoreData || isLoadingMore || currentCategoryId == null) return;

    isLoadingMore = true;
    currentPage++;

    final result = await _productsUseCase.getHomeData(
      currentCategoryId!,
      page: currentPage,
      limit: 10,
    );

    switch (result) {
      case Success<GetProductsByCategoryEntity?>():
        {
          if (!isClosed) {
            final newProducts =
                result.data?.productsData?.productsRelations ?? [];

            allProducts.addAll(newProducts);

            // إذا كان عدد المنتجات الجديدة أقل من limit
            if (newProducts.length < 10) {
              hasMoreData = false;
            }

            // إنشاء entity جديدة مع كل المنتجات
            final updatedEntity = GetProductsByCategoryEntity(
              productsData: ProductsData(
                status: result.data?.productsData?.status,
                productsRelations: allProducts,
              ),
            );

            emit(ProductsSuccess(updatedEntity, hasMore: hasMoreData));
          }
        }

      case Fail<GetProductsByCategoryEntity?>():
        {
          currentPage--; // إرجاع الصفحة في حالة الفشل
          emit(ProductsLoadMoreFail(result.exception));
        }
    }

    isLoadingMore = false;
  }

  // Reset pagination
  void resetPagination() {
    allProducts.clear();
    currentPage = 1;
    hasMoreData = true;
    currentCategoryId = null;
    isLoadingMore = false;
  }

  @override
  Future<void> close() {
    resetPagination();
    return super.close();
  }
}