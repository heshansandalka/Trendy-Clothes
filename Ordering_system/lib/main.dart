import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/user_role.dart';
import 'providers/shop_provider.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/main_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ClothingApp());
}

class ClothingApp extends StatefulWidget {
  const ClothingApp({super.key});

  @override
  State<ClothingApp> createState() => _ClothingAppState();
}

class _ClothingAppState extends State<ClothingApp> {
  final ShopProvider _shopProvider = ShopProvider();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _shopProvider,
      builder: (context, child) {
        return MaterialApp(
          title: 'Trendy Clothes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2C3E50),
              primary: const Color(0xFF2C3E50),
              secondary: const Color(0xFFE74C3C),
            ),
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            fontFamily: 'Roboto',
          ),
          home: _getHomeWidget(_shopProvider),
        );
      },
    );
  }

  Widget _getHomeWidget(ShopProvider provider) {
    if (provider.currentRole == null) {
      return WelcomeScreen(provider: provider);
    }
    if (provider.currentRole == UserRole.admin) {
      return AdminPanelScreen(provider: provider);
    }
    return MainScreen(provider: provider);
  }
}
