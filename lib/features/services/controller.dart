import 'package:get/get.dart';
import 'package:smart_city/main.dart';

class ServicesController extends GetxController {
  final RxList categories = [].obs;
  final RxList services = [].obs;

  @override
  onInit() {
    super.onInit();
    fetchCategories();
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

  fetchServices(String categoryId) async {
    services.value = await supabase.from('services').select();
  }

  List<dynamic> getServicesByCategory(String categoryId) {
    return services
        .where((element) =>
            element['category_id'].toString() == categoryId.toString())
        .toList();
  }

  deleteCategory(String id) async {
    await supabase.from('services_categories').delete().eq('id', id);
    await fetchCategories();
  }

  upsertCompany(
      String titleRo,
      String titleRu,
      String categoryId,
      String logo,
      String descriptionRo,
      String descriptionRu,
      String address,
      String phone,
      String website,
      bool isActive) async {
    await supabase.from('services').upsert([
      {
        'type': 'service',
        'title_ro': 'Mancare',
        'title_ru': 'Еда',
        'category_id': '1',
        'logo': 'https://picsum.photos/200/300',
        'description_ro': 'Mancare',
        'description_ru': 'Еда',
        'address': 'Strada',
        'phone': '123123',
        'email': 'email',
        'website': 'website',
        'facebook': 'facebook',
        'instagram': 'instagram',
        'twitter': 'twitter',
        'youtube': 'youtube',
        'linkedin': 'linkedin',
        'lat': 'lat',
        'lng': 'lng',
        'working_hours': 'working_hours',
        'working_days': 'working_days',
        'is_active': true,
      }
    ]);
  }
}
