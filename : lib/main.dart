import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CyprusTravelApp());
}

class CyprusTravelApp extends StatefulWidget {
  const CyprusTravelApp({super.key});

  @override
  State<CyprusTravelApp> createState() => _CyprusTravelAppState();
}

class _CyprusTravelAppState extends State<CyprusTravelApp> {
  Locale _locale = const Locale('ar');

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'دليل قبرص السياحي | Cyprus Guide',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
        Locale('de'),
        Locale('ru'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008080),
          primary: const Color(0xFF008080),
          secondary: const Color(0xFFDAA520),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7F6),
      ),
      home: HomeScreen(onLanguageChange: _setLocale),
    );
  }
}
