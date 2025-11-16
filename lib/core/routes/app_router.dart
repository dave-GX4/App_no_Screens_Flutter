import 'package:go_router/go_router.dart';
import 'package:recordatorios_app/feature/auth/presentation/page/login_page.dart';
import 'package:recordatorios_app/feature/auth/presentation/page/registre_page.dart';
import 'package:recordatorios_app/feature/home/presentation/page/home_screen.dart';
import 'package:recordatorios_app/feature/landing/presentation/page/landing_screen.dart';
import 'package:recordatorios_app/feature/recordatorios/presentation/page/recordatorio_screen.dart';
import 'package:recordatorios_app/feature/auth/presentation/providers/auth_provider.dart';

class AppRouter {
  static GoRouter setupRouter(AuthProvider authProvider) {
    return GoRouter(
      refreshListenable: authProvider,
      
      initialLocation: RouterConstants.landing,
      routes: [
        GoRoute(
          path: RouterConstants.landing,
          builder: (context, state) => const LandingScreen(),
        ),
        GoRoute(
          path: RouterConstants.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: RouterConstants.registre,
          builder: (context, state) => const RegistrePage(),
        ),
        GoRoute(
          path: RouterConstants.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouterConstants.recordatorios,
          builder: (context, state) => const RecordatorioScreen(),
        )
      ],

      redirect: (context, state) {
        final bool isAuthenticated = authProvider.isAuthenticated;
        final bool isInitialized = authProvider.isInitialized;

        if (!isInitialized) {
          return null;
        }

        final isAuthRoute = state.matchedLocation == RouterConstants.landing ||
                              state.matchedLocation == RouterConstants.login ||
                              state.matchedLocation == RouterConstants.registre;
        
        if (!isAuthenticated && !isAuthRoute) {
          return RouterConstants.login;
        }

        if (isAuthenticated && isAuthRoute) {
          return RouterConstants.home;
        }

        return null;
      },
    );
  }
}

class RouterConstants{
  static const String landing = '/';
  static const String login = '/login';
  static const String registre = '/register';
  static const String home = '/home';
  static const String recordatorios = '/recordatorios';
}