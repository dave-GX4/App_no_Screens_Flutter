import 'package:flutter/material.dart';
import 'package:recordatorios_app/core/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'package:recordatorios_app/feature/auth/presentation/providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: MaterialApp.router(
          title: "Recordatorios App",

          routerConfig: AppRouter.router,
        ),
      );
  }
}
