import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:medsapp_project/Screens/chat_screen.dart';
import 'package:medsapp_project/Screens/splash_screen.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:medsapp_project/Screens/splash_screen.dart';
import 'package:medsapp_project/constains/themes.dart';
import 'package:medsapp_project/providers/active_theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(MyApp());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(activeThemeProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: activeTheme == Themes.dark ? ThemeMode.light : ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
