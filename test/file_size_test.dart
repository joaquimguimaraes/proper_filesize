import "package:proper_filesize/proper_filesize.dart";
import "package:test/test.dart";

void main() {
  group("FileSize.parse()", () {
    test('''
        GIVEN the input is "1 KB"
        WHEN the file size is parsed
        THEN the result should be 1000 bytes
        ''', () {
      // Arrange
      const String fileSize = "1 KB";

      // Act
      final int result = FileSize.parse(fileSize).size.toInt();

      // Assert
      expect(result, 1000);
    });

    test('''
        GIVEN the input is "1 KiB"
        WHEN the file size is parsed
        THEN the result should be 1024 bytes
        ''', () {
      // Arrange
      const String fileSize = "1 KiB";

      // Act
      final int result = FileSize.parse(fileSize).size.toInt();

      // Assert
      expect(result, 1024);
    });

    test('''
        GIVEN the input is "1.2 EiB"
        WHEN the file size is parsed
        THEN the result should be 1383505805528216320 bytes
        ''', () {
      // Arrange
      const String fileSize = "1.2 EiB";

      // Act
      final int result = FileSize.parse(fileSize).size.toInt();

      // Assert
      expect(result, 1383505805528216320);
    });

    test('''
        GIVEN the input is "1.45 gibibytes"
        WHEN the file size is parsed
        THEN the result should be 1556925644 bytes
        ''', () {
      // Arrange
      const String fileSize = "1.45 gibibytes";

      // Act
      final int result = FileSize.parse(fileSize).size.toInt();

      // Assert
      expect(result, 1556925644);
    });
  });

  group("FileSize.toString()", () {
    test('''
        GIVEN the file size is 1000 bytes
        WHEN converting to string using default settings
        THEN the result should be "1000 B"
        ''', () {
      // Arrange
      const int bytes = 1000;

      // Act
      final String result = FileSize.fromBytes(bytes).toString();

      // Assert
      expect(result, "1000 B");
    });

    test('''
        GIVEN the file size is 1024 bytes
        WHEN converting to string using default binary units
        THEN the result should be "1 KiB"
        ''', () {
      // Arrange
      const int bytes = 1024;

      // Act
      final String result = FileSize.fromBytes(bytes).toString();

      // Assert
      expect(result, "1 KiB");
    });

    test('''
        GIVEN the file size is 1243560000 bytes
        WHEN converting to string using default settings
        THEN the result should be "1.158 GiB"
        ''', () {
      // Arrange
      const int bytes = 1243560000;

      // Act
      final String result = FileSize.fromBytes(bytes).toString();

      // Assert
      expect(result, "1.158 GiB");
    });

    test('''
        GIVEN the file size is 1243560000 bytes and metric unit is selected
        WHEN converting to string
        THEN the result should be "1.244 GB"
        ''', () {
      // Arrange
      const int bytes = 1243560000;

      // Act
      final String result = FileSize.fromBytes(bytes).toString(
        unit: Unit.auto(size: bytes, baseType: BaseType.metric),
      );

      // Assert
      expect(result, "1.244 GB");
    });

    test('''
        GIVEN the file size is 1243560000 bytes and decimals are set to 2
        WHEN converting to string
        THEN the result should be "1.16 GiB"
        ''', () {
      // Arrange
      const int bytes = 1243560000;

      // Act
      final String result = FileSize.fromBytes(bytes).toString(decimals: 2);

      // Assert
      expect(result, "1.16 GiB");
    });

    test('''
        GIVEN the file size is 1000 bytes and long format is selected with metric unit
        WHEN converting to string
        THEN the result should be "1 kilobyte"
        ''', () {
      // Arrange
      const int bytes = 1000;

      // Act
      final String result = FileSize.fromBytes(bytes).toString(
        unit: Unit.auto(size: bytes, baseType: BaseType.metric),
        formatType: FormatType.long,
      );

      // Assert
      expect(result, "1 kilobyte");
    });

    test('''
        GIVEN the file size is 5000000 bytes and long format is selected with metric unit
        WHEN converting to string
        THEN the result should be "5 megabytes"
        ''', () {
      // Arrange
      const int bytes = 5000000;

      // Act
      final String result = FileSize.fromBytes(bytes).toString(
        unit: Unit.auto(size: bytes, baseType: BaseType.metric),
        formatType: FormatType.long,
      );

      // Assert
      expect(result, "5 megabytes");
    });

    test('''
        GIVEN the file size is 1024 bytes and long format is selected with binary unit
        WHEN converting to string
        THEN the result should be "1 kibibyte"
        ''', () {
      // Arrange
      const int bytes = 1024;

      // Act
      final String result = FileSize.fromBytes(bytes).toString(
        unit: Unit.auto(size: 1024, baseType: BaseType.binary),
        formatType: FormatType.long,
      );

      // Assert
      expect(result, "1 kibibyte");
    });

    test('''
        GIVEN the file size is 243560000 bytes and gigabyte unit is selected
        WHEN converting to string
        THEN the result should be "0.244 GB"
        ''', () {
      // Arrange
      const int bytes = 243560000;

      // Act
      final String result =
          FileSize.fromBytes(bytes).toString(unit: Unit.gigabyte);

      // Assert
      expect(result, "0.244 GB");
    });
  });

  group("FileSize.toSize()", () {
    test("""
        GIVEN the size is 401.26 gigabytes
        WHEN converting the size to mebibytes
        THEN the result should be 382671.3562011719
        """, () {
      // Arrange
      const num gigabytes = 401.26;

      // Act
      final num result = FileSize.fromUnit(size: gigabytes, unit: Unit.gigabyte)
          .toSize(unit: Unit.mebibyte);

      // Assert
      expect(result, 382671.3562011719);
    });
  });
}
