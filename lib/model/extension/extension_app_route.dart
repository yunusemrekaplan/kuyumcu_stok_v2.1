import '../enum/app_route.dart';

extension ToString on AppRoute {
  String get stringDefinition {
    switch (this) {
      case AppRoute.home:
        return '/home';
      case AppRoute.inventory:
        return '/inventory';
      case AppRoute.gold:
        return '/gold';
      case AppRoute.search:
        return '/search';
      case AppRoute.calculator:
        return '/calculator';
      case AppRoute.sale:
        return '/sale';
      case AppRoute.sales:
        return '/sales';
      case AppRoute.entries:
        return '/entries';
      case AppRoute.addGold:
        return '/addGold';
      default:
        return 'Unknown route';
    }
  }
}
