import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({Key? key, this.logoUrl, this.title})
      : super(key: key);
  final String route = '/service/details';

  final String? logoUrl;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        titleTextStyle: TextStyle(
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w600,
            fontSize: 22),
        backgroundColor: Colors.grey.shade200,
        title: Text(title as String),
        actions: [
          IconButton(
            icon: Image.asset(
              logoUrl as String,
              fit: BoxFit.fill,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text('Химчистка',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800)),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        runAlignment: WrapAlignment.center,
                        children: [
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.green.shade600)),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.phone_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.orange.shade400)),
                              onPressed: () async {
                                await Clipboard.setData(
                                    const ClipboardData(text: '+37378346131'));
                              },
                              icon: const Icon(
                                Icons.copy_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.orange.shade400)),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.public,
                                color: Colors.white,
                              )),
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.orange.shade400)),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              )),
                          IconButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.orange.shade400)),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.place_rounded,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Laborum nostrud amet et proident do dolore ex ipsum. Ullamco elit voluptate ullamco eu sit sint excepteur aute nulla aute. Quis ex commodo non reprehenderit ipsum consectetur commodo officia amet do excepteur. Nostrud quis proident voluptate do non qui anim excepteur. Aliqua cupidatat eiusmod occaecat sunt aute enim duis. Nostrud consectetur esse ullamco in aliquip veniam ullamco adipisicing laborum occaecat anim nostrud anim. Adipisicing commodo velit voluptate ad velit ipsum ex officia amet exercitation laborum. Occaecat consequat veniam dolore eiusmod non in deserunt commodo ut laboris.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  border: Border.all(color: Colors.blue.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: const Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: Colors.white),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Text(
                      'Incididunt veniam quis aute incididunt labore aliqua.',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
