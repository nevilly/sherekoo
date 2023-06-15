import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../model/InvCards/cards.dart';
import '../../model/bundleBooking/bundle-orders.dart';
import '../../model/bundleBooking/bundleOrders-Model.dart';
import '../../model/ceremony/crm-model.dart';
import '../../model/crmBundle/bundle.dart';
import '../../model/services/servicexModel.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';

import '../../util/func.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../../widgets/calender/eventEditingPage.dart';
import '../../widgets/gradientBorder.dart';
import '../../widgets/imgWigdets/defaultAvater.dart';
import '../../widgets/imgWigdets/userAvater.dart';
import '../admin/crmBundleAdmin.dart';

class ServiceDetails extends StatefulWidget {
  final CeremonyModel crm;
  final User currentUser;
  final Bundle bundle;
  const ServiceDetails(
      {Key? key,
      required this.bundle,
      required this.currentUser,
      required this.crm})
      : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // ScrollController? _scrollController;
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _crmDate = TextEditingController();

  int tabIndex = 0;

  String id = "";
  String price = '';
  String aboutBundle = '';
  String around = '';
  String location = '';
  String bImage = '';
  String bundleType = '';
  String amountOfPeople = "";
  String bundleLevel = "";
  String aboutPackage = "";
  String isBooking = "";

  List<CardsModel> cardsInfo = [];
  List colorCodeInfo = [];

  User superVisorInfo = User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      avater: '',
      phoneNo: '',
      email: '',
      gender: '',
      role: '',
      isCurrentUser: '',
      address: '',
      bio: '',
      meritalStatus: '',
      totalPost: '',
      isCurrentBsnAdmin: '',
      isCurrentCrmAdmin: '',
      totalFollowers: '',
      totalFollowing: '',
      totalLikes: '');

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {});

    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        price = widget.bundle.price;
        cardsInfo = widget.bundle.cardsInfo;
        colorCodeInfo = widget.bundle.crmPackageInfo.colorCode;
        bundleType = widget.bundle.bundleType;
        around = widget.bundle.around;
        location = widget.bundle.location;
        bImage = widget.bundle.bImage;
        aboutBundle = widget.bundle.aboutBundle;
        amountOfPeople = widget.bundle.amountOfPeople;
        aboutPackage = widget.bundle.aboutPackage;
        id = widget.bundle.id;
        superVisorInfo = widget.bundle.superVisorInfo;
        cardsInfo = widget.bundle.cardsInfo;
        isBooking = widget.bundle.isBooking;
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
      bundleSchedule('$urlGetCrmBundleSchedule/${widget.bundle.id}');
    });
    super.initState();
  }

  List<BundleOrderModel> ratiba = [];
  bundleSchedule(dirUl) {
    BundleOrders(payload: [], status: 0).get(token, dirUl).then((v) {
      if (v.status == 200) {
        ratiba = v.payload
            .map<BundleOrderModel>((e) => BundleOrderModel.fromJson(e))
            .toList();
      }
    });
  }

  orderCrmBundle(BuildContext context, TextEditingController contact,
      TextEditingController date, crmId) {
    if (date.text.isNotEmpty) {
      if (contact.text.isNotEmpty) {
        if (widget.bundle.id != '') {
          BundleOrders(payload: [], status: 0)
              .postOrders(token, urlOrderCrmBundle, date.text, contact.text,
                  widget.bundle.id, crmId)
              .then((v) {
            if (v.status == 200) {
              Navigator.of(context).pop();
              errorAlertDialog(context, 'Booking Complete!',
                  'Your SuperVisor "0743882455"  will contact you with in 5hrs Thanks..');

              setState(() {
                isBooking = 'true';
                date.text = '';
                contact.text = '';
              });
            }
          });
        } else {
          errorAlertDialog(
              context, 'Network is low!', 'Please Comeback leter..');
        }
      } else {
        // errorAlertDialog(
        //     context, 'Enter CeremonyDate', 'Fill Ceremony Date info Please!..');
        showAlertDialog(
            context,
            Text('Enter CeremonyDate', style: header18),
            Text('Fill Ceremony Date info Please!..', style: header12),
            flatButton(context, 'd', header10, 0, 0, trans, 0, 0, 0),
            flatButton(context, 'u', header13, 0, 0, trans, 0, 0, 0));
      }
    } else {
      errorAlertDialog(
          context, 'Enter CeremonyDate', 'Fill Ceremony Date info Please!..');
    }
  }

  Widget continueButton() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      ),
      child: const Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  TabBar get _tabBar => TabBar(
          labelColor: OColors.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: OColors.primary,
          indicatorWeight: 2,
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'OverView',
            ),
            Tab(
              text: 'Schedule',
            ),
            Tab(
              text: 'SavedBy',
            ),
            Tab(
              text: 'Plan',
            )
          ]);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: OColors.secondary,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: OColors.darGrey,
                // automaticallyImplyLeading: false,
                actions: actionBar(context, size, 80, 35),

                expandedHeight: 200,

                flexibleSpace: bundleImage(size),

                pinned: true,
                floating: false,
              ),
            ];
          },
          body: Column(
            children: [
              SizedBox(
                height: size.height / (25 * 10),
              ),
              PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.8))),
                  child: ColoredBox(
                    color: OColors.darGrey,
                    child: _tabBar,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    overViews(context, size),
                    schedule(),
                    seviceDetails(context, size),
                    servicePlan(context, size)
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: widget.crm.cId != ''
            ? Container(
                height: 60,
                color: OColors.primary.withOpacity(.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: widget.crm.cId.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      LiveBorder(
                                          live: const SizedBox.shrink(),
                                          radius: 30,
                                          child: CircleAvatar(
                                              radius: 10,
                                              backgroundImage: NetworkImage(
                                                '${api}public/uploads/${widget.crm.userFid.username}/ceremony/${widget.crm.cImage}',
                                              ))),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.crm.ceremonyType,
                                              style: header12.copyWith(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              widget.crm.ceremonyDate,
                                              style: header10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width / 3.8,
                                  ),
                                  booking(context, size, 80, 32),
                                ],
                              )
                            : widget.crm.cId != ''
                                ? Center(
                                    child: Text(
                                      'Select Ceremony',
                                      style: header12,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                    'Create Ceremony',
                                    style: header12,
                                  ))),
                  ],
                ),
              )
            : Container(
                height: 60,
                color: OColors.primary.withOpacity(.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //SuperVisor Profile

                    Row(
                      children: [
                        LiveBorder(
                            live: const SizedBox.shrink(),
                            radius: 30,
                            child: CircleAvatar(
                                radius: 10,
                                backgroundImage: NetworkImage(
                                  '${api}public/uploads/${superVisorInfo.username!}/profile/${superVisorInfo.avater!}',
                                ))),
                        const SizedBox(
                          width: 5,
                        ),
                        // SUperVisor Details
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Super Visor',
                                style: header13,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                superVisorInfo.username!,
                                style: header11,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    booking(context, size, 80, 32),
                  ],
                ),
              ),
      ),
    );
  }

  Scrollbar schedule() {
    return Scrollbar(
        child: ratiba.isNotEmpty
            ? ListView.builder(
                itemCount: ratiba.length,
                itemBuilder: (BuildContext context, i) {
                  final itm = ratiba[i];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: prmry),
                        child: Container(
                          color: OColors.darGrey,
                          width: 90,
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Booked on', style: header12),
                                    Text(itm.ceremonyDate,
                                        style: header14.copyWith(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: OColors.secondary,
                                ),
                                child: itm.userInfo.avater != ''
                                    ? LiveBorder(
                                        live: const SizedBox.shrink(),
                                        radius: 30,
                                        child: CircleAvatar(
                                            radius: 10,
                                            backgroundImage: NetworkImage(
                                              '${api}public/uploads/${itm.userInfo.username}/profile/${itm.userInfo.avater!}',
                                            )))
                                    : const LiveBorder(
                                        live: SizedBox.shrink(),
                                        radius: 30,
                                        child: DefaultAvater(
                                            height: 40, radius: 50, width: 40)),
                              ),
                            ],
                          ),
                        )),
                  );
                })
            : Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EventEditingPage()));
                        },
                        child: Text('Add', style: header14)),
                    const SizedBox(height: 15),
                    SfCalendar(
                      backgroundColor: Colors.white,
                      view: CalendarView.month,
                      initialDisplayDate: DateTime.now(),
                    ),
                  ],
                ),
              ));
  }

  List<Widget> actionBar(BuildContext context, size, int w, int h) {
    return [
      widget.currentUser.role == 'a'
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CrmBundleAdmin(
                              crmPackageInfo: widget.bundle.crmPackageInfo,
                            )));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8, right: 5),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add, size: 20, color: Colors.red),
                ),
              ))
          : const SizedBox.shrink()
    ];
  }

  Container booking(BuildContext context, size, double w, double h) {
    return Container(
      child: isBooking != 'true'
          ? GestureDetector(
              onTap: () {
                bookinDialog(context, size);
              },
              child: flatButton(
                  context, 'Booking', header12, h, w, prmry, 10, 10, 10))
          : flatButton(context, 'Booked', header13, h, w, prmry, 10, 5, 10),
    );
  }

  SafeArea bundleImage(Size size) {
    return SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            bImage != ''
                ? ClipRect(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 10.0,
                              sigmaY: 10.0,
                            ),
                            child: Image.network(
                              '${api}public/uploads/sherekooAdmin/crmBundle/$bImage',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Image.network(
                          '${api}public/uploads/sherekooAdmin/crmBundle/$bImage',
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('assets/ceremony/uk1.jpg',
                        width: size.width, fit: BoxFit.cover),
                  ),
          ],
        ));
  }

  Scrollbar servicePlan(BuildContext context, size) {
    return Scrollbar(
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
                      color: OColors.fontColor, fontWeight: FontWeight.bold),
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
      ),
    ));
  }

  Scrollbar overViews(BuildContext context, size) {
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
                booking(context, size, 100, 40)
              ],
            ),
            const SizedBox(height: 18),

            /** About Bundle */
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

            /** ColorCode Start */
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

                // Color Code List
                SizedBox(
                  height: 65,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                          itm['colorName'],
                          header12);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),

            /** Ceremony Location Start */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ceremony Location',
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
                          'Around: ',
                          style: header11.copyWith(
                              color: Colors.grey, fontWeight: FontWeight.w400),
                        ),
                        // widget.bundle.crmServersInfo.contains
                        Text(
                          around,
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
                          location,
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
                          amountOfPeople,
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

            /** Hall Sample Photo Start */
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
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 18),

            /** Ceremony Card Start */
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
                    'Ceremony Cards can change according to a requirements',
                    style: header11.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 80,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6,
                            childAspectRatio: 0.8),
                    itemCount: cardsInfo.length,
                    itemBuilder: (context, i) {
                      final itm = cardsInfo[i];
                      return GestureDetector(
                        onTap: () {
                          prevCardDialog(context, itm);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: OColors.darGrey,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            margin: const EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                fadeImg1(
                                    itm,
                                    context,
                                    '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.cardImage}',
                                    MediaQuery.of(context).size.height / 7.1),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // prevCardDialog(context, itm);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 2,
                                            bottom: 2),
                                        decoration: BoxDecoration(
                                            color: OColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          'prev',
                                          style: header11,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      );
                    },
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
                    //SuperVisor Profile
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: OColors.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: UserAvater(
                            avater: superVisorInfo.avater!,
                            url: '/profile/',
                            username: superVisorInfo.username!,
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    // SUperVisor Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          superVisorInfo.username!,
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
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Scrollbar seviceDetails(BuildContext context, size) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: widget.bundle.crmServersInfo.length,
        itemBuilder: (context, i) {
          final itm = widget.bundle.crmServersInfo[i];
          return Column(
            children: [
              template1(itm, 'Mc'),
              template1(itm, 'Production'),
              template1(itm, 'Decorator'),
              template2(itm, 'Saloon'),
              template2(itm, 'Hall'),
              template2(itm, 'Cooker'),
              template1(itm, 'Cake Bakery'),
              template2(itm, 'Clothes'),
              template2(itm, 'Car'),
              template1(itm, 'Singer'),
            ],
          );
        },
      ),
    );
  }

  Column template2(ServicexModel itm, String type) {
    return Column(
      children: [
        if (itm.bsnInfo!.busnessType == type)
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

  Column template1(ServicexModel itm, String type) {
    return Column(
      children: [
        if (itm.bsnInfo!.busnessType == type)
          Container(
            color: OColors.darGrey,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Saved By ${itm.bsnInfo!.busnessType}',
                    style: header13.copyWith(
                        color: OColors.fontColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: fadeImg(
                                context,
                                '${api}public/uploads/${itm.bsnInfo!.user.username!}/busness/${itm.bsnInfo!.coProfile}',
                                60,
                                60,
                                BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itm.bsnInfo!.busnessType,
                                style: header13,
                              ),
                              Text(
                                itm.bsnInfo!.companyName,
                                style: header12.copyWith(
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ],
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
                ),
                const SizedBox(
                  height: 5,
                ),

                // Container(
                //   margin: const EdgeInsets.only(left: 10),
                //   height: 65,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     physics: const NeverScrollableScrollPhysics(),
                //     children: [
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(5),
                //         child: Image.asset('assets/busness/mc/garb.jpg'),
                //       ),
                //       const SizedBox(
                //         width: 6,
                //       ),
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(5),
                //         child: Image.asset('assets/busness/mc/garb.jpg'),
                //       ),
                //       const SizedBox(
                //         width: 6,
                //       ),
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(5),
                //         child: Image.asset('assets/busness/mc/garb.jpg'),
                //       ),
                //       const SizedBox(
                //         width: 6,
                //       ),
                //       ClipRRect(
                //         borderRadius: BorderRadius.circular(5),
                //         child: Image.asset('assets/busness/mc/garb.jpg'),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        const SizedBox(height: 1),
      ],
    );
  }

  FadeInImage fadeImg1(CardsModel itm, BuildContext context, url, double h) {
    return FadeInImage(
      image: NetworkImage(url),
      fadeInDuration: const Duration(milliseconds: 100),
      placeholder: const AssetImage('assets/logo/noimage.png'),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/logo/noimage.png', fit: BoxFit.fitWidth);
      },
      height: h,
      fit: BoxFit.fitWidth,
    );
  }

  Icon starsIcons(Color color, double s) {
    return Icon(
      Icons.star,
      size: s,
      color: color,
    );
  }

  prevCardDialog(BuildContext context, CardsModel itm) async {
    String imgUrl =
        '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.cardImage}';
    double h = 50;
    double w = 50;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const SizedBox(),
      onPressed: () {
        // Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => CeremonyUpload(
        //             getData: ceremony, getcurrentUser: widget.user)));
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: const Text("cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 8, bottom: 8),
      backgroundColor: OColors.secondary,
      title: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.close,
                size: 20,
                color: OColors.fontColor,
              ),
            ),
          ),
        ),
      ),
      content: StatefulBuilder(builder: (BuildContext context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: fadeImg1(
                  itm, context, imgUrl, MediaQuery.of(context).size.height),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      imgUrl =
                          '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.font}';
                      h = 70;
                      w = 60;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: w,
                        height: h,
                        child: fadeImg1(
                            itm,
                            context,
                            '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.font}',
                            MediaQuery.of(context).size.height / 7.1),
                      ),
                      Text(
                        'fontSide',
                        style: header10,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      imgUrl =
                          '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.middle}';
                      h = 70;
                      w = 60;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: w,
                        height: h,
                        child: fadeImg1(
                            itm,
                            context,
                            '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.middle}',
                            MediaQuery.of(context).size.height / 7.1),
                      ),
                      Text(
                        'Middle',
                        style: header10,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      imgUrl =
                          '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.back}';
                      h = 70;
                      w = 60;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: w,
                        height: h,
                        child: fadeImg1(
                            itm,
                            context,
                            '${api}public/uploads/SherekooAdmin/InvitationCards/${itm.back}',
                            MediaQuery.of(context).size.height / 7.1),
                      ),
                      Text(
                        'fontSide',
                        style: header10,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      }),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bookinDialog(BuildContext context, size) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        'cancel',
        style: header13.copyWith(
            fontWeight: FontWeight.normal, color: OColors.fontColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(6),
        primary: OColors.fontColor,
        backgroundColor: OColors.primary,
      ),
      child: const Text("Booking"),
      onPressed: () {
        orderCrmBundle(context, _contact, _crmDate, widget.crm.cId);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      // contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 4, bottom: 4),
      backgroundColor: OColors.secondary,
      title: Container(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Container(
                width: 80,
                height: 50,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: OColors.fontColor,
                  ),
                ),
              ),
              Text(
                'Bookin Now',
                style: header18.copyWith(
                    fontStyle: FontStyle.italic, color: OColors.primary),
              )
            ],
          ),
        ),
      ),
      content: SizedBox(
        height: 250,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Bundle Price',
                  style: header18.copyWith(
                    fontSize: 22,
                  ),
                ),
                Text(price,
                    style: header18.copyWith(
                        fontSize: 30, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text('Your Contact', style: header13),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              padding: const EdgeInsets.only(
                top: 5,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: OColors.darGrey),
              child: TextField(
                controller: _contact,
                maxLines: null,
                expands: true,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 20.0, right: 20.0),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.call,
                      size: 20,
                      color: OColors.primary,
                    ),
                  ),
                  hintText: "Enter your contact.. \n \n \n",
                  hintStyle: const TextStyle(color: Colors.grey, height: 1.5),
                ),
                style: const TextStyle(
                    fontSize: 12, color: Colors.grey, height: 1.5),
                onChanged: (value) {
                  setState(() {
                    //_email = value;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ceremonyDate('Ceremony Day', _crmDate, size)
        ]),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  ceremonyDate(title, dateController, size) {
    return SizedBox(
        width: size.width / 1.4,
        // color: OColors.fontColor,
        // margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              alignment: Alignment.topLeft,
              child: Text(title, style: header13),
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.only(left: 0, right: 20, bottom: 1),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                color: OColors.darGrey,
              ),
              child: TextField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: dateController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.calendar_month,
                      size: 20,
                      color: OColors.primary,
                    ),
                  ),
                  hintText: 'Date ( DD/MM/YYY )',
                  hintStyle: header12.copyWith(color: Colors.grey, height: 1.1),
                ),
                style: header12.copyWith(color: Colors.grey, height: 1.1),
                onTap: () {
                  _selectDate(context, dateController);
                },
              ),
            ),
          ],
        ));
  }

  DateTime? _selectedDate;
  // Date Selecting Function
  _selectDate(BuildContext context, textEditingController) async {
    DateTime? newSelectedDate = await showDatePicker(
        locale: const Locale('en', 'IN'),
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        fieldHintText: 'yyyy/mm/dd',
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: OColors.darkGrey,
                onPrimary: Colors.white,
                surface: OColors.secondary,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: OColors.darGrey,
            ),
            child: child as Widget,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      textEditingController
        ..text = DateFormat('yyyy/MM/dd').format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
