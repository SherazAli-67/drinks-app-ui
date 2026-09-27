import 'package:drinks_app/presentation/screens/get_started_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.getStarted.routeName,
  routes: [
    GoRoute(path: NamedRoutes.getStarted.routeName, builder: (ctx,state) => GetStartedScreen())
  ],
);

enum NamedRoutes {
  getStarted('/getStarted');

  final String routeName;
  const NamedRoutes(this.routeName);
}