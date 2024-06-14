import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart_city/l10n/main.dart';
import 'package:smart_city/main.dart';
import 'package:smart_city/shared/hooks/use_preserved_state.dart';
import 'package:smart_city/shared/widgets/no_content.dart';

class CompanyFaqScreen extends HookWidget {
  const CompanyFaqScreen({super.key, this.id});
  final route = '/services/company/faq';
  final String? id;

  @override
  Widget build(BuildContext context) {
    final faqs = usePreservedState('service-faqs', context, null);
    final localize = getAppLoc(context);
    final companyName = usePreservedState('company-name', context, null);

    if (faqs.value == null) {
      supabase
          .from('services')
          .select('title_${localize!.localeName}, id')
          .eq('id', id as String)
          .single()
          .then((company) {
        companyName.value = company['title_${localize.localeName}'];

        supabase
            .from('services_faqs')
            .select(
                'question_${localize.localeName}, answer_${localize.localeName}, service, id')
            .eq('service', id as int)
            .then((value) {
          return faqs.value = value;
        });
      });

      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${companyName.value} / FAQ'),
      ),
      body: faqs.value?.length < 1
          ? const NoContent()
          : Accordion(
              paddingListTop: 12,
              rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
              maxOpenSections: 1,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              headerBorderWidth: .5,
              headerBorderColor: Colors.grey.shade400,
              headerBorderColorOpened: Colors.grey.shade400,
              contentBorderColor: Colors.grey.shade400,
              contentBorderWidth: .5,
              headerBackgroundColor: Colors.transparent,
              scaleWhenAnimating: false,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.none,
              children: faqs.value
                  .map<AccordionSection>((faq) => getItem(
                      question: faq['question_${localize!.localeName}'],
                      answer: faq['answer_${localize.localeName}']))
                  .toList(),
            ),
    );
  }
}

AccordionSection getItem({question, answer}) {
  return AccordionSection(
    header: Text(
      question,
      style:
          TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w500),
    ),
    content: Row(
      children: [
        Expanded(
          child: Text(
            answer,
            textAlign: TextAlign.left,
          ),
        )
      ],
    ),
  );
}
