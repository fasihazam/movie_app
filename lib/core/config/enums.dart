import 'package:flutter/material.dart';
import 'package:movie_app/core/config/assets.dart';
import 'package:movie_app/features/presentation/widgets/dashboard_widget.dart';
import 'package:movie_app/features/presentation/widgets/watch_widget.dart';
import 'package:movie_app/features/presentation/widgets/media_library_widget.dart';
import 'package:movie_app/features/presentation/widgets/more_media_widget.dart';

enum BottomNavItem {
  dashboard(
    iconPath: Assets.imagesDashboard,
    child: FavoriteWidget(),
  ),
  watch(
    iconPath: Assets.imagesWatch,
    child: HomeWidget(),
  ),

  media(
    iconPath: Assets.imagesLibrary,
    child: OrdersWidget(),
  ),
  more(
    iconPath: Assets.imagesMore,
    child: ProfileWidget(),
  );

  String get label {
    switch (this) {
      case BottomNavItem.dashboard:
        return 'Dashboard';
      case BottomNavItem.watch:
        return 'Watch';
      case BottomNavItem.media:
        return 'Media Library';
      case BottomNavItem.more:
        return 'More';
    }
  }

  final String iconPath;

  final Widget child;

  const BottomNavItem({
    required this.iconPath,
    required this.child,
  });
}
