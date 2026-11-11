import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'state/deteksi_model.dart';
import 'state/theme_model.dart';
import 'theme/app_theme.dart';
import 'pages/kerangka_navigasi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/halaman_input_deteksi.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DeteksiModel>(
          create: (_) => DeteksiModel(),
        ),
        ChangeNotifierProvider<ThemeModel>(
          create: (_) => ThemeModel(),
        ),
      ],
      child: const AgriVisionApp(),
    ),
  );
}

class AgriVisionApp extends StatelessWidget {
  const AgriVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, modelTema, child) {
        return MaterialApp(
          title: 'AgriVision CNN',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: modelTema.themeMode,
          initialRoute: AppRoutes.beranda,
          routes: {
            AppRoutes.beranda: (context) =>
                const KerangkaNavigasi(),
            AppRoutes.tentang: (context) =>
                const HalamanTentang(),
            AppRoutes.inputDeteksi: (context) =>
                const HalamanInputDeteksi(),
          },
        );
      },
    );
  }
}
