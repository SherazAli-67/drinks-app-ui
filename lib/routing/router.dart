import 'package:drinks_app/presentation/screens/drink_detail_screen.dart';
import 'package:drinks_app/presentation/screens/get_started_screen.dart';
import 'package:drinks_app/presentation/screens/home_screen.dart';
import 'package:drinks_app/providers/drink_detail_provider.dart';
import 'package:drinks_app/providers/home_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.getStarted.routeName,
  routes: [
    GoRoute(path: NamedRoutes.getStarted.routeName, builder: (ctx, state) => const GetStartedScreen()),
    GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => ChangeNotifierProvider(
        create: (_)=> HomeProvider(),
        child: const HomeScreen())),
    GoRoute(
      path: '${NamedRoutes.drinkDetail.routeName}/:id',
      builder: (ctx, state) => ChangeNotifierProvider(
          create: (_)=> DrinkDetailProvider(state.pathParameters['id']!),
          child: DrinkDetailScreen()),
    ),
  ],
);

enum NamedRoutes {
  getStarted('/getStarted'),
  home('/home'),
  drinkDetail('/drink');

  final String routeName;
  const NamedRoutes(this.routeName);
}
