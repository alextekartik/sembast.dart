@TestOn('vm')
library;

import 'package:idb_shim/idb_io.dart';
import 'package:sembast_test/all_jdb_test.dart' as all_jdb_test;
import 'package:sembast_test/all_test.dart';
import 'package:sembast_test/jdb_test_common.dart';
import 'package:sembast_test/src/import_jdb.dart';
import 'package:sembast_test/test_common.dart';
import 'package:sembast_web/src/jdb_factory_idb.dart';
import 'package:test/test.dart';

var testPath = '.dart_tool/sembast_test/idb/databases';

Future main() async {
  var jdbFactory = JdbFactoryIdb(getIdbFactorySembastIo(testPath));
  var factory = DatabaseFactoryJdb(jdbFactory);

  var testContext = DatabaseTestContextJdb()..factory = factory;

  group('idb_io', () {
    defineTests(testContext);
    all_jdb_test.defineJdbTests(testContext);
  });
}
