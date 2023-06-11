import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDialogs {
  static Future<void> loadingDialog(BuildContext context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            height: 150,
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox.square(
                  dimension: 25,
                  child: CircularProgressIndicator.adaptive(),
                ),
                Text(
                  'Cargando...',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      );

  static Future<void> errorDialog(BuildContext context, String error) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                  const Text(
                    'Parece que algo salió mal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    error,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  static Future<void> successDialog({
    required BuildContext context,
    String? successMessage,
    void Function()? onPressed,
  }) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            height: 250,
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Éxitoso',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (successMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      successMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ),
        ),
      );

  static Future<void> customAcceptOrCancel({
    required BuildContext context,
    String? bodyMessage,
    String? title,
    void Function()? onPressed,
  }) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            height: 300,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (bodyMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      bodyMessage,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
}

final List<Map<String, double>> configDots = [
  {"top": 20, "right": 180, "opacity": .2, "size": 40},
  {"top": 20, "right": 10, "opacity": .4, "size": 30},
  {"top": 50, "right": 170, "opacity": .8, "size": 20},
  {"top": 80, "right": 30, "opacity": .1, "size": 30},
  {"top": 110, "right": 190, "opacity": .8, "size": 30},
  {"top": 120, "right": 40, "opacity": 1, "size": 10},
];
