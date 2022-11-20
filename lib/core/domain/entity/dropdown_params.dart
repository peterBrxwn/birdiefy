// Package imports:
import 'package:equatable/equatable.dart';

// used to determine if items in a dropdown list will overflow the screen
class DropdownParams extends Equatable {
  const DropdownParams({this.itemCount = 0, this.screenHeight = 0});
  final int itemCount;
  final double screenHeight;
  final minHeight = 55 * 4;

  double get max => itemCount * 55;
  double get maxHeight {
    if (itemCount == 0) return 55;
    if (itemCount > 4 && minHeight > screenHeight) return screenHeight;
    if (max > screenHeight) return screenHeight - 100;
    return max;
  }

  bool get showSearchBox => screenHeight > minHeight && max > screenHeight;

  DropdownParams copyWith({int? itemCount, double? screenHeight}) {
    return DropdownParams(
      itemCount: itemCount ?? this.itemCount,
      screenHeight: screenHeight ?? this.screenHeight,
    );
  }

  @override
  List<Object?> get props => [itemCount, screenHeight];
}
