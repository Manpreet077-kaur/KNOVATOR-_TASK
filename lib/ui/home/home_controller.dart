import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knovator_task/model/post_response.dart';
import 'package:knovator_task/utils/utils.dart';
import '../../repo/api_repo.dart';
import '../../utils/color.dart';
import '../../utils/routes/app_routes.dart';

class HomeController extends GetxController {
  ApiRepo apiRepo = ApiRepo();
  RxList<PostResponse> pList = <PostResponse>[].obs;
  Rx<PostResponse?> postDetail = Rx<PostResponse?>(null);
  Rxn selectedIndex = Rxn(null);
  final RxList<int> timerDurations = <int>[].obs;
  final RxMap<int, Stopwatch> stopwatches = <int, Stopwatch>{}.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPostsFromLocalStorage();
      _syncWithApi();
    });
  }

  // Load posts from GetStorage
  void _loadPostsFromLocalStorage() {
    List<dynamic> postsFromStorage = box.read('posts') ?? [];
    if (postsFromStorage.isNotEmpty) {
      List<PostResponse> posts = postsFromStorage
          .map((postJson) => PostResponse.fromJson(postJson))
          .toList();
      pList.assignAll(posts);
    }
  }

  // Sync data with the API and update GetStorage
  void _syncWithApi() async {
    try {
      launchProgress();
      await apiRepo.getPostData().then((response) {
        if (response.isNotEmpty) {
          List<dynamic> jsonResponse = jsonDecode(jsonEncode(response));
          List<PostResponse> posts =
              jsonResponse.map((e) => PostResponse.fromJson(e)).toList();
          box.write('posts', posts);
          pList.assignAll(posts);
          for (int i = 0; i < pList.length; i++) {
            timerDurations.add((10 + (i * 5)) % 30);
            stopwatches[i] = Stopwatch();
          }
          disposeProgress();
        }
      });
    } catch (e) {
      print('Error syncing data with API: $e');
    }
  }

  getPostDetail(String postId) async {
    try {
      launchProgress();
      postDetail.value = null;
      await apiRepo.getPostDetail(postId).then((response) {
        postDetail.value = response;
        disposeProgress();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  //start timer
  void startTimer(int index) {
    stopwatches[index]?.start();
    updateTimer(index);
  }

  //pause the timer
  void pauseTimer(int index) {
    stopwatches[index]?.stop();
  }

  //update the timer
  void updateTimer(int index) {
    Future.delayed(const Duration(seconds: 1), () {
      if (stopwatches[index]?.isRunning == true && timerDurations[index] > 0) {
        timerDurations[index] = timerDurations[index] - 1;
        if (timerDurations[index] > 0) {
          updateTimer(index);
        } else {
          stopwatches[index]?.stop();
        }
      }
    });
  }

  onPostClick(int index) {
    selectedIndex.value = index;
    pauseTimer(index);
    Get.toNamed(AppRoutes.homeDetail, arguments: [pList[index].id.toString()]);
  }

  Color getColor(int index) {
    if (selectedIndex.value == index) {
      return AppColor.white;
    } else {
      return AppColor.yellow;
    }
  }
}
