library;

// basically same as the io runner but with extra output
// ignore_for_file: implementation_imports
import 'package:sembast/src/database_impl.dart';

import 'test_common.dart';

void main() {
  defineTests(memoryDatabaseContext);
}

void defineTests(DatabaseTestContext ctx) {
  var factory = ctx.factory;
  group('key', () {
    late Database db;

    setUp(() async {
      db = await setupForTest(ctx, 'key.db');
    });

    tearDown(() {
      return db.close();
    });

    test('dynamic', () async {
      var store = StoreRef<Object?, Object?>.main();
      print(store.runtimeType);
      var key = await store.add(db, 'test');
      expect(key, 1);
      key = await store.add(db, 'test') as int;
      expect(key, 2);
    }, skip: 'No longer working with the new Key and Value type');

    test('dynamic_rounded', () async {
      var store = StoreRef<Object?, Object?>.main();
      var value = await store.record(2.0).put(db, 'test');
      expect(value, 'test');
      expect((await store.findFirst(db))!.key, 2.0);
      expect(await store.record(2.0).get(db), 'test');
      // next will increment (or restart from 1 in js
      final intKey = await store.add(db, 'test') as int;
      if (isJavascriptVm) {
        if (hasStorageJdb(factory)) {
          expect(intKey, 1);
        } else {
          expect(intKey, 3);
        }
      } else {
        expect(intKey, 1);
      }
    }, skip: 'No longer working with the new Key and Value type');

    test('int', () async {
      var store = StoreRef<int, String>.main();
      var value = await store.record(2).put(db, 'test');
      expect(value, 'test');
      // next will increment
      var key = await store.add(db, 'test');
      if (hasStorageJdb(factory)) {
        expect(key, 1);
      } else {
        expect(key, 3);
        // Tweak to restart from 1 and make sure the existing keys are skipped
        (db as SembastDatabase).mainStore!.lastIntKey = 0;
      }
      key = await store.add(db, 'test');
      if (hasStorageJdb(factory)) {
        expect(key, 3);
      } else {
        expect(key, 1);
      }
      // test in transaction
      await db.transaction((txn) async {
        key = await store.add(txn, 'test');
        expect(key, 4);
        key = await store.add(txn, 'test');
        expect(key, 5);
      });
      key = await store.add(db, 'test');
      expect(key, 6);
    });

    test('string', () async {
      var store = StoreRef<String, String>.main();
      var key = await store.add(db, 'test');
      expect(key, const TypeMatcher<String>());
      key = await store.add(db, 'test');
      expect(key, const TypeMatcher<String>());
      expect(await store.count(db), 2);
      /*
      String key = await db.put('test', 'key1') as String;
      expect(key, 'key1');
      // next will increment
      int key1 = await db.put('test') as int;
      expect(key1, 1);
      */
    });

    test('double', () async {
      var store = StoreRef<double, String>.main();
      await store.record(1.2).put(db, 'test');
      expect(await store.record(1.2).get(db), 'test');
      try {
        var key = await store.add(db, 'test');
        if (isJavascriptVm) {
          expect(key, 1);
        } else {
          fail('should fail');
        }
      } on ArgumentError catch (_) {}
    });
  });
}
