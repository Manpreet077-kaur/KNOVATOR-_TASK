import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_task/utils/color.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../Utils/utils.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Utils.commonText(text: "Home",fontSize:  22,
              fontWeight: FontWeight.w900, textColor: Colors.red),
          leading: Container(),
          leadingWidth: 0.0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20,),

            Expanded(child:
            Obx((){
              return controller.pList.isEmpty?
              Center(
                child: Utils.commonText(text: "No Post!",fontSize:  14,
                    fontWeight: FontWeight.bold, textColor: Colors.green),
              ):
              ListView.builder(itemCount: controller.pList.length,
                  itemBuilder: (BuildContext context, int index){
                    return  VisibilityDetector(
                      key: Key('$index'),
                      onVisibilityChanged: (info) {
                        if (info.visibleFraction > 0) {
                          controller.startTimer(index);
                        } else {
                          controller.pauseTimer(index);
                        }
                      },
                      child: GestureDetector(
                        onTap: (){
                          controller.onPostClick(index);
                        },
                        child: Obx((){
                         return Container(padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: controller.getColor(index),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColor.grey)
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Utils.commonText(text: "${controller.pList[index].title}",fontSize:  14,
                                      fontWeight: FontWeight.bold, textColor: Colors.green),
                                ),
                                if(controller.timerDurations.isNotEmpty)...[
                                  Utils.commonText(text: '${controller.timerDurations[index]}s',fontSize:  14,
                                      fontWeight: FontWeight.bold, textColor: Colors.red),
                                  Icon(Icons.timer,size: 18,color: AppColor.grey,)
                                ]
                              ],
                            ),
                          );
                        })
                      ),
                    );
                  });
            })
            )
          ],
        ),
      ),
    );
  }
}
