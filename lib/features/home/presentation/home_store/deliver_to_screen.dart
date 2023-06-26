import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/deliver_item/deliver_item.dart';
import 'package:multi_store_app/features/providers/deliver_address/deliver_address_provider.dart';
import 'package:multi_store_app/features/shared/widgets/custom_shop_elevated_button.dart';

class DeliveryToScreen extends ConsumerWidget {
  static const String path = '/delivery-to';
  const DeliveryToScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final deliverProviderWatch = ref.watch(addressDeliverProvider);
    final deliverProviderRead = ref.read(addressDeliverProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_circle_left_outlined)),
          backgroundColor: Colors.amber,
          title: Text(
            'Deliver To',
            style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                deliverProviderWatch.addressList?.length ?? 0,
                (index) => CustomDeliverItem(
                    onTap: () => deliverProviderRead.changeAddressIndex(index),
                    imagePath: deliverProviderWatch.addressList?[index].imagePath ?? '',
                    isSelected: index == deliverProviderWatch.index,
                    title: deliverProviderWatch.addressList?[index].title ?? '',
                    phoneNumber: deliverProviderWatch.addressList?[index].phoneNumber ?? '',
                    address: deliverProviderWatch.addressList?[index].description ?? ''),
              ),
              const CustomShopElevatedButton(
                color: Colors.transparent,
                label: 'Add new address',
                buttonSize: ButtonSize.large,
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
