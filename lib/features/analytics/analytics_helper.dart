import 'dart:convert';
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:fada_alhalij_web/core/api/api_extentions.dart';
import 'package:fada_alhalij_web/core/api/api_manager/api_manager.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import '../../core/api/dio_provider.dart';
import 'model/device_response.dart';

class WebDeviceInfoHelper {
  static String getDeviceName() {
    // جلب معلومات المتصفح (userAgent)
    final userAgent = "Android Device";
        html.window.navigator.userAgent;

    if (userAgent.contains("Windows")) {
      return "Windows Device";
    } else if (userAgent.contains("Mac")) {
      return "Mac Device";
    } else if (userAgent.contains("iPhone")) {
      return "iPhone";
    } else if (userAgent.contains("Android")) {
      return "Android Device";
    } else if (userAgent.contains("Linux")) {
      return "Linux Device";
    } else {
      return "Unknown Device";
    }
  }

  static String getDeviceId() {
    // جلب sessionId كمثال (غير فريد لكنه ثابت خلال الجلسة)
    return
      html.window.sessionStorage['deviceId'] ??
        (html.window.sessionStorage['deviceId'] = _generateRandomId());
  }

  static String _generateRandomId() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return
      "web-${html.window.navigator.userAgent.hashCode}";
  }
}

Future<void> getAndSaveDeviceInfo() async {
  //print("إستدعاء getAndSaveDeviceInfo"); // سجل بداية الاستدعاء

  final deviceName = WebDeviceInfoHelper.getDeviceName();
  final deviceId = WebDeviceInfoHelper.getDeviceId();

  //print("deviceId: $deviceId, deviceName: $deviceName");

  await CacheService.setData(key: CacheKeys.deviceId, value: deviceId);
  await CacheService.setData(key: CacheKeys.deviceName, value: deviceName);
  await sendDeviceData(deviceId: deviceId, deviceName: deviceName);
}

Future<Result<DeviceResponse>> sendDeviceData({required String deviceId, required String deviceName}) async {
   Dio dio = dioProvider();
  final client =ApiService(dio);



    return executeApi(() async {
      final response = await client.addDevice(deviceId, deviceName);
  await CacheService.setData(key: CacheKeys.id, value: response.device?.id);
      return response;
    });

}





class AnalyticsHelper {
  static final Dio _dio = dioProvider();
  static Future<void> sendAnalytics() async {
    await getAndSaveDeviceInfo();
  }
  static Future<void> sendProductVisit({required int productId}) async {

    final client =ApiService(_dio);

    final cachedDeviceId = await CacheService.getData(key: CacheKeys.id);

    try {
      final response = await client.addProductVisit(cachedDeviceId, productId);

      if (response.response.statusCode == 200) {
        print(jsonEncode(response.data));
      } else {
        print(response.response.statusMessage);
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}