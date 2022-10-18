import 'package:flutter/material.dart';
import '../../model/InvCards/cards.dart';
import '../../model/crmBundle/bundle.dart';
import '../../util/Preferences.dart';
import '../../util/colors.dart';
import 'package:sherekoo/model/crmSevers/Servers.dart';

class ServiceDetails extends StatefulWidget {
  final Bundle bundle;
  const ServiceDetails({Key? key, required this.bundle}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  String price = '';
  List<CardsModel> cardsInfo = [];
  List colorCodeInfo = [];
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
        price = widget.bundle.price;
        cardsInfo = widget.bundle.cardsInfo;
        colorCodeInfo = widget.bundle.crmPackageInfo.colorCode;
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
                    Text('Saved By', style: header16),
                    // Icon(
                    //   Icons.details,
                    //   size: 20,
                    //   color: OColors.primary,
                    // )
                    Text('Plan', style: header16),
                  ]),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            overViews(context),
            seviceDetails(context),
            Scrollbar(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.bundle.crmPlans.plan.length,
                itemBuilder: (context, i) {
                  final itm = widget.bundle.crmPlans.plan[i];
                  return Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 5),
                    color: OColors.darGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itm['title'],
                          style: header16.copyWith(
                              color: OColors.fontColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          itm['descr'],
                          style: header11.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
                // children: [
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'About Plan / Schedule',
                //           style: header12.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           ' This package will start to work Three month before Ceremony.  The aim of this plan is to make things go on Time and make  spouse and ceremony server be known each other and be more confortable to each other..,',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 10),
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Day 1 of 1st month',
                //           style: header16.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           'Meeting with your  sherekoo Supervisor, for little convarsation about your fillings and wishes on your ceremony and arrange time tables',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 10),
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Day 2 of 1st month',
                //           style: header16.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           'Meeting with your  Disgners, for chatting about what kind of clothers is favaorute with you on your wedding day and, arrange shedule for taking body dimension and other staff',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 10),
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Day 3 of 1st month',
                //           style: header16.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           'Diamension Day, it day where spouses take diamension for  their wedding clothes ready to start making ',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 10),
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Day 4 of 2nd month',
                //           style: header16.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           'Contact Day, it day where spouses having conctact with Mc for more to be more confortable with their master of  Ceremony and get to know each other aking ',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 10),
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Day 5 of 2nd month',
                //           style: header16.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           'Having Dinner with Cookers, it day where spouses having special and simple dinner from Cookers who will serve in ceremony for more to be more confortable with their master of  Ceremony and get to know each other aking ',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 10),
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Day 6 of 2nd month',
                //           style: header16.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           'Ceremony Vehicle Test Driving, it day where spouses having little Driving in their ceremony ',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(height: 10),
                //   Container(
                //     padding: const EdgeInsets.all(5),
                //     color: OColors.darGrey,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           'Day 7 of 2nd month',
                //           style: header16.copyWith(
                //               color: OColors.fontColor,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         Text(
                //           'Clothes Testing, its Day where spouse test their clothes ',
                //           style: header11.copyWith(color: Colors.grey),
                //         ),
                //       ],
                //     ),
                //   ),
                //   const SizedBox(
                //     height: 10,
                //   )
                // ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Scrollbar overViews(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // const SizedBox(height: 25),
            Column(
              children: [
                Text(
                  'Bundle Price',
                  style: header12,
                ),
                Text(
                  '$price Tsh/',
                  style: header18.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
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
                      color: OColors.fontColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.bundle.aboutBundle,
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
                        color: OColors.fontColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      'Ceremony Color Code of the Year',
                      style: header10.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 65,
                  child: GridView.builder(
                    itemCount: colorCodeInfo.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6,
                            childAspectRatio: 0.8),
                    itemBuilder: (context, i) {
                      final itm = colorCodeInfo[i];
                      return crmColorCode(
                          context,
                          Color(int.parse(itm['color'])),
                          5,
                          50,
                          40,
                          itm['colorName']);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            // Hall Location
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
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        ),
                        // widget.bundle.crmServersInfo.contains
                        Text(
                          "jek",
                          style: header11.copyWith(
                              color: Colors.grey, fontWeight: FontWeight.w400),
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
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Riverside',
                          style: header11.copyWith(
                              color: Colors.grey, fontWeight: FontWeight.w400),
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
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(
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
                SizedBox(
                  width: 250,
                  child: Text(
                    'Ceremony Cards can change according to  arequirements',
                    style: header11.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w300),
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
                      color: OColors.fontColor, fontWeight: FontWeight.bold),
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
    );
  }

  Scrollbar seviceDetails(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: widget.bundle.crmServersInfo.length,
        itemBuilder: (context, i) {
          final itm = widget.bundle.crmServersInfo[i];
          return Column(
            children: [
              template1(itm, 'Mc'),
              template1(itm, 'Poduction'),
              template1(itm, 'Decorators'),
              template2(itm, 'Saloon'),
              template1(itm, 'Cake Bakery'),
              template2(itm, 'Clothes'),
            ],
          );
        },
      ),
    );
  }

  Column template2(ServersModel itm, String type) {
    return Column(
      children: [
        if (itm.bsnInfo.busnessType == type)
          Container(
            color: OColors.darGrey,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Saloons',
                  style: header14.copyWith(
                      color: OColors.fontColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //female Saloon
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Female  ',
                              style: header13,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/profile/profile.jpg',
                                width: 60,
                                // height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              'Shuu Saloon',
                              style: header12,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            starsIcons(Colors.red, 45),
                            Row(children: [
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.grey, 13),
                            ]),
                          ],
                        )
                      ],
                    ),
                    //Male Saloon
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Male  ',
                                style: header13,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/profile/profile.jpg',
                                width: 60,
                                // height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              'BerberShop',
                              style: header12,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            starsIcons(Colors.red, 45),
                            Row(children: [
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.red, 13),
                              starsIcons(Colors.grey, 13),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
      ],
    );
  }

  Column template1(ServersModel itm, String type) {
    return Column(
      children: [
        if (itm.bsnInfo.busnessType == type)
          Container(
            color: OColors.darGrey,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved By ${itm.bsnInfo.busnessType}',
                  style: header13.copyWith(
                      color: OColors.fontColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/busness/mc/garb.jpg',
                            width: 60,
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
                              'Name: ${itm.bsnInfo.companyName} ',
                              style: header13.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              itm.bsnInfo.busnessType,
                              style: header11,
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    //Rates
                    // Rate Stars
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: starsIcons(Colors.red, 45),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(children: [
                          starsIcons(Colors.red, 13),
                          starsIcons(Colors.red, 13),
                          starsIcons(Colors.red, 13),
                          starsIcons(Colors.red, 13),
                          starsIcons(Colors.grey, 13),
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 65,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/busness/mc/garb.jpg'),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/busness/mc/garb.jpg'),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/busness/mc/garb.jpg'),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset('assets/busness/mc/garb.jpg'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      ],
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

  Icon starsIcons(Color color, double s) {
    return Icon(
      Icons.star,
      size: s,
      color: color,
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
