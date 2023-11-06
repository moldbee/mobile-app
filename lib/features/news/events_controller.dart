import 'package:get/get.dart';
import 'package:smart_city/main.dart';

class EventsController extends GetxController {
  RxList<dynamic> events = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchEvents();
  }

  List<dynamic> get sortedByTimeEvents {
    final filteredEvents = events.toList().where(
        (element) => DateTime.parse(element['date']).isAfter(DateTime.now()));
    return filteredEvents.toList()
      ..sort((a, b) =>
          DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
  }

  Future<dynamic> fetchEvents() async {
    final events = await supabase.from('events').select();
    this.events.value = events;
  }

  Future<dynamic> createEvent(Map<String, dynamic> data) async {
    await supabase.from('events').insert(data);
    await fetchEvents();
  }

  Future<void> updateEvent(String? id, Map<String, dynamic> data) async {
    await supabase.from('events').update(data).eq('id', id);
    await fetchEvents();
  }

  Future<dynamic> deleteEvent(String? id) async {
    await supabase.from('events').delete().eq('id', id);
    await fetchEvents();
  }
}
