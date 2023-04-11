import 'package:code_builder/code_builder.dart';

const _kParamsSuffix = 'Params';
const _kBuilderSuffix = 'Builder';

extension CoreTypeReferenceExtension on TypeReference {
  TypeReference appendParams() {
    return (toBuilder()..symbol = '$symbol$_kParamsSuffix').build();
  }

  TypeReference appendBuilder() {
    return (toBuilder()..symbol = '$symbol$_kBuilderSuffix').build();
  }
}
