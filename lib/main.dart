import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'auth/auth_models.dart';
// import 'auth/auth_service.dart';
import 'auth/mock_auth_service.dart';
// import 'auth/supabase_config.dart';
import 'providers/app_providers.dart';
import 'screens/courier/courier_dashboard_screen.dart';
import 'screens/courier/courier_my_order_screen.dart';
import 'screens/courier/courier_profile_screen.dart';
import 'screens/shared/login_screen.dart';
import 'screens/shared/splash_screen.dart';
import 'screens/user/home_screen.dart';
import 'screens/user/my_order_screen.dart';
import 'screens/user/premium_screen.dart';
import 'screens/user/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase (commented out for now)
  // await SupabaseConfig.initialize();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ShipmentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WushShip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B5FE8)),
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/user-home': (context) => const HomeScreen(),
        '/my-orders': (context) => const MyOrderScreen(),
        '/premium': (context) => const PremiumScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/courier-dashboard': (context) => const CourierDashboardScreen(),
        '/courier-profile': (context) => const CourierProfileScreen(),
        '/courier-my-order': (context) => const CourierMyOrderScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        // If user is authenticated, navigate to appropriate screen
        if (authService.isAuthenticated) {
          final user = authService.currentUser!;
          if (user.role == UserRole.user) {
            return const HomeScreen();
          } else if (user.role == UserRole.courier) {
            return const CourierDashboardScreen();
          }
        }

        // If not authenticated, show splash screen (which will handle the flow)
        return const SplashScreen();
      },
    );
  }
}
