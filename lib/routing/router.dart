import 'package:drinks_app/presentation/screens/get_started_screen.dart';
import 'package:drinks_app/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.getStarted.routeName,
  routes: [
    GoRoute(path: NamedRoutes.getStarted.routeName, builder: (ctx, state) => const GetStartedScreen()),
    GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen()),
  ],
);

enum NamedRoutes {
  getStarted('/getStarted'),
  home('/home');

  final String routeName;
  const NamedRoutes(this.routeName);
}
