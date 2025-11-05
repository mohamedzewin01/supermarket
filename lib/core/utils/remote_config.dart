import 'package:fada_alhalij_web/core/widgets/app_closed_page.dart';
import 'package:fada_alhalij_web/features/layout/presentation/pages/layout_view.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';


class ForceUpdateChecker {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<bool> fetchAppEnabledStatus() async {
    // وضع Default Value
    await remoteConfig.setDefaults(const {'app_enabled': true});

    // إعداد Remote Config
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );

    // جلب القيم وتفعيلها
    bool activated = await remoteConfig.fetchAndActivate();
    print("Remote Config activated: $activated");

    final appEnabled = remoteConfig.getBool('app_enabled');
    print("app_enabled = $appEnabled");

    return appEnabled;
  }
}

class MyError extends StatelessWidget {
  const MyError({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: ForceUpdateChecker().fetchAppEnabledStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('حدث خطأ!')));
        } else {
          final isAppEnabled = snapshot.data ?? true;
          return isAppEnabled ? const LayoutScreen() : const AppClosedPage();
        }
      },
    );
  }
}
