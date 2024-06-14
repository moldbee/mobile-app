import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/no_content.dart';

class CompanyServicesScreen extends HookWidget {
  const CompanyServicesScreen({super.key, this.id});
  final route = '/services/company/service';
  final String? id;

  @override
  Widget build(BuildContext context) {
    final prices = usePreservedState('service-prices', context, null);
    final localize = getAppLoc(context);
    final companyName = usePreservedState('company-name', context, null);

    if (prices.value == null) {
      supabase
          .from('services')
          .select('title_${localize!.localeName}, id')
          .eq('id', id as String)
          .single()
          .then((company) {
        companyName.value = company['title_${localize.localeName}'];

        supabase
            .from('services_prices')
            .select('title_${localize.localeName}, price, service')
            .eq('service', id as String)
            .then((value) {
          return prices.value = value;
        });
      });

      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('${companyName.value} / ${localize!.price_list}'),
        ),
        body: prices.value.length < 1
            ? const NoContent()
            : SingleChildScrollView(
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final priceItem = prices.value[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                                    priceItem['title_${localize.localeName}'])),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.orange.shade400,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                '${priceItem['price']} lei',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .fontSize),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            height: .5,
                            color: Colors.grey.shade300,
                          ),
                        ),
                    itemCount: prices.value.length),
              ));
  }
}
