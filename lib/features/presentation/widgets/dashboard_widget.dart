import 'package:flutter/material.dart';
import 'package:movie_app/core/shared_widgets/text_widget.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextWidget('This is dashboard widget.'),
    );
  }
}
