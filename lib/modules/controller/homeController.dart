import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  RxList newsList = [].obs;
  RxBool isLoading = false.obs;

  final Dio _dio = Dio();

  @override
  void onInit() {
    getNews();
    super.onInit();
  }

  Future<void> getNews() async {
    try {
      isLoading.value = true;
      const api =
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=01cebf0a199545898d07866373b49733";

      final response = await _dio.get(api);

      if (response.statusCode == 200) {
        List allArticles = response.data["articles"];

        newsList.value = allArticles
            .where((article) =>
                article["title"] != null && article["title"] != "[Removed]")
            .toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load news: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
