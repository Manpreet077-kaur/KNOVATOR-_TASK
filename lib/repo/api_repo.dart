import 'package:get/get.dart';
import 'package:knovator_task/model/post_response.dart';

import 'endpoints.dart';

class ApiRepo extends GetConnect{
  Future<List<PostResponse>> getPostData() async {
    try {
      final Response response = await get(Endpoints.postUrl);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.body;
        return jsonData.map((json) => PostResponse.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  Future<PostResponse> getPostDetail(String postId) async {
    try {
      final Response response = await get("${Endpoints.postUrl}/$postId");
      if (response.statusCode == 200) {
        return PostResponse.fromJson(response.body);
      } else {
        return PostResponse();
      }
    } catch (e) {
      print('Error fetching post detail: $e');
      return PostResponse();
    }
  }

}