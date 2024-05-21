import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_pallete.dart';

class ContainerBox extends StatelessWidget {
  const ContainerBox(
      {super.key, this.child, this.height, this.width, this.padding});

  final Widget? child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppPallete.containerColor,
      ),
      child: child,
    );
  }
}

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
            Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        const Divider(thickness: 0.5, color: Colors.white54),
      ],
    );
  }
}
