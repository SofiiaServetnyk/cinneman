import 'package:cinneman/navigation/app_routes.dart';

class NavigationState {
  final List<RouteConfig> _stack;
  List<RouteConfig> get stack => _stack;

  NavigationState({required List<RouteConfig> stack}) : _stack = stack;

  bool canPop() {
    return _stack.length > 1;
  }

  NavigationState pop() {
    if (canPop()) _stack.remove(_stack.last);
    return NavigationState(stack: _stack);
  }

  NavigationState pushBeneathCurrent(RouteConfig config) {
    _stack.insert(_stack.length - 1, config);
    return NavigationState(stack: _stack);
  }

  NavigationState push(RouteConfig config) {
    if (_stack.last != config) _stack.add(config);

    return NavigationState(stack: _stack);
  }

  NavigationState replace(RouteConfig config) {
    if (canPop()) {
      _stack.removeLast();
      push(config);
    } else {
      _stack.insert(0, config);
      _stack.removeLast();
    }

    return NavigationState(stack: _stack);
  }

  NavigationState clearAndPush(RouteConfig config) {
    _stack.clear();
    _stack.add(config);

    return NavigationState(stack: _stack);
  }

  NavigationState clearAndPushAll(List<RouteConfig> configs) {
    _stack.clear();
    _stack.addAll(configs);

    return NavigationState(stack: _stack);
  }
}
