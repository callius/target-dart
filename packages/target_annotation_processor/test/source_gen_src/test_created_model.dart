import 'package:source_gen_test/source_gen_test.dart';
import 'package:target/target.dart';
import 'package:target_annotation/target_annotation.dart';

@ShouldGenerate(
  r'''
// Generated code. Do not modify by hand.

// ignore_for_file: require_trailing_commas, unused_element

@freezed
class Test with _$Test {
  const factory Test({
    required PositiveInt id,
    required PositiveInt field,
    required DateTime created,
  }) = _Test;

  static Either<ValueFailure<dynamic>, Test> of({
    required int id,
    required int field,
    required DateTime created,
  }) {
    return PositiveInt.of(id).fold(
      Left.new,
      (vId) => PositiveInt.of(field).map((vField) => Test(
            id: vId,
            field: vField,
            created: created,
          )),
    );
  }
}

@freezed
class TestParams with _$TestParams {
  const factory TestParams({required PositiveInt field}) = _TestParams;

  static Either<ValueFailure<dynamic>, TestParams> of({required int field}) {
    return PositiveInt.of(field).map((vField) => TestParams(field: vField));
  }
}

@freezed
class TestBuilder with _$TestBuilder implements Buildable<TestParams> {
  const factory TestBuilder({required Option<PositiveInt> field}) =
      _TestBuilder;

  factory TestBuilder.only({Option<PositiveInt> field = const None()}) {
    return TestBuilder(field: field);
  }

  const TestBuilder._();

  static Either<ValueFailure<dynamic>, TestBuilder> of(
      {required Option<int> field}) {
    return (PositiveInt.of.option(field))
        .map((vField) => TestBuilder(field: vField));
  }

  @override
  Option<TestParams> build() {
    return field.map((vField) => TestParams(field: vField));
  }
}
''',
)
@hasCreated
@ModelTemplate('Test')
abstract class TestModel {
  @extern
  PositiveInt get id;

  PositiveInt get field;
}
