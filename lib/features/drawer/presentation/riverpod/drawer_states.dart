import "package:equatable/equatable.dart";

class DrawerStates extends Equatable {
  final int index;
  final String pageTitle;
  final double xOffset;
  final double yOffset;
  final bool isDrawerOpen;

  const DrawerStates({
    this.index = 0,
    this.pageTitle = "H O M E",
    this.yOffset = 0,
    this.xOffset = 0,
    this.isDrawerOpen = false,
  });

  DrawerStates copyWith({int? index, String? pageTitle, double? xOffset, double? yOffset}) {
    return DrawerStates(
      index: index ?? this.index,
      pageTitle: pageTitle ?? this.pageTitle,
      isDrawerOpen: !isDrawerOpen,
      xOffset: isDrawerOpen ? 0 : 300,
      yOffset: isDrawerOpen ? 0 : 80,
    );
  }

  @override
  List<Object?> get props => [index];
}
