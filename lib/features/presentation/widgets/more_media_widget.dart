import 'package:flutter/material.dart';
import 'package:movie_app/core/shared_widgets/text_widget.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextWidget('This is more media widget.'),
    );
  }
}
