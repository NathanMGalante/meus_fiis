import 'dart:async';

import 'package:meus_fiis/shared/n_utils/utils/n_durations.dart';

class NDebounce {
  NDebounce._();

  static final NDebounce _instance = NDebounce._();

  final Map<String, _NDebounceItem> _map = {};

  factory NDebounce() {
    return _instance;
  }

  static Future<T> run<T>(String key, FutureOr<T> Function() callback,
      [Duration duration = NDurations.n1second]) async {
    if (_instance._map.containsKey(key)) {
      if (_instance._map[key]!.timer.isActive) {
        _instance._map[key]!.timer.cancel();
      }
      final completer = _instance._map[key]!.completer;
      _instance._map[key]!.timer =
          _getTimer(duration, callback, completer, key);
    } else {
      final completer = Completer<T>();
      final timer = _getTimer(duration, callback, completer, key);
      _instance._map[key] = _NDebounceItem(timer, completer);
    }
    return await _instance._map[key]!.completer.future;
  }

  static Timer _getTimer<T>(
    Duration duration,
    FutureOr<T> Function() callback,
    Completer<T> completer,
    String key,
  ) {
    return Timer(duration, () async {
      try {
        completer.complete(await callback());
      } catch (ex) {
        completer.completeError(ex);
      }
      _instance._map.remove(key);
    });
  }
}

class _NDebounceItem<T> {
  _NDebounceItem(this.timer, this.completer);

  Timer timer;
  Completer<T> completer;
}
