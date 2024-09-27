import 'package:flutter/material.dart';

import '../../consts/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(),
            backgroundColor: appTheme.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
            // textAlign: TextAlign.center,
                  buttonText,
                  style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
