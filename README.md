# Flutter Product To-Do

## Descripción

Esta aplicación Flutter permite a los usuarios revisar productos obtenidos de una API ficticia. Los usuarios pueden aprobar o rechazar productos, y los estados se almacenan localmente utilizando Hive. La aplicación sigue una arquitectura de Clean Architecture para mantener un código limpio y escalable.

## Requerimientos

- Flutter 2.0 o superior
- Dart 2.12 o superior

## Requerimientos funcionales

### Pantallas principales

1. **Productos por revisar**

   - Muestra una lista inicial de 10 productos obtenidos de una API fake (MockAPI).
   - Cada producto incluye un checkbox para aprobar o rechazar.

2. **Productos revisados**
   - Lista con scroll infinito y paginación (7 productos por página) que muestra los productos aprobados o rechazados.
   - Cada producto se presenta en una card con un diseño limpio.

### Funcionalidades

- Eliminar producto de la lista.
- Ver detalles del producto en un dialog/modal.

### Almacenamiento local

- Implementa una base de datos local utilizando Hive para guardar los datos de los productos y sus estados (aprobados/rechazados).

## Arquitectura utilizada

- **Clean Architecture**: Se ha utilizado esta arquitectura para dividir la lógica de la aplicación de forma que sea mantenible y escalable.

## Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/UnCubanoDev/product_todo.git
   ```
