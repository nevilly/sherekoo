import 'package:flutter/material.dart';

class CrmBundleOrders extends StatefulWidget {
  const CrmBundleOrders({Key? key}) : super(key: key);

  @override
  State<CrmBundleOrders> createState() => _CrmBundleOrdersState();
}

class _CrmBundleOrdersState extends State<CrmBundleOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bundle Orders')),
    );
  }
}
