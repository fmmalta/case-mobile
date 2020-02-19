import 'package:flutter/cupertino.dart';

final NavigationService navigationService = NavigationService();

class NavigationService {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String route, {dynamic args}) async {
    return await navKey.currentState.pushNamed(route, arguments: args);
  }

  bool goBack({dynamic args}) => navKey.currentState.pop(args);
}
