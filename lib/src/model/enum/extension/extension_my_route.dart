import '../my_route.dart';

extension ToString on MyRoute {
  String get stringDefinition {
    switch (this) {
      case MyRoute.home:
        return '/home';
      case MyRoute.inventory:
        return '/inventory';
      case MyRoute.search:
        return '/search';
      case MyRoute.sale:
        return '/sale';
      case MyRoute.addGold:
        return '/addGold';
      default:
        return 'Unknown route';
    }
  }
}
