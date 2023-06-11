- GO ROUTE/SHELL ROUTE
 Shell route nos sirve para poder mandar views dentro de los screens, sería como una sub navegación de pantallas. Cuando se crea el archivo Router de la app, creamos una instancia general de GoRouter, dentro de ella se encuentran las Routes, que será una lsita de GoRoute, y dentro de esta misma GoRoute, se puede anexar otro listado de rutas [GoRouter, GoRouter], y se llaman por medio del url como por ejemplo: "home/ruta1", "home/ruta2/ruta22"

- IndexedStack
 es un widget que nos ayuda a preservar el estado de un indice en la app, en el ejemplo de las peliculas
se utiliza para que el scroll se mantenga en donde se quedó, cuando se navega con la navigationbar

- Push and local notifications
La notificaciones push, se refieren directamente la las notificaciones que vienen desde otro punto, por ejemplo firebase, por lo regular son ejecutadas directamente en el teléfono y NO PROVOCA QUE LA NOTIFICACIÓN BAJÉ DE LA PARTE SUPERIOR. https://firebase.flutter.dev/docs/messaging/overview/
 Para conseguir que la notificación baje d ela parte superior nos tenemos que auxiliar de las local notifications, en las cuales tenemos que hacer una configuración previa, contenida en el package 
https://pub.dev/packages/flutter_local_notifications. Las Local Notifications nos sirven para mostrar y además organizar nuestras notificaciones, así como darles una función a la hora de ser tappeadas.
* Recomendado configurar primero las push notifications y posteriormente las local Notifications.

