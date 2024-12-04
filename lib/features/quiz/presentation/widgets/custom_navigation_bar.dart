import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomNavigationBar extends StatelessWidget {
  final List<IconData> icons;
  final List<String>? labels;

  const CustomNavigationBar({
    super.key,
    required this.icons,
    required this.labels,
  }) : assert(
  labels != null && icons.length == labels.length,
          'Error in CustomNavigationBar: The number of icons (${icons.length}) and labels (${labels?.length}) must match.',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        ],
      ),
    );
  }
}
