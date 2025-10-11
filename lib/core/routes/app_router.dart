import 'package:go_router/go_router.dart';
import 'package:recordatorios_app/feature/auth/presentation/page/login_page.dart';
import 'package:recordatorios_app/feature/auth/presentation/page/registre_page.dart';
import 'package:recordatorios_app/feature/home/presentation/page/home_screen.dart';
import 'package:recordatorios_app/feature/landing/presentation/page/landing_screen.dart';
import 'package:recordatorios_app/feature/recordatorios/presentation/page/recordatorio_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
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
    ]
  );
}

class RouterConstants{
  static const String landing = '/';
  static const String login = '/login';
  static const String registre = '/register';
  static const String home = '/home';
  static const String recordatorios = '/recordatorios';
}