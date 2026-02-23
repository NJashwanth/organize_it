import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecycle_logger/lifecycle_logger.dart';
import 'package:organize_it/features/splash/presentation/splash_screen.dart';
import 'package:organize_it/core/theme/app_theme.dart';

// ================================
// PROVIDERS
// ================================
final themeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

// ================================
// APP ENTRY
// ================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LifecycleLogger.attach();
  runApp(const ProviderScope(child: MyApp()));
}

// ================================
// ROOT WIDGET
// ================================
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OrganizeIt',
      themeMode: themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const SplashScreen(),
    );
  }
}
