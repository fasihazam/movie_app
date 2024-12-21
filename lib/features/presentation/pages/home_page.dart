import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:movie_app/core/config/enums.dart';
import 'package:movie_app/core/cubits/bottom_nav/bottom_nav_cubit.dart';
import 'package:movie_app/core/shared_widgets/base_scaffold_widget.dart';
import 'package:movie_app/features/presentation/widgets/lazy_indexed_widget.dart';

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final children = BottomNavItem.values.map((e) => e.child).toList();

    useEffect(() {
      return null;
    }, []);

    return BaseScaffoldWidget(
      body: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return LazyIndexedWidget(
            index: state.currentItem.index,
            children: children,
          );
        },
      ),
    );
  }
}
