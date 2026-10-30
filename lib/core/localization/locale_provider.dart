import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_strings.dart';

/// Modern Riverpod Notifier for bilingual English / Bangla switching
class LocaleNotifier extends Notifier<String> {
  @override
  String build() => 'en';

  void toggleLocale() {
    state = state == 'en' ? 'bn' : 'en';
  }

  void setLocale(String code) {
    if (code == 'en' || code == 'bn') {
      state = code;
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, String>(() {
  return LocaleNotifier();
});

/// Extension on WidgetRef to easily retrieve localized strings
extension LocalizedRef on WidgetRef {
  String tr(String key) {
    final lang = watch(localeProvider);
    return AppStrings.get(key, lang);
  }
}
