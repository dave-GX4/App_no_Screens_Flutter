import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recordatorios_app/core/routes/app_router.dart';
import 'package:recordatorios_app/core/widget/inactivity_detector.dart';
import 'package:recordatorios_app/feature/auth/presentation/providers/auth_provider.dart';
import 'package:recordatorios_app/feature/recordatorios/presentation/provider/provider_card.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();

  runApp(MainApp(authProvider: authProvider));
}

class MainApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MainApp({
    super.key,
    required this.authProvider
  });

@override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => ProviderCard()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return InactivityDetector(
            onTimeout: () {
              if (auth.isAuthenticated) {
                print("Cerrando sesión por inactividad...");
                auth.logout();
              }
            },
            child: MaterialApp.router(
              title: 'Recordatorios App',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.setupRouter(auth),
            ),
          );
        },
      ),
    );
  }
}
