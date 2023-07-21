import 'package:target/src/raise.dart';

B foldOrThrow<Error, A, B>(
  A Function(Raise<Error> r) block,
  B Function(Error error) recover,
  B Function(A value) transform,
) {
  return fold(block, (it) => throw it, recover, transform);
}

B fold<Error, A, B>(
  A Function(Raise<Error> r) block,
  B Function(Exception throwable) onCatch,
  B Function(Error error) recover,
  B Function(A value) transform,
) {
  final raise = _DefaultRaise<Error>();
  try {
    final res = block(raise);
    raise.complete();
    return transform(res);
  } on RaiseCancellationException<Error> catch (e) {
    raise.complete();
    return recover(e.raised);
  } on Exception catch (e) {
    raise.complete();
    return onCatch(e);
  }
}

Future<B> foldOrThrowAsync<Error, A, B>(
  Future<A> Function(Raise<Error> r) block,
  B Function(Error error) recover,
  B Function(A value) transform,
) {
  return foldAsync(block, (it) => throw it, recover, transform);
}

Future<B> foldAsync<Error, A, B>(
  Future<A> Function(Raise<Error> r) block,
  B Function(Exception throwable) onCatch,
  B Function(Error error) recover,
  B Function(A value) transform,
) async {
  final raise = _DefaultRaise<Error>();
  try {
    final res = await block(raise);
    raise.complete();
    return transform(res);
  } on RaiseCancellationException<Error> catch (e) {
    raise.complete();
    return recover(e.raised);
  } on Exception catch (e) {
    raise.complete();
    return onCatch(e);
  }
}

final class _DefaultRaise<Error> implements Raise<Error> {
  bool _isActive = true;

  bool complete() {
    final result = _isActive;
    _isActive = false;
    return result;
  }

  @override
  Never raise(Error r) {
    if (_isActive) {
      throw RaiseCancellationException(raised: r, raise: this);
    } else {
      throw RaiseLeakedError();
    }
  }
}
