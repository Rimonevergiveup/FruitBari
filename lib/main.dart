import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/localization/locale_provider.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(
    const ProviderScope(
      child: FruitBariApp(),
    ),
  );
}

class FruitBariApp extends ConsumerWidget {
  const FruitBariApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'FruitBari - Seasonal Fruit Discovery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(lang),
      routerConfig: appRouter,
    );
  }
}
