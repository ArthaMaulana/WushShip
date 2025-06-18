import 'package:flutter/foundation.dart';
import '../models/counter_model.dart';

class CounterProvider with ChangeNotifier {
  final CounterModel _counter = CounterModel();

  int get count => _counter.count;

  void increment() {
    _counter.increment();
    notifyListeners();
  }

  void decrement() {
    _counter.decrement();
    notifyListeners();
  }

  void reset() {
    _counter.reset();
    notifyListeners();
  }
}
