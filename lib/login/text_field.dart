import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? helperText;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onSuffixIconPressed;
  final bool? obsecureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.helperText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.onSuffixIconPressed,
    this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const Text(
                ' : ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            obscureText: obsecureText ?? false,
            decoration: InputDecoration(
              filled: true,
              counterText: '',
              fillColor: const Color(0XFFF1F4F9),
              hintText: hintText,
              suffixIcon: IconButton(
                onPressed: onSuffixIconPressed,
                icon: Icon(
                  suffixIcon,
                  size: 18,
                  color: const Color(0xFF2F82FF),
                ),
                splashRadius: 1,
              ),
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(
                  0xFF4A5568,
                ),
              ),
              helperText: helperText ?? '',
              helperStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFFA9B9CC),
              ),
              errorStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFFE71414),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
