import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyFaqScreen extends StatelessWidget {
  const CompanyFaqScreen({Key? key, this.id}) : super(key: key);
  final route = '/services/company/faq';
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ / Metro'),
      ),
      body: Accordion(
        rightIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        maxOpenSections: 1,
        headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        headerBorderWidth: .5,
        headerBorderColor: Colors.grey.shade400,
        headerBorderColorOpened: Colors.grey.shade400,
        contentBorderColor: Colors.grey.shade400,
        contentBorderWidth: .5,
        headerBackgroundColor: Colors.transparent,
        scaleWhenAnimating: false,
        scrollIntoViewOfItems: ScrollIntoViewOfItems.none,
        children: List.generate(20, (index) => index)
            .map(
              (e) => getItem(
                  answer:
                      'Метро — это международная сеть магазинов, предлагающая широкий ассортимент товаров для дома, одежды и обуви, а также товаров для детей и спорта. Мы предлагаем товары для всей семьи по доступным ценам.',
                  question: 'Что такое Метро?'),
            )
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
    content: Text(answer),
  );
}
