// // part of 'products_cubit.dart';
// //
// // @immutable
// // sealed class ProductsState {}
// //
// // final class ProductsInitial extends ProductsState {}
// //
// // final class ProductsLoading extends ProductsState {}
// //
// // final class ProductsSuccess extends ProductsState {
// //   final GetProductsByCategoryEntity? productsModelEntity;
// //
// //   ProductsSuccess(this.productsModelEntity);
// // }
// //
// // final class ProductsFail extends ProductsState {
// //   final Exception exception;
// //
// //   ProductsFail(this.exception);
// // }
//
// part of 'products_cubit.dart';
//
// @immutable
// sealed class ProductsState {}
//
// final class ProductsInitial extends ProductsState {}
//
// final class ProductsLoading extends ProductsState {}
//
// final class ProductsSuccess extends ProductsState {
//   final GetProductsByCategoryEntity? productsModelEntity;
//   final bool hasMoreData;
//
//   ProductsSuccess(this.productsModelEntity, {this.hasMoreData = true});
// }
//
// // حالة جديدة عند تحميل المزيد من المنتجات
// final class ProductsLoadingMore extends ProductsState {
//   final List<ProductsRelations> currentProducts;
//
//   ProductsLoadingMore(this.currentProducts);
// }
//
// final class ProductsFail extends ProductsState {
//   final Exception exception;
//
//   ProductsFail(this.exception);
// }

part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final GetProductsByCategoryEntity? productsModelEntity;
  final bool hasMore;

  ProductsSuccess(this.productsModelEntity, {this.hasMore = true});
}

final class ProductsFail extends ProductsState {
  final Exception exception;

  ProductsFail(this.exception);
}

// State جديد لأخطاء تحميل المزيد
final class ProductsLoadMoreFail extends ProductsState {
  final Exception exception;

  ProductsLoadMoreFail(this.exception);
}