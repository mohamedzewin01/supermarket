import 'package:manarat_amjad/core/resources/assets_manager.dart';

class Constants {
  static const baseUrl = "https://api.example.com";
  static const List<String> orderStages = [
    'Pending',
    'Order Accepted',
    'Preparing',
    'Out for Delivery',
    'Delivered',
  ];
  static   int getCurrentStageIndex(String status) {
    switch (status) {
      case 'Pending':
        return 0;
      case 'Order Accepted':
        return 1;
      case 'Preparing':
        return 2;
      case 'Out for Delivery':
        return 3;
      case 'Delivered':
        return 4;
      default:
        return 0;
    }
  }
  static String getButtonLabel(String status) {
    switch (status) {
      case 'Pending':
        return 'بانتظار قبول الطلب';
      case 'Order Accepted':
        return 'بدء التحضير';
      case 'Preparing':
        return 'البدء من التوصيل';
      case 'Out for Delivery':
        return 'جاري التوصيل';
      case 'Delivered':
        return 'مكتمل';
      default:
        return 'غير معروف';
    }
  }

 static List<String> imageOrder = [
    Assets.orderSvg,
    Assets.orderConfirmedSvg,
    Assets.orderShippedSvg,
    Assets.orderOutForDeliverySvg,
    Assets.orderDeliverySvg,
  ];
}
