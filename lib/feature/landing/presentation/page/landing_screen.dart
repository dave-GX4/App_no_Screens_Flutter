import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recordatorios_app/core/routes/app_router.dart';
import 'package:recordatorios_app/feature/landing/presentation/widgets/custom_elevated_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: 
            Column(
              children: [
                const Text("Recordatorios App"),
                CustomElevatedButton(
                  text: "Comencemos", 
                  onPressed: () {
                    context.go(RouterConstants.login);
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}