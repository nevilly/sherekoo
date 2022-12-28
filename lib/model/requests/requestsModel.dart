import 'package:sherekoo/model/busness/busnessModel.dart';
import 'package:sherekoo/model/ceremony/crm-model.dart';


class RequestsModel {
  String? hostId,
      busnessId,
      ceremonyId,
      createdBy,
      createdDate,
      selected,
      confirm;

  //Ceremony Model
  CeremonyModel? crmInfo;

  //Busness Data
  BusnessModel? bsnInfo;

  //Service Info
  String? isInService, svId, svPayStatus, svAmount;




  RequestsModel({
    //Request Model
    this.hostId,
    this.busnessId,
    this.ceremonyId,
    this.createdDate,
    this.confirm,
    this.createdBy,

    //Busness Model
    this.bsnInfo,

    //Ceremon Model
    this.crmInfo,

    // Service Model
    this.isInService,
    this.svId,
    this.svPayStatus,
    this.svAmount,

   
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      hostId: json['hostId'] ?? "",
      ceremonyId: json['ceremonyId'] ?? "",
      busnessId: json['busnessId'] ?? "",

      confirm: json['confirm'] ?? "",

      //Ceremony Model
      crmInfo: CeremonyModel.fromJson(json['crmInfo']),

      // Busness Model
      bsnInfo: BusnessModel.fromJson(json['bsnInfo']),
      createdDate: json['createdDate'] ?? "",

      createdBy: json['createdBy'] ?? "",




      // Services Info
      isInService: json['isInService'].toString(),
      svId: json['svId'] ?? "",
      svPayStatus: json['svPayStatus'] ?? "",
      svAmount: json['svAmount'] ?? "",
    );
  }
}
