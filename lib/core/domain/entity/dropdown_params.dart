import 'package:equatable/equatable.dart';

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

extension DropdownParamsX on List<DropdownParams> {
  /// Returns the int in thousands format.
  List<DropdownParams> updateScreenHeight(double screenHeight) {
    return map((e) => e.copyWith(screenHeight: screenHeight)).toList();
  }
}

extension DropdownParamsY on List<DropdownParams?> {
  /// Returns the int in thousands format.
  List<DropdownParams?> updateScreenHeight(double screenHeight) {
    return map((e) {
      if (e == null) return e;
      return e.copyWith(screenHeight: screenHeight);
    }).toList();
  }
}
