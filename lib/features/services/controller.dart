import 'package:get/get.dart';
import 'package:smart_city/main.dart';

class ServicesController extends GetxController {
  final RxList categories = [].obs;
  final RxList services = [].obs;

  @override
  onInit() {
    super.onInit();
    fetchCategories();
    fetchServices();
  }

  fetchCategories() async {
    categories.value = await supabase.from('services_categories').select();
  }

  Future<void> upsertCategory(int icon, String titleRo, String titleRu) async {
    return supabase.from('services_categories').upsert([
      {
        'icon': icon,
        'title_ro': titleRo,
        'title_ru': titleRu,
      }
    ]);
  }

  fetchServices() async {
    services.value = await supabase.from('services').select();
  }

  List<dynamic> getServicesByCategory(String categoryId) {
    return services
        .where((element) =>
            element['category'].toString() == categoryId.toString())
        .toList();
  }

  deleteCategory(String id) async {
    await supabase.from('services_categories').delete().eq('id', id);
    await fetchCategories();
  }
}
