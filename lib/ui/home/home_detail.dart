import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_task/utils/color.dart';
import '../../utils/utils.dart';
import 'home_controller.dart';

class HomeDetail extends StatelessWidget {
  HomeDetail({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    String postId = Get.arguments[0];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPostDetail(postId);
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Utils.commonText(
            text: "Home Detail",
            fontSize: 22,
            fontWeight: FontWeight.w900,
            textColor: Colors.red,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Obx(() {
              return controller.postDetail.value == null
                  ? const SizedBox()
                  : Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 12),
                color: AppColor.yellow,
                child: Utils.commonText(
                  text: "${controller.postDetail.value!.body}",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  textColor: Colors.black,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
