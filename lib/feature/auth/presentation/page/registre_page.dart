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

class RegistrePage extends StatefulWidget{
  const RegistrePage({super.key});

  @override
  State<RegistrePage> createState() => _RegistrePageState();
}

class _RegistrePageState extends State<RegistrePage>{

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstnameController;
  late final TextEditingController _lastnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    authProvider = context.read<AuthProvider>();
  }

  @override
  void dispose() {
    authProvider.resetRegistrationStatus();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final formIsValid = _formKey.currentState?.validate() ?? false;
    
    if (!formIsValid) {
      return;
    }
    
    authProvider.registerUser(
      _firstnameController.text.trim(),
      _lastnameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final registrationStatus = context.watch<AuthProvider>().registrationStatus;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (registrationStatus == RegistrationStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Registro exitoso! Por favor, inicia sesión.'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop(); // Navega a la pantalla anterior (Login)
        authProvider.resetRegistrationStatus();
      }

      if (registrationStatus == RegistrationStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocurrió un error. Inténtalo de nuevo.'),
            backgroundColor: Colors.red,
          ),
        );
        authProvider.resetRegistrationStatus();
      }
    });

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          children: [
            CustomContainer(
              title: 'Bienvenido a RecordatoriosApp', 
              subtitle: 'Se parte de nuestra cominidad y de las pantas',
            ),

            CustomSizbox(height: 20.0),
                  
            CustomText(
              text: 'Registrate para continuar',
              size: 18.0,
            ),
            
            CustomSizbox(height: 25.0),
            
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: 
                        CustomTextformfield(
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return 'El campo no puede estar vacio';
                            }
                            return null;
                          },
                          controller: _firstnameController,
                          labelText: 'Nombre (s)', 
                          hintText: 'e.g. Jose',
                        ),
                      ),

                      CustomSizbox(width: 20.0,),

                      Expanded(child:
                        CustomTextformfield(
                          validator: (value) {
                            if (value == null || value.isEmpty){
                              return 'El campo no puede estar vacio';
                            }
                            return null;
                          },
                          controller: _lastnameController,
                          labelText: 'Apellido (s)',
                          hintText: 'e.g. Martinez'
                        )
                      ),
                    ],
                  ),
                  
                  CustomSizbox(height: 20.0),

                  CustomTextformfield(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'El campo no puede estar vacio';
                      }
                      return null;
                    },
                    labelText: 'Correo',
                    hintText: 'e.g. correo@example.com'
                  ),

                  CustomSizbox(height: 20.0),

                  CustomTextformfield(
                    obscureText: true,
                    controller: _passwordController,
                    labelText: 'Contraseña',
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'No puede estar vacio';
                      }
                      if (value.length < 8){
                        return 'La contraseña debe tener un minimo de 8 caracteres';
                      }
                      return null;
                    },
                    hintText: 'Recuerde su contraseña'
                  ),

                  CustomSizbox(height: 20.0),
                  
                  CustomTextformfield(
                    controller: _confirmPasswordController,
                    validator: (value) {
                        if (value !=  _passwordController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    obscureText: true,
                    labelText: 'Confirmar contraseña',
                    hintText: 'Confirme la contraseña anterior'
                  ),

                  Padding(padding: 
                    EdgeInsets.symmetric(vertical: 30.0),
                    child: authProvider.registrationStatus == RegistrationStatus.loading
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
              text: '¿Ya cuentas con una cuenta? Inicia sesion', 
              onTap: () {
                context.pop(RouterConstants.login);
              }
            )
          ],
        ),
      ),
    );
  }
}