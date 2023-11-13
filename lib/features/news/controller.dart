import 'package:get/get.dart';
import 'package:smart_city/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsController extends GetxController {
  RxList<dynamic> news = <dynamic>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasReachedMax = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  List<dynamic> get sortedByTimeNews {
    return news.toList()
      ..sort((a, b) => DateTime.parse(b['created_at'])
          .compareTo(DateTime.parse(a['created_at'])));
  }

  Future<dynamic> fetchNews({int start = 0, int end = 10}) async {
    try {
      isLoading.value = true;
      final newNews = await supabase.from('news').select().range(start, end);
      if (newNews.length == 0) {
        return hasReachedMax.value = true;
      }
      news.addAll(newNews);
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> refetchNews() async {
    try {
      hasReachedMax.value = false;
      isLoading.value = true;
      final newNews = await supabase.from('news').select().range(0, 10);
      news.value = newNews;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> getHasLiked(String commentId, String? userId) async {
    if (userId == null) {
      return false;
    }
    final res = await supabase
        .from('news_comments_likes')
        .select()
        .eq('comment', commentId)
        .eq('user', userId);
    return res.length > 0;
  }

  Future<dynamic> getLikesForComment(String commentId) async {
    return await supabase
        .from('news_comments_likes')
        .select('*', const FetchOptions(count: CountOption.exact))
        .eq('comment', commentId);
  }

  Future<void> toggleLike(String commentId, String? userId) async {
    if (userId == null) {
      return;
    }
    final bool isLikeExisting = await getHasLiked(commentId, userId);

    if (isLikeExisting) {
      await supabase
          .from('news_comments_likes')
          .delete()
          .eq('user', userId)
          .eq('comment', commentId);
    } else {
      await supabase
          .from('news_comments_likes')
          .insert({'user': userId, 'comment': commentId});
    }
  }

  Future<dynamic> fetchCommentsForNew(String? newId) async {
    final res = await supabase
        .from('news_comments')
        .select(
            'id, created_at, created_by: created_by(nick, id, avatar), message, new_id, reply_comment_id, likes')
        .eq('new_id', newId)
        .order('created_at', ascending: true);
    (res);
    return res;
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
