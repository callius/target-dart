final class Pair<H, T> {
  const Pair(this.head, this.tail);

  final H head;

  final T tail;

  @override
  bool operator ==(Object other) =>
      other is Pair && head == other.head && tail == other.tail;

  @override
  int get hashCode => head.hashCode & tail.hashCode;
}
