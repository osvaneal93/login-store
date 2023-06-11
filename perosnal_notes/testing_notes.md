# Notas sobre testing de auth.
## Unit Testing
En primer lugar estamos creando los Mock de las instancias o clases que vamos a utlizar en el testing.
creamos una instancia de auth de firebase, posteriormente se crea una instancia de la clase user, este sería más bien un stream provider.
también tenemos que crear una instancia de repositorio pero en este caso como el repositorio que sería en este caso quien contiene
los métodos de login y registro, tendría que estar escuchando en caso de que hgubiera un cambio de estado en el usuario de firebase, entonces, tiene que 
inicializar en el constructor un listener del estado del usuario. Esto se hace mediante un metodo, entonces, tenemos que avisarle al VS lo que nos devuelve ese método.
por eso primero mediante un when, y then answer (esto lo proporciona ya flutter test) vamos a "inicializar ese método" llamada onAuthStateChange.

creamos un grupo para probar el repositorio de user o lo que vendría siendo el apartado de auth. 
en el primer test, vamos a verificar el método signIn, que está creado en el repositorio de user, este método del repositorio, a su vez, ejecuta el método de de firebase auth signInWithEmailAndPassword(), por lo que tenemos que inicializarlo en mock, como hicimos anteriormente, ene ste caso, estamos aniadiendo al stream "user" un usuario de firebase () que también es mock y retornamos un MockAuthResult que es una instancia propia de firebase, es así que estamos forzando la auth exitosa.

Cabe mencionar que el método onAuthStateChange, del primer párrafo no es un método creado por firebase, es un método creado por nosotros que verifica si existe una isntancia de firebase en el dispositivo, y con base en eso nos devuelve un estado auth o noAuth, recordemos que este método será llamado cada vez que haya un cambio en firebase auth.

bueno, probamos entonces qu el metodo signIn de nuestor repositorio nos devuelva true, y que el status del repo haya cambiado a Authenticated.

Ahora vamos a forzar un fallo, en este caso solamente creamos un nuevo test dentro de nuestro grupo, también creamos un nuevo mock del método signWithEmail etc. pero que devuelva un throw, y probamos que devuelva false y que el status sea unauthenticated.

por ultimo estamos probando unicamente cerrar sesión y verificamos que es status del repositorio esté en Unauthenticated.


## Widget Testing
Primero, creamos los Mock de las instancias que vamos a utilizar (clases), en este caso creamos una clase de UserRepository a la cual le creamos además un FirebaseAuth pero mockeado, hasta ahora no encuentro cual es la razón de que se le haya pasado una instancia de un userMock. 
Abajo, se crearon los objetos user, que es un StreamProvider de un MockFirebaseUser y también creamos un repositorio de user pero sin proporcionarle ningun valor todavía, no es sino recién abajo que le decimos que ese objeto va a contener una instancia del MockUserRepo. Ya probaremos de darle un valor justo cuando se crea. También estamos creando una instancia de firebaseAuth para utilizar los métodos establecidos por Firebase. 

Estamos creando un método que nos facilita el uso de un provider que envuelve el widget que se va a probar, así, no se tenga que esta creando constantemente un Widget distinto (Supongo). Esta método se llama makeTesteable(child) y está conformado por un ChangeNotifierProvider.value que nos va a permitir tener a la mano el repositorio de authUser que es usado en el widget para llamar al método signIn que está justamente en el repositorio. El child de este ChangeNotifier es un Material, que a su vez tiene de child el Widget que se manda en el método cuando es llamado.

En la parte de abajo, estamos creando los finders, que no son más que los identificadores o los componentes con los que nos vamos a guiar para poder interactuar con el widget mientras se está haciendo el test, tenemos diferentes opciones para identificar a los finder, sin embargo lo más recomendable es poder identificasrlos por medio de los key que se le pueden colocar a los widget desd eque son creados en su clase o en su archivo,. 

En esté test estamos creanbdo los finders, de email, password y botón. Los finders los ponemos para uso de forma global en todos los test que se vayas a llevar a cabo para que la interacción sea más accesible dentro de los métodos de testing que se van creando posteriormente.

Creamos un grupo, y el primer test sería verificar que cuando se inicia la app, los elementos de la pantalla son visibles, o podrían verificarse los elementos de un widget en específico, es un test sencillo.

En segundo lugar estamos verificando que cuando se le da click al botón de login, pero los campos están en empty, entonces es ahi en donde nos tiene qwue mostrar el mensaje de que los campos están vacios. Como instrucciuones estamos creando el widget o poniendolo ent ester con pumpWindget, luego simulamos el tap al botón, con los campos sin haberse escrito nada, usamos pump para esperar a que los frame terminen de dibujarse o lo que sea, finalmente ponemos con un expect, el texto de que los campso está, vacíos. lo buscamos con findsOneWidget, que significa que se busque un widget que contenga dicho texto.

Por último, tenemos la verificación de que, cuando ambos campos de login, tienen escrito algo válido, entonces entra al repositorio a hacer el llamado del método de login. como instrucciones, tenemos que llamamos al widget con tester.pumpWidget, después usando enterText(textfieldFinder, "texto a escribir") vamos a escribir el usuario y la contrasenia, damos tap al finder del boton, espermos con pump los frames, y ahí verificamos en el repositorio que efectivamente el metodo signin ha sido invocado con verify(_repo.signIn("test@testmail.com", "password")).called(1)

