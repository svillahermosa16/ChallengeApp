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

![m2b6iyD](https://github.com/user-attachments/assets/b5ad6efa-bf81-473f-b79e-3f5977648ce4)

### 📋 Lista de Resultados
- Resultados paginados de la búsqueda

![ARDwlER](https://github.com/user-attachments/assets/0fd23a6d-a551-4318-be9b-39b1f4b28c36)

### 🔍 Detalle de Producto
- Información completa del producto
- Galería de imágenes
- Especificaciones técnicas

![vTOlfCo](https://github.com/user-attachments/assets/50896b9c-3982-4701-84e9-bf0b4dc93026)

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







