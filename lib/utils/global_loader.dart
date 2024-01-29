import 'package:flutter/material.dart';

import 'ara_theme.dart';

class GlobalLoaderWidget extends StatefulWidget {
  const GlobalLoaderWidget({Key? key}) : super(key: key);

  @override
  State<GlobalLoaderWidget> createState() => _GlobalLoaderWidgetState();
}

class _GlobalLoaderWidgetState extends State<GlobalLoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const CircularProgressIndicator(
          backgroundColor: Styles.whiteColor,
          strokeWidth: 5,
          color: Styles.primaryGreenColor,
        ),
      ),
    );
  }
}
