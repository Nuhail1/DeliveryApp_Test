import 'package:deliveryapp/src/providers/orderProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/vehicleTypeModel.dart';
import '../utils/constants.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  late OrderProvider oProvider;

  @override
  Widget build(BuildContext context) {
    oProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Create Order')),
        ),
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              postcodeField(
                controller: oProvider.pickupController,
                label: 'Pick-up',
              ),
              AppConstants.defSpace,
              postcodeField(
                  controller: oProvider.dropoffController, label: 'Drop-off'),
              AppConstants.defSpace,
              vehicleTypeDropDown(),
              const SizedBox(height: 24),
              resultField(
                  label: 'Price Excluding VAT',
                  price: oProvider.totalPriceExcVat),
              AppConstants.defSpace,
              resultField(
                  label: 'Price Including VAT',
                  price: oProvider.totalPriceIncVat),
            ],
          ),
        ));
  }

  postcodeField({TextEditingController? controller, String? label}) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            labelText: label,
            hintText: 'Enter postcode'),
        validator: oProvider.postcodeValidator,
        onFieldSubmitted: (value) {
          if (formKey.currentState!.validate()) {
            oProvider.calculatePrice();
          }
        },
      ),
    );
  }

  vehicleTypeDropDown() {
    return DropdownButtonFormField<VehicleType>(
      isExpanded: true,
      value: oProvider.selectedVehicleType,
      style: const TextStyle(fontSize: 15, color: AppConstants.blackColor),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: oProvider.changeVehicleType,
      items: oProvider.vehicles
          .map<DropdownMenuItem<VehicleType>>((VehicleType value) {
        return DropdownMenuItem<VehicleType>(
          value: value,
          child: Text(value.type),
        );
      }).toList(),
    );
  }

  resultField({String? label, double? price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label!,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppConstants.blackColor)),
        const Text(' : ',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppConstants.blackColor)),
        Text('£${price!.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppConstants.themeColor)),
      ],
    );
  }
}
