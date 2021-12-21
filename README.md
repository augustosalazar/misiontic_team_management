Proyecto Nivelación MisionTic 

Usar el template para crear un repositorio propio, completar el proyecto y verificar que las pruebas de widget e integración funcione

Para la prueba de integración se asume que hay un usuario creado a@a.com con clave 123456

Recordar que la prueba de integración se corre con:   

flutter drive --driver test_driver/integration_test.dart --target integration_test/app_test.dart

Para correr la prueba de integración con el target web seguir los pasos 5b del siguiente link:   
https://docs.flutter.dev/cookbook/testing/integration/introduction   
flutter drive   --driver=test_driver/integration_test.dart   --target=integration_test/app_test.dart   -d web-server --no-headless


Este proyecto trabaja las funcionalidades de Firestore y autenticación de Firebase, hay que agregar el google-services.json y habilitar esos servicios en el firebase console. Ver: https://drive.google.com/file/d/1qPSQkVIiUy6Iv9OfwAC_dTRLvEDPz4pp/view?usp=sharing   

Pista: Revisar los comentarios TODO   


<img src="firebase.gif" width="300" />