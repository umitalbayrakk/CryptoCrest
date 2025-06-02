import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/controller/news_controller.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/widgets/appbar/abbar_widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find<NewsController>();
    final bool isLargeScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBarWidgets(),
      body: Obx(() {
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty && controller.newsList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: controller.refreshNews, child: const Text('Yeniden Dene')),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.refreshNews,
          child:
              isLargeScreen
                  ? Row(
                    children: [
                      Expanded(flex: 2, child: buildNewsList(controller, isLargeScreen)),
                      Expanded(flex: 3, child: buildNewsDetail(controller)),
                    ],
                  )
                  : buildNewsList(controller, isLargeScreen),
        );
      }),
    );
  }
  Widget buildNewsList(NewsController controller, bool isLargeScreen) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.newsList.length,
      itemBuilder: (context, index) {
        final news = controller.newsList[index];
        return Card(
          color: AppColors.cardColor1,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading:
                news.imageUrl != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        news.imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80),
                      ),
                    )
                    : const Icon(Icons.image_not_supported, size: 80),
            title: Text(news.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(news.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(
                  'Kaynak: ${news.source ?? "Bilinmiyor"}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text('Yayın: ${news.publishedOn}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: AppColors.textColor),
                  onPressed: () => showNewsDetailBottomSheet(controller),
                  child: Text("Detaylar İçin Tıklayın"),
                ),
              ],
            ),
            onTap: () {
              controller.selectNews(news);
              if (!isLargeScreen) {
                showNewsDetailBottomSheet(controller);
              }
            },
          ),
        );
      },
    );
  }

  Widget buildNewsDetail(NewsController controller) {
    final news = controller.selectedNews.value;
    if (news == null) {
      return const Center(child: Text('Bir haber seçin', style: TextStyle(fontSize: 18)));
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (news.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                news.imageUrl!,
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            news.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.cardColor1),
          ),
          const SizedBox(height: 8),
          Text('Kaynak: ${news.source ?? "Bilinmiyor"}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text('Yayın: ${news.publishedOn}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 16),
          Text(news.body, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          if (news.url != null)
            ElevatedButton(
              onPressed: () async {
                try {
                  final Uri uri = Uri.parse(news.url!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    Get.snackbar('Hata', 'URL açılamadı: ${news.url}');
                  }
                } catch (e) {
                  Get.snackbar('Hata', 'URL açılırken hata oluştu: $e');
                }
              },
              child: const Text('Tam Haberi Oku'),
            ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }

  void showNewsDetailBottomSheet(NewsController controller) {
    final news = controller.selectedNews.value;
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(Get.context!).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child:
            news == null
                ? const Center(child: Text('Bir haber seçin', style: TextStyle(fontSize: 18)))
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (news.imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            news.imageUrl!,
                            height: 200,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        news.title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.cardColor1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kaynak: ${news.source ?? "Bilinmiyor"}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text('Yayın: ${news.publishedOn}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 16),
                      Text(news.body, style: const TextStyle(fontSize: 16, color: AppColors.whiteColor)),
                      const SizedBox(height: 16),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    );
  }
}
