import 'package:apploan/core/core.dart';
import 'package:apploan/main.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherManager {
  static Future<void> launch(String? url) async {
    customPrint('===== URL ===== $url');

    try {
      if (url == null) {
        throw Exception();
      }

      final uri = Uri.tryParse(url);
      if (uri == null) {
        throw Exception();
      }

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ExceptionHandler.handleException('Could not launch url: $url');
    }
  }

  static Future<void> call(String value) async {
    launch('tel://$value');
  }

  static Future<void> telegram(String value) async {
    launch('https://t.me/$value');
  }

  static Future<void> map({required String lat, required String lng}) async {
    launch('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
  }
}
