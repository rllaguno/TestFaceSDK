# TestFaceSDK
![Static Badge](https://img.shields.io/badge/platform-iOS%20-orange)
![Static Badge](https://img.shields.io/badge/built%20with-SwiftUI-lightblue)

## Descripción de la solución
Para esta tarea, mi solución consiste en una aplicación desarrollada en SwiftUI para dispositivos iOS. Esta aplicación permite la comparación biométrica facial entre una imagen capturada en tiempo real utilizando la herramientas de FaceSDK de Regula y una foto seleccionada de la galeria del usuario. La aplicación guía al usuario a través de un flujo claro y secuencial, ofreciendo instrucciones antes de comenzar el proceso.
A través del interfaz el usuario puede:
- Leer las indicaciones e iniciar el proceso.
- Capturar una imagen facial a través de la cámara.
- Seleccionar una imagén de su galeria de fotos.
- Comparar ambas imágenes para determinar su similitud biométrica.
- Leer el resultado con un porcentaje de coincidencia.

## Patrones utilizados
**Arquitectura VOODO**
- La arquitectura VOODO permite que las vistas no manejen datos directamente, sino que accedan a ellos a través de objetos observables. En esta aplicación, la clase Face centraliza toda la gestión de datos, actualización de estado y funcionalidades clave. Este enfoque mejora el control de acceso y la escalabilidad, mientras mantiene una clara separación entre la lógica y la presentación visual.

**Patrón de Observer**
- Implementado a través del sistema de publicación-suscripción de SwiftUI con @Observable, @State y @Binding. De esta manera las vistas reaccionan automáticamente a los cambios en los datos del modelo.

**Encapsulamiento**
- Las vistas solo interactúan con la clase Face a través de su interfaz pública (propiedades y métodos), sin necesidad de conocer los detalles internos de cómo se comunica con el SDK. Incluso solo se exponen los datos y metodos necesarios, asi se asegura un mejor control de acceso y un mantenimiento simplificado.

## Decisiones técnicas destacadas
**Navegación centralizada**
- La navegación se maneja de manera centralizada a través de un enum con cambio de estados manejado por el objeto observable.

**Diseño por componentes independientes**
- Separación clara de responsabilidades con componentes independientes para cada etapa del proceso. Vistas dedicadas para instrucciones, captura facial, selección de galería y comparación.

**Manejo de ciclo de vida**
- Funciones de initialize() y deinitialize() permiten el uso eficiente de recursos en la aplicación.

**Personalización de UI de FaceSDK**
- Configuración personalizada de la interfaz del SDK mediante UIConfiguration para mantener coherencia con el diseño de la app.

## Mejoras
1. Botón de salir durante el proceso para cancelar el flujo.
2. Mejor manejo de imágenes en horizontal.
3. División de componentes más especializados para arquitectura VOODO.
4. Bug donde si se presiona volver a inicio antes de que este listo el resultado, se muestra resultado anterior antes de actualizar el nuevo resultado en la proxima ronda.
6. Localización
   
## Requerimientos
- iOS 17.0+
- Xcode 16.0+
- Cocoapods

## Frameworks
- SwiftUI
- FaceSDK
- PhotosUI
- UIKit
