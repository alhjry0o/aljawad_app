import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class Launcher {
  Launcher._();

  static Future<bool> open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (kDebugMode) debugPrint('Launcher error: $e');
      return false;
    }
  }

  static Future<bool> tel(String number) => open('tel:$number');

  static Future<bool> mail(String email, {String? subject, String? body}) {
    final q = <String, String>{};
    if (subject != null) q['subject'] = subject;
    if (body != null) q['body'] = body;
    final query = q.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    return open('mailto:$email${query.isEmpty ? '' : '?$query'}');
  }

  static Future<bool> whatsapp(String phone, {String? text}) {
    final t = text == null ? '' : '?text=${Uri.encodeComponent(text)}';
    return open('https://wa.me/$phone$t');
  }

  static Future<bool> maps(String query) =>
      open('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}');

  static Future<bool> website(String url) => open(url);
}