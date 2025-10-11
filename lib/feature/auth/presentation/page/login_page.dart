import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recordatorios_app/core/routes/app_router.dart';
import 'package:recordatorios_app/feature/auth/presentation/providers/auth_provider.dart';
import 'package:recordatorios_app/feature/auth/presentation/widget/custom_container.dart';
import 'package:recordatorios_app/feature/auth/presentation/widget/custom_elevatebutton.dart';
import 'package:recordatorios_app/feature/auth/presentation/widget/custom_sizbox.dart';
import 'package:recordatorios_app/feature/auth/presentation/widget/custom_textformfield.dart';
import 'package:recordatorios_app/feature/auth/presentation/widget/custom_textlink.dart';
import 'package:recordatorios_app/feature/home/presentation/widgets/custom_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    authProvider = context.read<AuthProvider>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final formIsValid = _formKey.currentState?.validate() ?? false;
    if (!formIsValid) return;

    authProvider.loginUser(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginStatus = context.watch<AuthProvider>().loginStatus;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loginStatus == LoginStatus.success) {
        context.go(RouterConstants.home);
        authProvider.resetLoginStatus();
      }
      if (loginStatus == LoginStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email o contraseña incorrectos.'),
            backgroundColor: Colors.red,
          ),
        );
        authProvider.resetLoginStatus();
      }
    });

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          children: [
            CustomContainer( 
              title: 'Que bueno verte en recordatoriosApp', 
              subtitle: 'Iniciemos con un buen día, no dejes esperando',
            ),

            CustomSizbox(height: 20.0),
                  
            CustomText(
              text: 'Inicia sesion para continuar',
              size: 18.0,
            ),
            
            CustomSizbox(height: 50.0),
            
            Form(
              key:  _formKey,
              child: Column(
                children: [
                  CustomTextformfield(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'e.g. correo@example.com',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El email no puede estar vacío';
                      }
                      return null;
                    },
                  ),

                  CustomSizbox(height: 20.0),

                  CustomTextformfield(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Ingrese su contraseña',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La contraseña no puede estar vacía';
                      }
                      return null;
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: loginStatus == LoginStatus.loading
                        ? const CircularProgressIndicator()
                        : CustomElevatebutton(
                            text: 'Enviar',
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            onPressed: _submitForm,
                          ),
                  ), 
                ],
              )
            ),

            CustomTextlink(
              text: '¿No tiene una cuenta? Ven y crea una ¡Ahora!', 
              onTap: () {
                context.push(RouterConstants.registre);
              }
            )
          ],
        ),
      ),
    );
  }
}