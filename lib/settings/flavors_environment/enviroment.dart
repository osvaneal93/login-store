import 'package:flutter/material.dart';

enum FlavorEnvironment {
  prod(
      apiKey: "00000012",
      devName: "Osva Marín",
      envName: "Producción",
      url: "prod.store.app/test",
      schemeColor: Colors.green),
  dev(
      apiKey: "00000013",
      devName: "OsvaMarín",
      envName: "Desarrollo",
      url: "dev.store.app/test",
      schemeColor: Colors.yellow);

  const FlavorEnvironment(
      {required this.envName,
      required this.apiKey,
      required this.url,
      required this.devName,
      required this.schemeColor});
  final String envName, apiKey, url, devName;
  final Color schemeColor;
}
