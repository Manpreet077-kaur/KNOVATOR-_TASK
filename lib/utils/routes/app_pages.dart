import 'package:get/get.dart';
import '../../ui/home/home_controller.dart';
import '../../ui/home/home_detail.dart';
import '../../ui/home/home_screen.dart';
import 'app_routes.dart';

abstract class AppPages{

  static final pages=[

    GetPage(name: AppRoutes.homeScreen, page: ()=> HomeScreen(),
    binding: BindingsBuilder(()=>Get.lazyPut(() => HomeController()))),
    GetPage(name: AppRoutes.homeDetail, page: ()=> HomeDetail(),
    binding: BindingsBuilder(()=>Get.lazyPut(() => HomeController()))),


  ];
}