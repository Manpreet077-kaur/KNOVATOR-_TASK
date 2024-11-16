import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knovator_task/repo/api_repo.dart';
import 'Utils/routes/app_pages.dart';
import 'Utils/routes/app_routes.dart';
import 'ui/home/home_screen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding:BindingsBuilder((){
        Get.lazyPut<ApiRepo>(() => ApiRepo(),fenix: true);
      }),
      home:  HomeScreen(),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.homeScreen
    );
  }
}
