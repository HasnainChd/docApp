import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const CustomTextButton({super.key,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onTap, child: Text(buttonText,style:
        const TextStyle(fontSize: 15),
    ),
    );
  }
}
