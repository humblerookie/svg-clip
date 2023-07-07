# Svg Clip

![GitHub stars](https://img.shields.io/github/stars/humblerookie/svg-clip?style=social)
![GitHub forks](https://img.shields.io/github/forks/humblerookie/svg-clip?style=social)
![Latest release](https://img.shields.io/github/v/release/humblerookie/svg-clip)
![GitHub license](https://img.shields.io/github/license/humblerookie/svg-clip)

The Svg Clip library provides a simple way to use an SVG file as a mask for clipping a Flutter widget.
This allows you to create visually appealing designs by applying convenient shapes as masks to your widgets.

## Installation

To use this library in your Flutter project, follow these steps:

1. Add the following dependency to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     svg_clip: <latest-version>
   ```

## Usage

```dart
SvgClip(
asset: ClipAsset.local(path: "assets/images/cloud.svg"),
child: const _ColoredBox(
   color: Colors.green,
   width: 300,
   height: 100,
 ),
)
```

## Full Example

   ```dart
import 'package:flutter/material.dart';
import 'package:svg_clip/svg_clip.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG Mask Clipper Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SVG Mask Clipper Demo'),
        ),
        body: Center(
          child: SvgClip(
            asset: ClipAsset.local(path: "assets/images/cloud.svg"),
            child: const _ColoredBox(
              color: Colors.green,
              width: 300,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
   ```

## Limitations

- Supports local svgs only.
- Certain complex svg may not work as expected.

## License

This library is licensed under the [MIT License](LICENSE).