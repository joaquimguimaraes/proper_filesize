import "dart:math" as math;

import "package:proper_filesize/src/base_type.dart";

import "package:proper_filesize/src/format_type.dart";
import "package:proper_filesize/src/unit.dart";

/// A class for representing file sizes.
///
/// This class provides methods for creating, parsing, and converting file sizes
/// between different units.
///
/// It supports both metric (KB, MB, GB) and binary (KiB, MiB, GiB) units.
///
/// The class also provides a method for generating human-readable string
/// representations of file sizes.
base class FileSize {
  /// Creates a [FileSize] object from a [size] in bytes.
  FileSize.fromBytes(
    this.size,
  );

  /// Creates a [FileSize] object from a [size] in the specified [unit].
  FileSize.fromUnit({
    required final num size,
    required final Unit unit,
  }) : size = size *
            math.pow(
              unit.baseType.value,
              unit.orderOfMagnitude,
            );

  /// Creates a [FileSize] object from a human-readable filesize string.
  ///
  /// The [input] parameter is a string representation of a file size,
  /// such as "1.2 KB" or "3.5 MB".
  FileSize.parse(
    final String input,
  ) : size = (() {
          final Unit detectedUnit = Unit.parse(input);
          final num parsedValue = num.parse(input.numericPart);
          final num multiplierToBytes = math.pow(
            detectedUnit.baseType.value,
            detectedUnit.orderOfMagnitude,
          );

          return parsedValue * multiplierToBytes;
        })();

  /// The size in bytes.
  final num size;

  /// Returns a human-readable string representation of the file size.
  ///
  /// The [unit] parameter specifies the unit to use for the output.
  /// If not specified, the unit is automatically determined based on the size.
  /// The [formatType] parameter specifies the format of the unit string.
  /// It defaults to [FormatType.short].
  /// The [decimals] parameter specifies the number of decimal places to use.
  /// It defaults to 3.
  @override
  String toString({
    Unit? unit,
    final FormatType formatType = FormatType.short,
    final int decimals = 3,
    final String Function(num value, int decimals) formatter =
        _defaultFormatter,
  }) {
    unit ??= Unit.auto(
      size: size,
      baseType: BaseType.binary,
    );
    final num value = toSize(unit: unit);

    final String valueStr = ((value % 1 == 0)
        ? value.toInt().toString()
        : value.toStringAsFixed(decimals));
    final String unitStr = unit.representation[formatType]!;
    final String pluralUnit = switch (formatType) {
      FormatType.long when value != 1 => "s",
      _ => "",
    };

    return "$valueStr $unitStr$pluralUnit";
  }

  /// Returns the size in the specified [unit].
  num toSize({required final Unit unit}) =>
      size / (math.pow(unit.baseType.value, unit.orderOfMagnitude));
}

extension _IntX on int {
  bool isNumeric() => "0123456789".codeUnits.contains(this);
}

extension _StringX on String {
  String get numericPart => substring(
        codeUnits.indexWhere((final int codeUnit) => codeUnit.isNumeric()),
        codeUnits.lastIndexWhere((final int codeUnit) => codeUnit.isNumeric()) +
            1,
      );
}

String _defaultFormatter(final num value, final int decimals) =>
    ((value % 1 == 0)
        ? value.toInt().toString()
        : value.toStringAsFixed(decimals));
