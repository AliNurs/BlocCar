// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFields extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppTextFields({
    Key? key,
    this.maxLength = 20,
    required this.label,
    this.inputFormatter,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
  }) : super(key: key);

  final int maxLength;
  final String label;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(textInputAction: TextInputAction.next,
    onChanged: onChanged,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatter ?? [],
      decoration: InputDecoration(
        counterText: '',
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
  }
}
