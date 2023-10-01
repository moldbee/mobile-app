import 'package:get/get.dart';
import 'package:smart_city/main.dart';

class NewsController extends GetxController {
  RxList<dynamic> news = <dynamic>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchNews();
  }

  Future<dynamic> fetchNews() async {
    try {
      isLoading.value = true;
      news.value = await supabase.from('news').select();
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> createNew(Map<String, dynamic> data) async {
    await supabase.from('news').insert(data);
    await fetchNews();
  }

  Future<void> updateNew(String? id, Map<String, dynamic> data) async {
    await supabase.from('news').update(data).eq('id', id);
    await fetchNews();
  }

  Future<dynamic> deleteNew(String? id) async {
    await supabase.from('news').delete().eq('id', id);
    await fetchNews();
  }
}
