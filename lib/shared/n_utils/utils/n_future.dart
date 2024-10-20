import 'dart:async';

extension FutureOrExtension<T> on FutureOr<T> {
  Future<T> get future {
    return this is T ? Future.value(this as T) : this as Future<T>;
  }
}
