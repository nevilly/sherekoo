import 'package:flutter/material.dart';

import '../../widgets/categoriesWidgets/ctgrMenu.dart';
import '../../widgets/navWidget/bttmNav.dart';
import '../../widgets/notifyWidget/notifyWidget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1.0,
        toolbarHeight: 70,
        flexibleSpace: SafeArea(
            child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 18, left: 10, right: 18, bottom: 7),
                  width: 70,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[500]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        cursorColor: Colors.grey[500]!.withOpacity(0.2),
                        decoration: const InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.0),
                              child: Icon(
                                Icons.search,
                                size: 25,
                                color: Colors.grey,
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'Search..',
                            hintStyle: TextStyle(fontSize: 14)),
                        onChanged: (value) {
                          setState(() {
                            //_email = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const NotifyWidget()
            ],
          ),
        )),
      ),

      body: Row(
        children: [
          const CategoryMenu(
            rangi: Colors.white,
            title: 'Recommend',
          ),
          Expanded(
            child: Column(
              children: [
                columnBody('Recommend', 160, 16, 3),
                columnBody('Hot Deals', 300, 12, 3),
              ],
            ),
          )
        ],
      ),

      // // Bottom Section
      // bottomNavigationBar: const BttmNav(),
      // bottomNavigationBar: BottomToolbar(),
    );
  }

  Widget columnBody(
      String title, double heights, int itemCountx, int crossAxisCountx) {
    return Column(
      children: [
        //Top Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 5,
                left: 10,
              ),
              child: Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 5,
                right: 15,
              ),
              child: Text(
                'All',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),

        //Body
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: heights,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCountx,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCountx),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (_) => PostDetail()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(1.0),
                                    topRight: Radius.circular(1.0),
                                  ),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/busness/mc/mc1.png'),
                                      // image: AssetImage('assets/busness/k4.jpg'),
                                      height: 45,
                                      fit: BoxFit.fill),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 1),
                                  child: const Text(
                                    'Mc Pili',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  })),
        ), //Top Header
      ],
    );
  }
}
