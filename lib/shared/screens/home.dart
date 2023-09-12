import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_city/features/news/screens/news.dart';
import 'package:smart_city/features/profile/screens/profile.dart';
import 'package:smart_city/features/services/screens/services.dart';
import 'package:smart_city/features/settings/screens/settings.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key, this.pageViewController, this.index})
      : super(key: key);
  final String route = '/';
  final PageController? pageViewController;
  final int? index;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      pageViewController?.animateToPage(index!,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);

      return null;
    }, [index]);

    return PageView(
      children: const [
        NewsScreen(),
        ServicesScreen(),
        ProfileScreen(),
        SettingsScreen(),
      ],
    );
  }
}
