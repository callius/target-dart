import 'package:target_extension/src/target_type_extensions.dart';

Map<K, V> buildMap<K, V>(void Function(Map<K, V> it) builder) {
  return <K, V>{}.also(builder);
}
