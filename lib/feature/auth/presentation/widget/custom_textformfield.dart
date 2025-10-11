import 'package:flutter/material.dart';

class CustomTextformfield extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final Color? color;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextformfield({
    super.key,
    required this.labelText,
    required this.hintText,
    this.icon,
    this.color,
    this.controller,
    this.validator,
    this.obscureText = false,
  });

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscured,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: widget.icon != null ? Icon(widget.icon, color: widget.color) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 89, 76, 175), 
            width: 1.0
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 120, 114, 219), 
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, 
            width: 1.0
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, 
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: widget.hintText
      ),
    );
  }
}