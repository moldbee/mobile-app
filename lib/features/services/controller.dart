import 'package:get/get.dart';
import 'package:smart_city/main.dart';

class ServicesController extends GetxController {
  final RxList categories = [].obs;
  final RxList services = [].obs;
  final RxList discounts = [].obs;
  final RxList infos = [].obs;
  final RxList alerts = [].obs;

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
    services.value = await supabase.from('services').select('*, category(*)');
  }

  List<dynamic> getServicesByCategory(String categoryId) {
    return services
        .where((element) =>
            element['category']['id'].toString() == categoryId.toString())
        .toList();
  }
}
