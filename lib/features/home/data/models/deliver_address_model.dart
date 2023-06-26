class DeliverAddressModel {
  final String title;
  final String description;
  final String phoneNumber;
  final String imagePath;

  DeliverAddressModel({
    required this.title,
    required this.description,
    required this.phoneNumber,
    required this.imagePath,
  });

  DeliverAddressModel copyWith({
    String? title,
    String? description,
    String? phoneNumber,
    String? imagePath,
  }) {
    return DeliverAddressModel(
        title: title ?? this.title,
        description: description ?? this.description,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        imagePath: imagePath ?? this.imagePath);
  }
}
