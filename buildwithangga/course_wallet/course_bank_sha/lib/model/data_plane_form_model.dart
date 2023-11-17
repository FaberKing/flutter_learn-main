// To parse this JSON data, do
//
//     final dataPlanFormModel = dataPlanFormModelFromJson(jsonString);

import 'dart:convert';

DataPlanFormModel dataPlanFormModelFromJson(String str) =>
    DataPlanFormModel.fromJson(json.decode(str));

String dataPlanFormModelToJson(DataPlanFormModel data) =>
    json.encode(data.toJson());

class DataPlanFormModel {
  final int? dataPlanId;
  final String? phoneNumber;
  final String? pin;

  DataPlanFormModel({
    this.dataPlanId,
    this.phoneNumber,
    this.pin,
  });

  DataPlanFormModel copyWith({
    int? dataPlanId,
    String? phoneNumber,
    String? pin,
  }) =>
      DataPlanFormModel(
        dataPlanId: dataPlanId ?? this.dataPlanId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        pin: pin ?? this.pin,
      );

  factory DataPlanFormModel.fromJson(Map<String, dynamic> json) =>
      DataPlanFormModel(
        dataPlanId: json["data_plan_id"],
        phoneNumber: json["phone_number"],
        pin: json["pin"],
      );

  Map<String, dynamic> toJson() => {
        "data_plan_id": dataPlanId.toString(),
        "phone_number": phoneNumber,
        "pin": pin,
      };
}
