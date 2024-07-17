import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Color borderColor;
  final Color? textFieldColor;
  final Color enableColor;
  final TextEditingController? textController;
  final Color inputColor;
  final IconButton? iconButton;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hint,
    this.textController,
    this.iconButton,
    this.borderColor = Colors.black,
    this.enableColor = Colors.black,
    this.textFieldColor,
    this.inputColor = Colors.black,
    this.validator,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: widget.inputColor,
      ),
      controller: widget.textController,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: widget.hint == "Password"
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : widget.iconButton,
        hintStyle: TextStyle(color: widget.textFieldColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: widget.enableColor),
        ),
        hintText: widget.hint,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      validator: widget.validator,
      obscureText: widget.hint == "Password" ? _isObscured : widget.obscureText,
    );
  }
}
