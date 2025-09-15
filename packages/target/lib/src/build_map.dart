import 'package:target/src/type_extensions.dart';

Map<K, V> buildMap<K, V>(void Function(Map<K, V> it) builder) {
  return <K, V>{}.also(builder);
}
