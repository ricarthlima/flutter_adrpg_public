import 'package:flutter/material.dart';

class CircularProgressIndicatorElevatedButton extends StatelessWidget {
  const CircularProgressIndicatorElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
