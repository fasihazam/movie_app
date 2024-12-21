import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/config/app_colors.dart';
import 'package:movie_app/core/config/enums.dart';
import 'package:movie_app/core/cubits/bottom_nav/bottom_nav_cubit.dart';
import 'package:movie_app/core/shared_widgets/asset_image_widget.dart';
import 'package:movie_app/core/shared_widgets/text_widget.dart';
import 'package:movie_app/core/utils/size_utils.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavItem currentItem =
        context.select((BottomNavCubit cubit) => cubit.state.currentItem);

    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: AnimatedBottomNavigationBar.builder(
          shadow: Shadow(
            color: AppColors.secondary.withOpacity(0.25),
            blurRadius: 20,
          ),
          backgroundColor: AppColors.primary,
          height: 70.h,
          itemCount: BottomNavItem.values.length,
          tabBuilder: (int index, bool isActive) =>
              _buildNavItem(context, BottomNavItem.values[index], isActive),
          scaleFactor: 0.5,
          activeIndex: currentItem.index,
          splashSpeedInMilliseconds: 0,
          onTap: (index) => context
              .read<BottomNavCubit>()
              .updateItem(BottomNavItem.values[index]),
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.softEdge,
        ));
  }

  Widget _buildNavItem(
    BuildContext context,
    BottomNavItem item,
    bool isActive,
  ) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetImageWidget(
              path: item.iconPath,
              color: isActive ? AppColors.onPrimary : AppColors.secondary,
              height: 16.h,
              width: 16.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            TextWidget(
              item.label,
              style: textTheme.labelSmall?.copyWith(
                color: isActive ? AppColors.onPrimary : AppColors.secondary,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
