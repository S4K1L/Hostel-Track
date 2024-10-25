import 'package:get/get.dart';
import 'package:trackhostel/res/components/bottom_navbar.dart';
import 'package:trackhostel/utils/auth_gate/auth_gate.dart';
import 'package:trackhostel/view/home/home.dart';
import 'package:trackhostel/view/login/login.dart';
import 'package:trackhostel/view/signup/signup.dart';

class RoutesPath {
  static String login = '/login';
  static String signup = '/signup';
  static String home = '/home';
  static String bottomBar = '/bottomBar';
  static String initialization = '/initialization';
}

final pages = [
  GetPage(
    name: RoutesPath.initialization,
    page: () => const AuthGate(),
    transition: Transition.downToUp
  ),
  GetPage(
    name: RoutesPath.login,
    page: () => const LoginPage(),
    transition: Transition.downToUp
  ),
  GetPage(
    name: RoutesPath.signup,
    page: () => const SignUpPage(),
    transition: Transition.rightToLeft
  ),
  GetPage(
    name: RoutesPath.home,
    page: () => const HomePage(),
    transition: Transition.rightToLeft
  ),
  GetPage(
    name: RoutesPath.bottomBar,
    page: () => const UserBottomBar(),
    transition: Transition.rightToLeft
  ),
];
