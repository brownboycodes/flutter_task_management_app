import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDBService().initialize();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    final storedTheme = ref.read(hiveStateNotifierProvider)?.themeMode.toThemeMode();
    _themeNotifier=
    ValueNotifier(storedTheme ?? ThemeMode.light);
  }

  @override
  void dispose() {
    HiveDBService().close();
    super.dispose();
  }

  late ValueNotifier<ThemeMode> _themeNotifier;

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeNotifier,
        builder: (context, themeMode, child) {
          return MaterialApp(
            title: 'Task Management App',
            restorationScopeId: 'app',
            debugShowCheckedModeBanner: false,
            themeMode: _themeNotifier.value,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  inverseSurface: Colors.grey.shade700,
                  primaryContainer: Colors.grey.shade200),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(
              useMaterial3: true,
            ).copyWith(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  inverseSurface: Colors.white,
                  primaryContainer: Colors.grey.shade50.withAlpha(200)),
            ),
            home: TasksDashboard(
              themeNotifier: _themeNotifier,
            ),
          );
        });
  }
}
