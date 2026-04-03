import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/location_model.dart';
import 'providers/navigation_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/location_details_screen.dart';
import 'screens/locations_list_screen.dart'; // ignore: unused_import
import 'screens/navigation_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/navigation':
        return MaterialPageRoute(builder: (_) => const NavigationScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());      case '/locations':
        final args = settings.arguments as LocationType?;
        return MaterialPageRoute(
          // ignore: undefined_method
          builder: (_) => LocationsListScreen(locationType: args),
        );
      case '/location-details':
        final location = settings.arguments as CampusLocation?;
        if (location != null) {
          return MaterialPageRoute(
            builder: (_) => LocationDetailsScreen(location: location),
          );
        }
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        title: 'Campus Navigation - UniNav Solutions',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const LoginScreen(),
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}
