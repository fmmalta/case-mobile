import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/features/movies/presentation/pages/detailed_movie/detailed_movie_page.dart';
import 'package:vitta_case_mobile/features/movies/presentation/pages/home_page/home_page.dart';

class FadeRoute extends PageRouteBuilder<void> {
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation, child: child),
        );
  final Widget page;
}

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return FadeRoute(page: HomePage());
      case '/detail_page':
        return FadeRoute(
            page: DetailedMoviePage(
          detailedMovieParams: settings.arguments,
        ));
      default:
        return null;
    }
  }
}
