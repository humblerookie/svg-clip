import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_drawing/path_drawing.dart';

import 'dimension_extensions.dart';
import 'svg_asset.dart';

final _pathRegex = RegExp(r'<path\s+d="([^"]+)"');

///
/// This widget allows us to use an svg specified via [asset] as
/// a custom clipper for the [child]
///
/// Clip Behaviour:
///
/// Current clip behaviour is such that the clip/mask provided by [asset]
/// is expanded/shrunk to fit bounds of the [child] while respecting the mask's
/// aspect ratio.
/// Further more once the bounding is done, the mask is also centered if any of
/// the dimensions are smaller than the [child]
///
///
class SvgClip extends StatelessWidget {
  final ClipAsset asset;
  final Widget child;

  const SvgClip({Key? key, required this.asset, required this.child})
      : super(key: key);

  Path _getPath(String svg) {
    final pathData = _pathRegex.allMatches(svg);
    final List<Path> paths = [];
    for (final RegExpMatch match in pathData) {
      final String pathData = match.group(1)!;
      final path = parseSvgPathData(pathData);
      paths.add(path);
    }
    return paths.reduce((p, e) => Path.combine(PathOperation.union, p, e));
  }

  Future<Path> _loadPath() async =>
      asset.load().then((value) => _getPath(value));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Path>(
      future: _loadPath(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<Path> snapshot) {
        if (snapshot.hasData) {
          return ClipPath(
            clipper: _SvgClipper(snapshot.data!),
            child: child,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _SvgClipper extends CustomClipper<Path> {
  final Path path;

  const _SvgClipper(this.path);

  @override
  Path getClip(Size size) {
    final bounds = path.getBounds();
    final targetMaskSize =
        size.getBoxFitSize(Size(bounds.width, bounds.height));
    final scale = targetMaskSize.width / bounds.width;
    final moveX = max(0.0, (size.width - targetMaskSize.width) / 2);
    final moveY = max(0.0, (size.height - targetMaskSize.height) / 2);
    return path
        .transform(
          Float64List.fromList(
            [scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1],
          ),
        )
        .shift(Offset(moveX, moveY));
  }

  @override
  bool shouldReclip(_SvgClipper oldClipper) => oldClipper.path != path;
}
