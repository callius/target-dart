import 'package:source_gen_test/source_gen_test.dart';
import 'package:target_annotation/target_annotation.dart';
import 'package:target_annotation_processor/src/model_generator.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  Future<void> testDirectoryFile(String directory, String file) async {
    testAnnotatedElements<Validatable>(
      await initializeLibraryReaderForDirectory(directory, file),
      ModelGenerator(),
    );
  }

  Future<void> testFile(String file) {
    return testDirectoryFile('test/source_gen_src', file);
  }

  await testFile('test_nested_model.dart');
  await testFile('test_nullable_nested_model.dart');
}
