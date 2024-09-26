library;

import 'database_format_test.dart' as database_format_test;
import 'database_impl_format_test.dart' as database_impl_format_test;
import 'database_import_export_test.dart' as database_import_export_test;
import 'database_perf_test.dart' as database_perf_test;
import 'src_file_system_test.dart' as src_file_system_test;
import 'test_common.dart';
import 'transaction_impl_test.dart' as transaction_impl_test;

// default use memory
void main() {
  defineFileSystemTests(memoryFileSystemContext);
  defineTests(memoryDatabaseContext);
}

void defineFileSystemTests(FileSystemTestContext ctx) {
  src_file_system_test.defineFileSystemTests(ctx);
  database_format_test.defineTestsWithCodec(ctx);
  database_format_test.defineDatabaseFormatTests(ctx);
  database_impl_format_test.defineTests(ctx);
}

void defineTests(DatabaseTestContext ctx) {
  database_perf_test.defineTests(ctx, 10);
  transaction_impl_test.defineTests(ctx);
  database_import_export_test.defineTests(ctx);
}
