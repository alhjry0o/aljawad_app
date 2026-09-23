import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/local_requests_repository.dart';
import '../../data/repositories/requests_repository.dart';
import '../../data/repositories/services_repository.dart';

/// يُحقن في main قبل runApp.
final sharedPrefsProvider = Provider<SharedPreferences>((_) {
  throw UnimplementedError('sharedPrefsProvider must be overridden');
});

final servicesRepositoryProvider = Provider<ServicesRepository>(
  (_) => const LocalServicesRepository(),
);

final requestsRepositoryProvider = Provider<RequestsRepository>(
  (ref) => LocalRequestsRepository(ref.watch(sharedPrefsProvider)),
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPrefsProvider);
    final v = prefs.getString(_key);
    return switch (v) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setString(_key, switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class LocaleNotifier extends Notifier<Locale> {
  static const _key = 'locale';

  @override
  Locale build() {
    final prefs = ref.watch(sharedPrefsProvider);
    final v = prefs.getString(_key);
    return Locale(v ?? 'ar');
  }

  Future<void> set(Locale locale) async {
    state = locale;
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setString(_key, locale.languageCode);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);