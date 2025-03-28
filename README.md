<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# `be_widgets` Flutter Package

## Overview

The be_widget Flutter package provides a collection of custom Flutter widgets that enhance the user interface and offer additional features for building Flutter applications. These widgets are designed to be flexible, customizable, and easy to integrate into your Flutter projects.

Widgets Included

- BeLabel Widget:

A widget for rendering a label on another widget.
Supports customization of label position, offset, and sizing.

- BeBadge Widget:

A widget for rendering a badge on another widget.
Allows customization of badge position, rounded corners, and offset.

- BeMultiBadge Widget:

A widget for rendering multiple badges on a single widget.
Provides flexibility in positioning and styling individual badges.

- BeMultiLabel Widget:

A widget for rendering multiple labels on a single widget.
Supports customization of label positions, offsets, and styling.
Usage

- BeOffset Widget:

A widget for rendering Child with offset. I'ts save time create complex widget without `Stack`

## Screenshot

![Screenshot-2](./screenshots/screen-shot-2.png)
![Screenshot-3](./screenshots/screen-shot-3.png)
![Screenshot-3](./screenshots/screen-shot-4.png)

To use this package in your Flutter project, add it to your pubspec.yaml file:

```yaml
dependencies:
  be_widgets: ^<latest_version>
```

Then, run:

```bash
flutter pub get
```

Import the desired widgets in your Dart code:

```dart
import 'package:be_widget/be_widget.dart';
```

Now, you can use the custom widgets provided by the be_widget package in your Flutter application.

Contribution and Issues
If you encounter any issues or would like to contribute to the be_widget package, feel free to visit the GitHub repository: be_widget on GitHub

License
This package is released under the MIT License. See the LICENSE file for details.

## BeLabel

`BeLabel` is a custom Flutter widget that renders a label on another widget. It is designed to be versatile, allowing you to position the label based on different configurations.

Attributes

child: The primary `widget` on which the label will be rendered.

label: The `label` widget to be displayed. If not provided, an empty-sized SizedBox will be used.

position: An enumeration representing the position of the label. It includes options such as ` topLeft`, `topCenter`, `topRight`, `rightTop`, `rightCenter`, `rightBottom`, `bottomRight`, `bottomCenter`, `bottomLeft`, `leftBottom`, `leftCenter`, `leftTop`, and `center `.

offset: An `offset` representing the translation of the label from its default position.

childSized: A `boolean` indicating whether the label's size should match the size of the child widget.

innerLabel: A `boolean` indicating whether the label should be positioned inside the child widget.

```dart

    BeLabel(
      child: YourWidget(),
      label: YourLabelWidget(),
      position: BeLabelPosition.topLeft,
      offset: Offset(10.0, 5.0),
      childSized: false,
      innerLabel: false,
    );

```

## BeBadge Widget

`BeBadge` is a custom Flutter widget that renders a badge on another widget. It is designed to be versatile, allowing you to position the badge based on different configurations.

Attributes

`child`: The primary widget on which the badge will be rendered.

`badge`: The badge widget to be displayed. If not provided, an empty-sized SizedBox will be used.

`position`: An enumeration representing the position of the badge. It includes options such as topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, and bottomRight.

`rounded`: A boolean indicating whether the badge should have rounded corners.

`offset`: An offset representing the translation of the badge from its default position.

Usage

```dart
    BeBadge(
      child: YourWidget(),
      badge: YourBadgeWidget(),
      position: BeBadgePosition.topRight,
      rounded: false,
      offset: Offset(10.0, 5.0),
    );
```

Note
If badge is not provided, an empty SizedBox will be used as a placeholder.

The position attribute determines the position of the badge relative to the child widget.

The rounded attribute can be set to true to give the badge rounded corners.

The offset attribute allows you to translate the badge from its default position.

Feel free to customize the widget according to your needs.

## BeMultiBadge

`BeMultiBadge` Flutter Widget
BeMultiBadge is a custom Flutter widget designed for rendering multiple badges on another widget. It provides flexibility in positioning badges based on different configurations.

Attributes
`child`: The primary widget on which the badges will be rendered.

`labels`: A list of BeBadgeChild objects representing the badges to be displayed.

`rounded`: A boolean indicating whether the badges should have rounded corners.

Usage

```dart
    BeMultiBadge(
      child: YourWidget(),
      labels: [
        BeBadgeChild(position: BeMultiBadgePosition.topRight),
        BeBadgeChild(position: BeMultiBadgePosition.bottomLeft, offset: Offset(5.0, 10.0)),
        // Add more badges as needed
      ],
      rounded: false,
    );
```

Note
The labels attribute is a list of BeBadgeChild objects, each representing a badge. You can customize the position and offset of each badge individually.

The rounded attribute can be set to true to give all badges rounded corners.

Feel free to customize the widget according to your needs.

## BeMultiLabel Widget

BeMultiLabel is a custom Flutter widget designed for rendering multiple labels on another widget. It provides flexibility in positioning labels based on different configurations.

Attributes
`child`: The primary widget on which the labels will be rendered.

`labels`: A list of BeLabelChild objects representing the labels to be displayed.

Usage

```dart
    BeMultiLabel(
      child: YourWidget(),
      labels: [
        BeLabelChild(position: BeMultiLabelPosition.topRight),
        BeLabelChild(position: BeMultiLabelPosition.bottomLeft, offset: Offset(5.0, 10.0)),
        // Add more labels as needed
      ],
    );
```

Note
The labels attribute is a list of BeLabelChild objects, each representing a label. You can customize the position and offset of each label individually.

# BeBoxDecoration & BeIconShapeBorder

This package provides two custom Flutter components:

1. `BeBoxDecoration`: An extension of `BoxDecoration` with added support for custom shadows (`BeBoxShadow`) and better interpolation.
2. `BeIconShapeBorder`: A custom `OutlinedBorder` that displays an icon inside a bordered shape with flexible alignment.

## BeBoxDecoration

### Features

- Custom shadow support (`BeBoxShadow` with inset/outset capabilities).
- Extended `copyWith`, `lerp`, and `scale` methods for enhanced flexibility.
- Maintains compatibility with Flutter’s decoration system.

### Example Usage

```dart
Container(
  width: 150,
  height: 150,
  decoration: BeBoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BeBoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ],
  ),
  child: Center(
    child: Text(
      "BeBoxDecoration",
      style: TextStyle(color: Colors.white),
    ),
  ),
)
```

---

## BeIconShapeBorder

### Features

- Allows an icon to be drawn within a shape border.
- Supports customizable border radius, color, width, and icon alignment.
- Works seamlessly with `ShapeDecoration`.

### Example Usage

```dart
Center(
  child: Container(
    width: 100,
    height: 100,
    decoration: ShapeDecoration(
      shape: BeIconShapeBorder(
        icon: Icons.import_contacts_sharp,
        size: 24,
        color: Colors.red,
        radius: 8,
        width: 2,
        alignment: BeIconAlignment.bottomRight,
        offset: Offset(-10, 10),
      ),
    ),
    child: Center(
      child: Text("Hello", style: TextStyle(color: Colors.green)),
    ),
  ),
)
```

All components offer extensive customization for creating beautiful UI elements in Flutter!

Feel free to customize the widget according to your needs.

### Contribution and Issues

If you encounter any issues or would like to contribute to the be_widget package, feel free to visit the GitHub repository: be_widget on GitHub [https://github.com/BusinessOcean/be_widgets]

### License

This package is released under the MIT License. See the LICENSE file for details.

Do What ever you want with this package like.

Happy coding with be_widget!

# Support My Work

Thank you for checking out our project! We're thrilled to have you here.

If you find our project useful and it has helped you in any way, please consider supporting our work. Your contribution will help us continue to improve this project and create more useful tools for the community.

## How You Can Help

### Donate

If you'd like to contribute financially, you can make a donation to our project. Even a small amount can make a big difference and will be greatly appreciated.

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/SouravKumarPandit)

### Spread the Word

Help us reach more people by sharing our project with your friends, colleagues, and on social media. The more visibility we get, the more support we can receive.

### Contribute

If you're a developer, you can contribute to the project by submitting bug reports, feature requests, or even code contributions. Check out our [Contribution Guidelines](CONTRIBUTING.md) to get started.

## Get in Touch

We'd love to hear from you! If you have any questions, feedback, or suggestions, please don't hesitate to reach out to us.

- Email: [businessocean.pvt.ltd@gmail.com](mailto:businessocean.pvt.ltd@gmail.com)
- Twitter: [@soupandit](https://twitter.com/soupandit)

Thank you for your support!
