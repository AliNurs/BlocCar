// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.isFullFilled,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  final Function()onPressed;
  final bool isFullFilled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : isFullFilled
                                ? onPressed
                                : null,
                        child: isLoading
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator())
                            : const Text('Добавить'),
                      );
  }
}
