import 'package:flutter/material.dart';

import '../../model/crmBundle/bundle.dart';
import '../../model/crmBundle/crmbundle-call.dart';
import '../../model/user/userModel.dart';
import '../../util/app-variables.dart';
import '../../util/colors.dart';
import '../../util/func.dart';
import '../../util/modInstance.dart';
import '../../util/textStyle-pallet.dart';
import '../../util/util.dart';
import '../ourServices/srvDetails.dart';

class HotBundles extends StatefulWidget {
  final User user;
  const HotBundles({Key? key, required this.user}) : super(key: key);

  @override
  State<HotBundles> createState() => _HotBundlesState();
}

class _HotBundlesState extends State<HotBundles> {
  List<Bundle> bundle = [];
  List<Bundle> bundleCrmHotBundle = [];

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      setState(() {
        token = value;
        getHotCrmBundle();
      });
    });
    super.initState();
  }

  getHotCrmBundle() async {
    CrmBundleCall(payload: [], status: 0)
        .get(token, urlGetCrmBundleHot)
        .then((value) {
      if (value.status == 200) {
        setState(() {
          bundleCrmHotBundle =
              value.payload.map<Bundle>((e) => Bundle.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: OColors.secondary,
      appBar: AppBar(
        backgroundColor: OColors.secondary,
        title: Text('Hot Bundles'),
      ),
      body: Column(
        children: [
          SizedBox(
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    childAspectRatio: 0.8),
                itemCount: bundleCrmHotBundle.length,
                itemBuilder: (BuildContext context, i) {
                  final itm = bundleCrmHotBundle[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ServiceDetails(
                                  crm: emptyCrmModel,
                                  bundle: itm,
                                  currentUser: widget.user)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: OColors.darGrey,
                            borderRadius: BorderRadius.circular(10)),
                        width: 135,
                        height: size.height,
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: fadeImg(
                                  context,
                                  '${api}public/uploads/sherekooAdmin/crmBundle/${itm.bImage}',
                                  size.width,
                                  size.height,
                                  BoxFit.contain),
                            )),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: prmry,
                                      // border: Border.all(color: osec, width: 2.5),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0,
                                        right: 6.0,
                                        top: 4.0,
                                        bottom: 4.0),
                                    child: Text(itm.bundleType,
                                        style: header12.copyWith(
                                            fontWeight: FontWeight.w400)),
                                  ),
                                )),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                  padding: EdgeInsets.only(top: 6, left: 15),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height: 45,
                                  color: OColors.secondary.withOpacity(.6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('${itm.price} Tsh',
                                          style: header14.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      Text(itm.ownerName,
                                          style: header12.copyWith(
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
