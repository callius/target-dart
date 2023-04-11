import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:target_annotation_processor/src/model_generator.dart';

Builder modelBuilder(BuilderOptions options) {
  return PartBuilder([ModelGenerator()], '.core.dart');
}
