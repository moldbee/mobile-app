import 'package:flutter/material.dart';

class ServiceCompanyScreen extends StatelessWidget {
  const ServiceCompanyScreen({Key? key, this.logoUrl, this.title})
      : super(key: key);
  final String route = '/service/companies/company';

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
        backgroundColor: Colors.transparent,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(title as String)),
          ],
        ),
      ),
    );
  }
}
