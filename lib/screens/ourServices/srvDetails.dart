import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../util/Preferences.dart';
import '../../util/colors.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // late YoutubePlayerController? _controller;
  String token = '';
  int tabIndex = 0;

  final Preferences _preferences = Preferences();
  // TabBar get _tabBar => TabBar(
  //         labelColor: OColors.primary,
  //         unselectedLabelColor: Colors.grey,
  //         indicatorColor: OColors.primary,
  //         indicatorWeight: 2,
  //         tabs: const [
  //           Tab(
  //             text: 'OverView',
  //           ),
  //           Tab(
  //             text: 'Description',
  //           ),
  //           Tab(
  //             text: 'Schedule',
  //           )
  //         ]);

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );

    _preferences.init();
    _preferences.get('token').then((value) {
      setState(() {
        token = value;
      });
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          tabIndex = _tabController.index;
        });
      }
      if (_tabController.animation != null) {
        setState(() {
          tabIndex = _tabController.animation!.value.floor();
          _tabController.animation;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.secondary,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: OColors.darGrey,
              // automaticallyImplyLeading: false,
              actions: [
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) => CrmnAdmin(crm: widget.ceremony)));
                  //},
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 20, top: 15, bottom: 15),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 4, bottom: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: OColors.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(80))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Text(
                          'Booking Now',
                          style: header11.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              expandedHeight: 200,
              flexibleSpace: SafeArea(
                  bottom: false,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Text(
                        'Upprt Bar',
                        style: header10,
                      )
                    ],
                  )),

              pinned: true,
              floating: true,
              bottom: TabBar(
                  labelColor: OColors.primary,
                  indicatorColor: OColors.primary,
                  unselectedLabelColor: OColors.darkGrey,
                  labelPadding: const EdgeInsets.only(
                    bottom: 2,
                  ),
                  indicatorPadding: const EdgeInsets.only(
                    top: 25,
                  ),
                  controller: _tabController,
                  tabs: [
                    Text('Overview', style: header16),
                    // Icon(
                    //   Icons.grid_on_outlined,
                    //   size: 20,
                    //   color: OColors.primary,
                    // ),
                    Text('Details', style: header16),
                    // Icon(
                    //   Icons.details,
                    //   size: 20,
                    //   color: OColors.primary,
                    // )
                    Text('Schedule', style: header16),
                  ]),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        Text(
                          'Bundle Price',
                          style: header12,
                        ),
                        Text(
                          '15,000,000 Tsh/',
                          style: header18.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: OColors.primary),
                          child: Center(
                              child: Text(
                            'Booking Now',
                            style: header13,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Bunde',
                          style: header12.copyWith(
                              color: OColors.fontColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Lorem ipsum  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, Excepteur sint occaecat cupidatat non proident,.',
                          style: header11.copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Color Code ',
                            style: header12.copyWith(
                                color: OColors.fontColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 150,
                            child: Text(
                              'Ceremony Color Code of the Year',
                              style: header10.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            crmColorCode(
                                context, Colors.black, 5, 50, 40, 'black'),
                            crmColorCode(
                                context,
                                const Color.fromARGB(255, 245, 187, 26),
                                5,
                                50,
                                40,
                                'Gold'),
                            crmColorCode(
                                context,
                                const Color.fromARGB(255, 245, 187, 26),
                                5,
                                50,
                                40,
                                'Gold'),
                            crmColorCode(
                                context, Colors.white, 5, 50, 40, 'White'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hall Location',
                              style: header12.copyWith(
                                  color: OColors.fontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Hall Name: ',
                                  style: header11.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Jerusaleem',
                                  style: header11.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Location: ',
                                  style: header11.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Riverside',
                                  style: header11.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Amont of People',
                              style: header12.copyWith(
                                  color: OColors.fontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '200 - 500',
                                  style: header14.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Hall Photo
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hall Photo',
                              style: header12.copyWith(
                                  color: OColors.fontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.more_vert,
                                color: OColors.primary,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk1.jpg'),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk2.png'),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk3.jpg'),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk1.jpg'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 18),
                    // Ceremony Cards Photo
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cards Sample',
                              style: header12.copyWith(
                                  color: OColors.fontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.more_vert,
                                color: OColors.primary,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 250,
                          child: Text(
                            'Ceremony Cards can change according to  arequirements',
                            style: header11.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk1.jpg'),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk2.png'),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk3.jpg'),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset('assets/ceremony/uk1.jpg'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 18),
                    // SuperVisors
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SuperVisor',
                          style: header12.copyWith(
                              color: OColors.fontColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'assets/profile/profile.jpg',
                                width: 50,
                                // height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jermia David',
                                  style: header13,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  'Super Visor',
                                  style: header10,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Text('B heree'),
            const Text('c heree')
          ],
        ),
      ),
    );
  }

  Column crmColorCode(
      BuildContext context, Color color, double r, double w, double h, title) {
    return Column(
      children: [
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(r)),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: header12,
        )
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    // if (!mounted) {
    //   _controller!.dispose();
    // }

    super.dispose();
  }
}

// SizedBox(
//                     height: 200,
//                     child: StaggeredGridView.countBuilder(
//                         physics: const NeverScrollableScrollPhysics(),
//                         crossAxisSpacing: 2,
//                         mainAxisSpacing: 2,
//                         crossAxisCount: 8,
//                         shrinkWrap: true,
//                         itemCount: 5,
//                         itemBuilder: (context, i) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: Image.asset('assets/ceremony/uk1.jpg'),
//                           );
//                         },
//                         staggeredTileBuilder: (index) {
//                           return const StaggeredTile.fit(3);
//                         }),
//                   ),
