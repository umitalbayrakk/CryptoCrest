import 'package:flutter_cryptocrest_app/model/news_model/news_model.dart';
import 'package:flutter_cryptocrest_app/service/news_service/news_service.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final ApiService _apiService = ApiService();
  var newsList = <NewsModel>[].obs;
  var selectedNews = Rxn<NewsModel>(); 
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  Future<void> fetchNews() async {
    try {
      isLoading(true);
      errorMessage('');
      final news = await _apiService.fetchNews();
      newsList.assignAll(news);
    } catch (e) {
      errorMessage(e.toString());
      Get.snackbar('Hata', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void selectNews(NewsModel? news) {
    selectedNews.value = news;
  }

  Future<void> refreshNews() async {
    selectedNews.value = null; 
    await fetchNews();
  }
}
