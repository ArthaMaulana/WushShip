import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'auth/auth_models.dart';
// import 'auth/auth_service.dart';
import 'auth/mock_auth_service.dart';
// import 'auth/supabase_config.dart';
import 'providers/app_providers.dart';
import 'screens/auth/courier_login_screen.dart';
import 'screens/auth/role_selection_screen.dart';
import 'screens/auth/user_login_screen.dart';
import 'screens/courier/courier_dashboard_screen.dart';
import 'screens/shared/splash_screen.dart';
import 'screens/user/home_screen.dart';

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
        '/role-selection': (context) => const RoleSelectionScreen(),
        '/user-login': (context) => const UserLoginScreen(),
        '/courier-login': (context) => const CourierLoginScreen(),
        '/user-home': (context) => const HomeScreen(),
        '/courier-dashboard': (context) => const CourierDashboardScreen(),
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
