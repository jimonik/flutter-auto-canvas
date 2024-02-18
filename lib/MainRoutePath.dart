import 'package:custompaint/page/main/binding.dart';
import 'package:custompaint/page/main/view.dart';
import 'package:get/get.dart';

class MainRoutePath {
  static var main = "/main";
  static List<GetPage> get pages => [
        GetPage(
            name: main, page: () => const MainPage(), binding: MainBinding()),
      ];
}
