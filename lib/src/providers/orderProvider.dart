import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../models/vehicleTypeModel.dart';
import 'dart:math' as m;

class OrderProvider extends ChangeNotifier {
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  final List<VehicleType> vehicles = [
    VehicleType('Car', 100),
    VehicleType('Small Van', 150),
    VehicleType('Medium Van', 180),
    VehicleType('Lutton Van', 200)
  ];
  VehicleType? selectedVehicleType = VehicleType('Car', 100);
  double totalPriceExcVat = 0.0, totalPriceIncVat = 0.0;

  String? postcodeValidator(String? postcode) {
    String ukPostcodePattern =
        r'(^([A-Za-z][A-Ha-hJ-Yj-y]?[0-9][A-Za-z0-9]? ?[0-9][A-Za-z]{2}|[Gg][Ii][Rr] ?0[Aa]{2})$)';
    if (postcode == null ||
        postcode.isEmpty ||
        !RegExp(ukPostcodePattern).hasMatch(postcode)) {
      return 'Please enter valid postcode';
    }
    return null;
  }

  changeVehicleType(VehicleType? vehicleType) {
    selectedVehicleType = vehicleType;
    calculatePrice();
    notifyListeners();
  }

  calculatePrice() async {
    List<Location> pickupLocations =
        await locationFromAddress(pickupController.text);
    List<Location> dropoffLocations =
        await locationFromAddress(dropoffController.text);

    if (selectedVehicleType != null &&
        pickupLocations.isNotEmpty &&
        dropoffLocations.isNotEmpty) {
      double pickupLat = pickupLocations[0].latitude;
      double pickupLong = pickupLocations[0].longitude;

      double dropoffLat = dropoffLocations[0].latitude;
      double dropoffLong = dropoffLocations[0].longitude;

      double distanceInMiles = calculateDistance(pickupLat, pickupLong,
          dropoffLat, dropoffLong); // Distance as the Crow Flies
      // OR double distanceInMeters = geo.Geolocator.distanceBetween(pickupLat, pickupLong, dropoffLat, dropoffLong);

      double vehiclePricePerMile =
          selectedVehicleType!.pensPerMile / 100; // Pens to Pound

      totalPriceExcVat = distanceInMiles * vehiclePricePerMile;

      // VAT in UK is estimated as 20%
      double totalVatPrice = totalPriceExcVat * 0.2;
      totalPriceIncVat = totalPriceExcVat + totalVatPrice;

      notifyListeners();
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 3958.8; // Radius of the Earth in miles
    double dLat = m.pi / 180 * (lat2 - lat1);
    double dLon = m.pi / 180 * (lon2 - lon1);
    double lat1Rad = m.pi / 180 * lat1;
    double lat2Rad = m.pi / 180 * lat2;
    double a = m.sin(dLat / 2) * m.sin(dLat / 2) +
        m.sin(dLon / 2) * m.sin(dLon / 2) * m.cos(lat1Rad) * m.cos(lat2Rad);
    double c = 2 * m.atan2(m.sqrt(a), m.sqrt(1 - a));
    double distance = R * c;
    return distance;
  }
}
