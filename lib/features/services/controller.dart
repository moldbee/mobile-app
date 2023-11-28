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
    fetchAlerts();
    fetchDiscounts();
    fetchInfos();
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
    services.value =
        await supabase.from('services').select('*, category: category(*)');
  }

  List<dynamic> getServicesByCategory(String categoryId) {
    return services
        .where((element) =>
            element['category']['id'].toString() == categoryId.toString())
        .toList();
  }

  Future<void> upsertDiscount(String serviceId, String descRu, String descRo,
      String startDate, String endDate, String? id) async {
    dynamic payload = {
      'service': serviceId,
      'description_ru': descRu,
      'description_ro': descRo,
      'start_date': startDate,
      'end_date': endDate,
    };

    if (id != null) {
      payload['id'] = id;
    }
    await supabase.from('services_discounts').upsert(payload);
  }

  Future<void> upsertAlert(String serviceId, String descRu, String descRo,
      String startDate, String endDate, String? id) async {
    dynamic payload = {
      'service': serviceId,
      'description_ru': descRu,
      'description_ro': descRo,
      'start_date': startDate,
      'end_date': endDate,
    };

    if (id != null) {
      payload['id'] = id;
    }
    await supabase.from('services_alerts').upsert(payload);
  }

  Future<void> upsertInfo(String serviceId, String descRu, String descRo,
      String startDate, String endDate, String? id) async {
    dynamic payload = {
      'service': serviceId,
      'description_ru': descRu,
      'description_ro': descRo,
      'start_date': startDate,
      'end_date': endDate,
    };

    if (id != null) {
      payload['id'] = id;
    }
    await supabase.from('services_infos').upsert(payload);
  }

  Future<dynamic> fetchDiscounts() async {
    discounts.value = await supabase.from('services_discounts').select();
  }

  Future<dynamic> fetchAlerts() async {
    alerts.value = await supabase.from('services_alerts').select();
  }

  Future<dynamic> fetchInfos() async {
    infos.value = await supabase.from('services_infos').select();
  }

  getDiscountsForService(String serviceId) {
    return discounts
        .where((discount) => discount['service'].toString() == serviceId);
  }

  getAlertsForService(String serviceId) {
    return alerts.where((alert) => alert['service'].toString() == serviceId);
  }

  getInfosForService(String serviceId) {
    return infos.where((info) => info['service'].toString() == serviceId);
  }

  deleteCategory(String id) async {
    await supabase.from('services_categories').delete().eq('id', id);
    await fetchCategories();
  }
}
