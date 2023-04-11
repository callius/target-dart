import 'package:target_extension/src/target_type_extensions.dart';

List<T> buildList<T>(void Function(List<T> it) builder) {
  return <T>[].also(builder);
}
