import '../enum/my_route.dart';

extension ToString on RouteName {
  String get stringDefinition {
    switch (this) {
      case RouteName.home:
        return '/home';
      case RouteName.inventory:
        return '/inventory';
      case RouteName.gold:
        return '/gold';
      case RouteName.search:
        return '/search';
      case RouteName.sale:
        return '/sale';
      case RouteName.sales:
        return '/sales';
      case RouteName.entries:
        return '/entries';
      case RouteName.addGold:
        return '/addGold';
      default:
        return 'Unknown route';
    }
  }
}
