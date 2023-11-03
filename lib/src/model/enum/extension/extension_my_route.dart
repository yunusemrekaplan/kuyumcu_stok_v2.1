import '../my_route.dart';

extension ToString on MyRoute {
  String get stringDefinition {
    switch (this) {
      case MyRoute.home:
        return '/home';
      case MyRoute.inventory:
        return '/inventory';
      default:
        return 'Unknown route';
    }
  }
}
