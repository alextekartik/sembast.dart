import 'package:sembast/utils/type_adapter.dart';
import 'package:test/test.dart';

void main() {
  group('type_adapters', () {
    test('public', () {
      // ignore: unnecessary_statements
      SembastTypeAdapter;
      // ignore: unnecessary_statements
      JsonEncodableCodec;
      // ignore: unnecessary_statements
      JsonEncodableEncoder;
      // ignore: unnecessary_statements
      JsonEncodableDecoder;
      // ignore: unnecessary_statements
      sembastDefaultJsonEncodableCodec;
    });
  });
}
