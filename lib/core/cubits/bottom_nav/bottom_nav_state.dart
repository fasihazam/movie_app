part of 'bottom_nav_cubit.dart';

class BottomNavState extends Equatable {
  final BottomNavItem currentItem;

  const BottomNavState({
    this.currentItem = BottomNavItem.watch,
  });

  const BottomNavState.initial() : this();

  @override
  List<Object> get props => [currentItem];

  BottomNavState copyWith({
    BottomNavItem? currentItem,
  }) {
    return BottomNavState(
      currentItem: currentItem ?? this.currentItem,
    );
  }
}
