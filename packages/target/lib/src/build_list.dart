import 'package:target/src/type_extensions.dart';

List<T> buildList<T>(void Function(List<T> it) builder) {
  return <T>[].also(builder);
}
