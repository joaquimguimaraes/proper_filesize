[![pub package](https://img.shields.io/pub/v/proper_filesize.svg)](https://pub.dev/packages/proper_filesize)
[![tests](https://github.com/gilnobrega/proper_filesize/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/gilnobrega/proper_filesize/actions/workflows/tests.yml)
[![license](https://img.shields.io/github/license/gilnobrega/proper_filesize)](https://github.com/gilnobrega/proper_filesize/blob/main/LICENSE)
[![code style: lints](https://img.shields.io/badge/style-%2F%2F%20lints-40c4ff.svg)](https://pub.dev/packages/lints)

**A self-contained Dart library for seamlessly converting between bytes and human-readable file sizes.**

Effortlessly convert raw byte values into human-readable file sizes like "1.2 KB" or "3.5 MB", and vice versa.

This is ideal for displaying file sizes in user interfaces, handling file uploads, processing data storage information, and more.

Supports both binary (KiB, MiB, GiB) and metric (KB, MB, GB) units.

## Features

*   Converts bytes to human-readable strings (e.g., `1024 bytes` to `"1 KiB"`).
*   Converts human-readable strings to bytes (e.g., `"1.2 GB"` to `1200000000 bytes`).
*   Supports both binary and metric units (KB, KiB, MB, MiB, GB, GiB, TB, TiB, PB, PiB, EB, EiB, etc.).
*   Customizable decimal precision.
*   Supports short and long format types (e.g., "KB" vs "kilobyte").

## Installation

Add `proper_filesize` as a dependency to your project. You can do this easily by running the following command in your terminal:

```bash
dart pub add proper_filesize
```

Or, manually add it to your project's `pubspec.yaml` file:

```yaml
dependencies:
  proper_filesize: ^1.0.2
```

Then run:

```bash
dart pub get
```

## Usage

First, import the library:

```dart
import 'package:proper_filesize/proper_filesize.dart';
```

### Parsing File Size String to Numeric Value

Converts a human-readable file size string (e.g., "1.2 KB", "3.5 MB", "1.5 GiB") to its corresponding byte value.

```dart
import 'package:proper_filesize/proper_filesize.dart';

String metricFilesize = "1.2 EB";
int metricBytes = FileSize.parse(metricFilesize).size.toInt();
print("$metricFilesize is $metricBytes bytes");
// Output: 1.2 EB is 1200000000000000000 bytes

String binaryFilesize = "1.2 EiB";
int binaryBytes = FileSize.parse(binaryFilesize).size.toInt();
print("$binaryFilesize is $binaryBytes bytes");
// Output: 1.2 EiB is 1383505805528216320 bytes

String longFormatFilesize = "1.45 gibibytes";
int longFormatBytes = FileSize.parse(longFormatFilesize).size.toInt();
print("$longFormatFilesize is $longFormatBytes bytes");
// Output: 1.45 gibibytes is 1556488978432 bytes
```

### Converting Numeric Value to File Size String

Converts a byte value to a human-readable file size string.

```dart
import 'package:proper_filesize/proper_filesize.dart';

int bytes = 1243560000;

// Using metric units (KB, MB, GB)
String metricFilesize = FileSize.fromBytes(bytes).toString(
  unit: Unit.auto(size: bytes, baseType: BaseType.metric),
);
print("$bytes bytes is $metricFilesize"); 
// Output: 1243560000 bytes is 1.244 GB

// Using binary units (KiB, MiB, GiB)
String binaryFilesize = FileSize.fromBytes(bytes).toString();
print("$bytes bytes is $binaryFilesize"); 
// Output: 1243560000 bytes is 1.158 GiB
```

### Further Examples

For more comprehensive examples, explore the following use cases in the [example.dart](https://pub.dev/packages/proper_filesize/example) file:

  * Customizing Decimal Precision: Control the number of decimal places in the output.
  * Using Long Format Types: Display units in their full form (e.g., "kilobyte" instead of "KB").
  * Providing Explicit Units: Specify the desired output unit.
  * Parsing Long-Format Strings: Parse strings with long-form units.
  * Converting Units with Explicit Unit Conversion: Convert between different units directly.

## API Documentation

For detailed information about all classes and methods, see the full [API documentation](https://pub.dev/documentation/proper_filesize/latest/).

## Contributions

We welcome contributions\! Whether you have a bug report, a feature request, or want to contribute code, please feel free to open an issue or submit a pull request on [GitHub](https://github.com/gilnobrega/proper_filesize).