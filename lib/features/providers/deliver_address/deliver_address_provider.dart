import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/core/paths.dart';
import 'package:multi_store_app/features/home/data/models/deliver_address_model.dart';

class AddressDeliverState {
  final int index;
  final List<DeliverAddressModel>? addressList;

  AddressDeliverState({required this.index, this.addressList});

  AddressDeliverState copyWith({int? index, List<DeliverAddressModel>? addressList}) =>
      AddressDeliverState(index: index ?? this.index, addressList: addressList ?? this.addressList);
}

class AddressDeliverNotifier extends StateNotifier<AddressDeliverState> {
  AddressDeliverNotifier(super.state);

  void changeAddressIndex(int index) {
    state = state.copyWith(index: index);
  }
}

final addressDeliverProvider = StateNotifierProvider<AddressDeliverNotifier, AddressDeliverState>(
  (ref) => AddressDeliverNotifier(
    AddressDeliverState(
      index: 0,
      addressList: [
        DeliverAddressModel(
          title: 'My Home',
          description:
              'Calle Nueva Finca, numero 123 Barrio la Santa Lucía, sin código postal, Santiago del Estero Capital, Argentina',
          phoneNumber: '(088) 374565834',
          imagePath: paths.houseImage,
        ),
        DeliverAddressModel(
          title: 'My Home 2',
          description:
              'Calle Viejas Finca, numero 321 Barrio la Santa Lucía, sin código postal, Santiago del Estero Capital, Argentina',
          phoneNumber: '(022) 374565834',
          imagePath: paths.houseImage,
        )
      ],
    ),
  ),
);
