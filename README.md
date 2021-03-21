# DiscourseClientV2
Aplicación de práctica para el modulo UI Avanzada en iOS del Bootcamp Mobile de Keepcoding

La aplicación consiste en un cliente de Discourse que usa la API de Discourse proporcionada por KeepCoding.

Se ha partido del cliente anterior, aplicando el diseño facilitado

## Algunas de las funcionalidades y caracteristicas que incluye
- uso del patrón MVVM+C
- uso de SessionAPI para conexiones de red
- uso de protocolos y delegados para las comunicaciones entre entidades
- Listado de topics de Discourse en un TableView con dos tipos de celdas
- Creación de componente para reutilizarlo en varias pantallas
- Scroll to top al hacer tap en el item de la TabBar
- Animación de entrada para las imágenes de usuario
- Pull to refresh del listado de topics y usuarios
- Añadir nuevo topic
- Actualización del listado al terminar las acciones
- Listado de usuarios en un CollectionView con nombre y avatar
- Pantalla de configuración con lectura y escritura en el KeyChain