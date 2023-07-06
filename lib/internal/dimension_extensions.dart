import 'dart:math';
import 'dart:ui';

extension DimensionExtensions on Size {
  Size getBoxFitSize(
    Size sourceSize,
  ) {
    if (sourceSize.width == 0 || sourceSize.height == 0) {
      return this;
    }
    final double scaleWidth = width / sourceSize.width;
    final double scaleHeight = height / sourceSize.height;
    final double scale = min(scaleWidth, scaleHeight);

    final double maxWidth = sourceSize.width * scale;
    final double maxHeight = sourceSize.height * scale;
    return Size(maxWidth, maxHeight);
  }
}
