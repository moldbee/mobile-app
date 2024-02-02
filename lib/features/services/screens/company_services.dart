import 'package:flutter/material.dart';

class CompanyServicesScreen extends StatelessWidget {
  const CompanyServicesScreen({Key? key, this.id}) : super(key: key);
  final route = '/services/company/service';

  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Услуги / Metro'),
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        child: Text('Nisi esse consequat ex magna ')),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade400,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        '500 lei',
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
            itemCount: 50),
      ),
    );
  }
}
