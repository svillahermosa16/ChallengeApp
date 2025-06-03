# Mobile App Challenge: Mercadolibre

Este repositorio contiene el proyecto correspondiente a la instancia de desafío técnico del proceso de selección de Mercadolibre.

## Características

- **Búsqueda de productos**: Interfaz simple y eficiente para encontrar productos
- **Lista de resultados**: Visualización organizada de los productos encontrados
- **Detalle de producto**: Vista completa con información detallada del producto seleccionado

## Arquitectura

### Patrón de diseño
**MVI (Model-View-Intent)** 

### Stack técnico
- **UI Framework**: SwiftUI
- **Networking**: URLSession nativo (sin dependencias externas)
- **Mínimo iOS**: 16.0+
- **Mínimo Xcode**: 15.0

### Estructura del proyecto
```
├── Core/               # Coordinator y helpers
├── Modules/            # Lógica de presentación (MVI) y vistas
├── Networking/         # Modelos de datos, APIs y capa de networking
├── Repository/         # Abstracción de fuentes de datos
├── Assets/             # Fuentes multimedia
└── Utils/              # Elementos de UI reutilizables
```

## Pantallas

### 🏠 Home
- Campo de búsqueda principal
- Validación de entrada en tiempo real

![Screenshot](https://imgur.com/a/1yJTjlH)

### 📋 Lista de Resultados
- Resultados paginados de la búsqueda

![Screenshot](https://imgur.com/a/ffpoUlb)

### 🔍 Detalle de Producto
- Información completa del producto
- Galería de imágenes
- Especificaciones técnicas

![Screenshot](https://imgur.com/a/YBecaTn)

## Dependencias

Sin dependencias externas - El proyecto utiliza únicamente frameworks nativos de iOS:

- `URLSession` para networking
- `SwiftUI` para UI
- `Combine` para reactive programming
- `XCTest` para testing

## Configuración de desarrollo

### Requisitos
- macOS 13.0+
- Xcode 15.0+
- iOS 16.0+ (dispositivo/simulador)


## Autor

**@svillahermosa16** - Desarrollo y mantenimiento







