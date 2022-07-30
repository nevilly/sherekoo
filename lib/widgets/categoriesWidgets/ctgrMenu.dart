import 'package:flutter/material.dart';

import '../../screens/categoriesPage/ProductionCategory.dart';
import '../../screens/categoriesPage/cakeCategory.dart';
import '../../screens/categoriesPage/carsCategory.dart';
import '../../screens/categoriesPage/cookerCategory.dart';
import '../../screens/categoriesPage/dancersCategory.dart';
import '../../screens/categoriesPage/decoratorCategory.dart';
import '../../screens/categoriesPage/hallCategory.dart';
import '../../screens/categoriesPage/mcCategory.dart';
import '../../screens/categoriesPage/saloonsCategory.dart';
import '../../screens/categoriesPage/sherekooPage.dart';
import '../../screens/categoriesPage/singersCategory.dart';

class CategoryMenu extends StatelessWidget {
  final Color rangi;
  final String title;

  // ignore: use_key_in_widget_constructors
  const CategoryMenu({required this.rangi, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      // color: Colors.grey.shade300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Recommend
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (BuildContext context) =>
            //                   const CategoriesPage()));
            //     },
            //     child: sizedBoxMenu('Recommend', title)),

            //Sherekoo
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Sherekoo()));
                },
                child: sizedBoxMenu('Sherekoo', title)),
            // Mc
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const McCategory()));
                },
                child: sizedBoxMenu('Mc', title)),
            //Halls
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HallsCategory()));
                },
                child: sizedBoxMenu('Halls', title)),
            //Decorators
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DecoratorsCategory()));
                },
                child: sizedBoxMenu('Decorators', title)),
            //Saloon
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SaloonsCategory()));
                },
                child: sizedBoxMenu('Saloon', title)),
            // Cake Bake
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CakeCategory()));
                },
                child: sizedBoxMenu('Cake Baker', title)),
            // Dancers
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DancersCategory()));
                },
                child: sizedBoxMenu('Dancers', title)),
            //Production
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ProductionCategory()));
                },
                child: sizedBoxMenu('Production', title)),
            //Cars
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CarsCategory()));
                },
                child: sizedBoxMenu('Cars', title)),
            //Cooker
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CookerCategory()));
                },
                child: sizedBoxMenu('Cooker', title)),

            //Singers
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SingersCategory()));
                },
                child: sizedBoxMenu('Singers', title)),

            //Magazine
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (BuildContext context) =>
            //                   const MagazineCategory()));
            //     },
            //     child: sizedBoxMenu('Magazine', title)),

            // Single
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (BuildContext context) =>
            //                   const SingleCategory()));
            //     },
            //     child: sizedBoxMenu('Single', title)),

            //Clothes
            // GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (BuildContext context) =>
            //                   const ClothesCategory()));
            //     },
            //     child: sizedBoxMenu('Clothes', title)),
          ],
        ),
      ),
    );
  }

  Widget sizedBoxMenu(String value, title) {
    return SizedBox(
      width: 100,
      child: Container(
          margin: const EdgeInsets.only(bottom: 1.0),
          alignment: Alignment.center,
          color: title == value ? rangi : Colors.grey.shade300,
          padding: const EdgeInsets.only(
              top: 15.0, bottom: 15.0, left: 10, right: 10),
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          )),
    );
  }
}
