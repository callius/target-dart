import 'package:target/src/raise.dart';

B foldOrThrow<E, A, B>(
  A Function(Raise<E> r) block,
  B Function(E error) recover,
  B Function(A value) transform,
) {
  return fold(block, (it) => throw it, recover, transform);
}

B fold<E, A, B>(
  A Function(Raise<E> r) block,
  B Function(Exception throwable) onCatch,
  B Function(E error) recover,
  B Function(A value) transform,
) {
  final raise = _DefaultRaise<E>();
  try {
    final res = block(raise);
    raise.complete();
    return transform(res);
  } on RaiseCancellationException<E> catch (e) {
    raise.complete();
    return recover(e.raised);
  } on Exception catch (e) {
    raise.complete();
    return onCatch(e);
  }
}

Future<B> foldOrThrowAsync<E, A, B>(
  Future<A> Function(Raise<E> r) block,
  B Function(E error) recover,
  B Function(A value) transform,
) {
  return foldAsync(block, (it) => throw it, recover, transform);
}

Future<B> foldAsync<E, A, B>(
  Future<A> Function(Raise<E> r) block,
  B Function(Exception throwable) onCatch,
  B Function(E error) recover,
  B Function(A value) transform,
) async {
  final raise = _DefaultRaise<E>();
  try {
    final res = await block(raise);
    raise.complete();
    return transform(res);
  } on RaiseCancellationException<E> catch (e) {
    raise.complete();
    return recover(e.raised);
  } on Exception catch (e) {
    raise.complete();
    return onCatch(e);
  }
}

final class _DefaultRaise<E> implements Raise<E> {
  bool _isActive = true;

  bool complete() {
    final result = _isActive;
    _isActive = false;
    return result;
  }

  @override
  Never raise(E r) {
    if (_isActive) {
      throw RaiseCancellationException(raised: r, raise: this);
    } else {
      throw RaiseLeakedError();
    }
  }
}
