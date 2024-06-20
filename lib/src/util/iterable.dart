extension IterableExtension<T> on Iterable<T> {
  Iterable<T> intersperse(T separator) {
    return expand((item) sync* {
      yield separator;
      yield item;
    }).skip(1);
  }
}

extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String? name) {
    for (final value in this) {
      if (value.name == name) return value;
    }

    return null;
  }
}
