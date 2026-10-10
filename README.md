# Calculadora de Calidad del Aire 🌬️

Una aplicación móvil desarrollada en Flutter que permite consultar de manera asíncrona la calidad del aire (PM2.5) en diferentes ciudades de Colombia usando la API pública de Open-Meteo. Además, la aplicación estima un índice de exposición diaria y clasifica el riesgo para la salud del usuario.

## 📱 Características

* **Consulta Asíncrona:** Integración con la API de Open-Meteo.
* **Cálculo de Riesgo:** Evaluación del riesgo de exposición (Bajo, Moderado, Alto) basado en horas al aire libre.
* **Interfaz Profesional:** Diseño moderno e intuitivo basado en Material 3.
* **Arquitectura MVC:** Separación clara de responsabilidades (Modelos, Vistas y Controladores).
* **Manejo de Errores:** Feedback visual (Snackbars) ante fallos de conexión o datos incompletos.

## 🏗️ Arquitectura del Proyecto

El proyecto sigue el patrón de diseño MVC (Modelo-Vista-Controlador):

```text
lib/
├── main.dart
├── controllers/
│   └── air_quality_controller.dart  # Lógica de cálculo y clasificación de riesgo
├── models/
│   ├── air_quality_model.dart       # Parseo de datos de la API (PM2.5)
│   └── city_model.dart              # Estructura de datos de las ciudades
├── services/
│   └── api_service.dart             # Peticiones HTTP a Open-Meteo
├── views/
│   └── calculator_view.dart         # Pantalla principal de la calculadora
└── widgets/
    ├── custom_dropdown.dart         # Componente de selección de ciudad
    ├── custom_text_field.dart       # Componente de entrada de datos
    └── result_card.dart             # Tarjeta dinámica para mostrar el resultado
```

## 🚀 Requisitos Funcionales Implementados

1. Selección de una ciudad de Colombia (Cartagena, Medellín, Bogotá, Cali, Barranquilla).
2. Selección de una fecha específica.
3. Ingreso de horas de exposición al aire libre.
4. Extracción y cálculo del promedio diario de PM2.5.
5. Clasificación del nivel de riesgo.

## 🛠️ Tecnologías Usadas

* **Dart**
* **Flutter**
* **http** (Paquete para peticiones a la API)

## ⚙️ Cómo ejecutar el proyecto

1. Clona este repositorio.
2. Abre la terminal en la carpeta del proyecto.
3. Descarga las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## 📌 Fórmula de Cálculo

El índice de exposición se calcula internamente mediante la fórmula:
`Índice de Exposición = Promedio PM2.5 × Horas de Exposición`

Los rangos de clasificación son:
* `< 100` : **Bajo**
* `100 - 200` : **Moderado**
* `> 200` : **Alto**
