import 'package:manarat_amjad/features/address/presentation/blocs/my_address/address_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator_web/geolocator_web.dart';
// Future<void> getLocation(AddressCubit viewModel) async {
//   if (kIsWeb) {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       viewModel.latController.text = position.latitude.toString();
//       viewModel. longController.text = position.longitude.toString();
//       print("Current Location (Web): ${position.latitude}, ${position.longitude}");
//     } catch (e) {
//       print("Error getting location on Web: $e");
//     }
//   } else {
//
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       viewModel.latController.text = position.latitude.toString();
//       viewModel. longController.text = position.longitude.toString();
//       print("Current Location (Mobile): ${position.latitude}, ${position.longitude}");
//     } catch (e) {
//       print("Error getting location on Mobile: $e");
//     }
//   }
// }



// تعريف المضلع (حدود المنطقة)
const List<List<double>> polygon = [
  [26.553855919643567, 45.37380879905854], // النقطة 1
  [26.553855919643567, 45.323418384452594], // النقطة 2
  [26.465570913953712, 45.323418384452594], // النقطة 3
  [26.465570913953712, 45.37380879905854], // النقطة 4
  [26.553855919643567, 45.37380879905854], // النقطة 1 (لتكوين المضلع)
];

// التحقق إذا كان الموقع داخل المضلع
bool isLocationInPolygon(double latitude, double longitude, List<List<double>> polygon) {
  int i = 0;
  int j = polygon.length - 1;
  bool isInside = false;

  while (i < polygon.length) {
    double xi = polygon[i][1], yi = polygon[i][0];
    double xj = polygon[j][1], yj = polygon[j][0];

    bool intersect = ((yi > latitude) != (yj > latitude)) &&
        (longitude < (xj - xi) * (latitude - yi) / (yj - yi) + xi);
    if (intersect) {
      isInside = !isInside;
    }

    j = i;
    i++;
  }

  return isInside;
}



// الحصول على الموقع والتحقق من المنطقة
Future<void> getLocation(AddressCubit viewModel) async {
  if (kIsWeb) {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      bool isInside = isLocationInPolygon(position.latitude, position.longitude, polygon);

      if (isInside) {
        viewModel.latController.text = position.latitude.toString();
        viewModel.longController.text = position.longitude.toString();
        print("Current Location (Web) Inside Area: ${position.latitude}, ${position.longitude}");
      } else {
        print("Current Location (Web) Outside Area: ${position.latitude}, ${position.longitude}");
      }
    } catch (e) {
      print("Error getting location on Web: $e");
    }
  } else {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      bool isInside = isLocationInPolygon(position.latitude, position.longitude, polygon);

      if (isInside) {
        viewModel.latController.text = position.latitude.toString();
        viewModel.longController.text = position.longitude.toString();
        print("Current Location (Mobile) Inside Area: ${position.latitude}, ${position.longitude}");
      } else {
        print("Current Location (Mobile) Outside Area: ${position.latitude}, ${position.longitude}");
      }
    } catch (e) {
      print("Error getting location on Mobile: $e");
    }
  }
}
