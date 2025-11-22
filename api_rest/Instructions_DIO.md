# Guía Completa: Uso de DIO para API REST en Flutter

---

## 1. Instalación de Dependencias

### Paso 1: Agregar DIO a `pubspec.yaml`

En la raíz de tu proyecto Flutter, abre el archivo `pubspec.yaml` y añade DIO bajo la sección `dependencies`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.3.0  # Versión recomendada (verifica la última en pub.dev)
```

**Nota:** Puedes verificar la versión más reciente en [pub.dev/packages/dio](https://pub.dev/packages/dio)

### Paso 2: Ejecutar `pub get`

En la terminal de Android Studio, ejecuta:

```bash
flutter pub get
```

O desde la línea de comandos en la raíz del proyecto:

```bash
pub get
```

**Resultado esperado:** Verás un mensaje `Running "flutter pub get"...` y el proceso se completará sin errores.

---

## 2. Configuración de Permisos en AndroidManifest.xml

### ⚠️ PERMISO INTERNET (Obligatorio)

Para permitir que tu aplicación acceda a internet, debes agregar el permiso `INTERNET` en los siguientes archivos:

- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/debug/AndroidManifest.xml` (si existe)

### Línea a Agregar

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

### Ubicación Correcta en el Archivo

El permiso debe estar **antes** del cierre de la etiqueta `</manifest>`, generalmente después de otras líneas `<uses-permission>`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Otros permisos -->
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <!-- ↓ AGREGAR ESTA LÍNEA ↓ -->
    <uses-permission android:name="android.permission.INTERNET"/>
    
    <application>
        <!-- contenido de la aplicación -->
    </application>
</manifest>
```

### Verificación

Después de agregar la línea, reconstruye la app:

```bash
flutter clean
flutter pub get
flutter run
```

---

## 3. Uso Básico de DIO

### Configuración Inicial

Crea una instancia de Dio con configuración base recomendada:

```dart
import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.sampleapis.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    validateStatus: (status) => status != null && status < 500,
  ),
);
```

**Parámetros explicados:**
- `baseUrl`: URL base de la API (todas las peticiones se concatenan a esta)
- `connectTimeout`: Tiempo máximo para conectar (5 segundos)
- `receiveTimeout`: Tiempo máximo para recibir datos (5 segundos)
- `validateStatus`: Función que determina si la respuesta es válida

### Petición GET (Obtener Datos)

```dart
Future<void> fetchWines() async {
  try {
    final response = await dio.get('/wines/reds');
    
    if (response.statusCode == 200) {
      print('Datos recibidos: ${response.data}');
      // Procesar los datos aquí
    }
  } on DioException catch (e) {
    print('Error DIO: ${e.message}');
  }
}
```

### Petición POST (Enviar Datos)

```dart
Future<void> sendWineData() async {
  try {
    final response = await dio.post(
      '/wines',
      data: {
        'winery': 'Villa Maria',
        'wine': 'Sauvignon Blanc',
        'rating': {'average': 4.5, 'reviews': 120},
      },
    );
    print('Respuesta: ${response.data}');
  } on DioException catch (e) {
    print('Error al enviar: ${e.message}');
  }
}
```

### Petición con Headers Personalizados

```dart
Future<void> fetchWithHeaders() async {
  try {
    final response = await dio.get(
      '/wines/reds',
      options: Options(
        headers: {
          'Authorization': 'Bearer token_aqui',
          'Content-Type': 'application/json',
        },
      ),
    );
    print('Respuesta: ${response.data}');
  } on DioException catch (e) {
    print('Error: ${e.message}');
  }
}
```

---

## 4. Manejo de Errores Común

### DioException - Captura Completa

```dart
Future<void> robustFetch() async {
  try {
    final response = await dio.get('/wines/reds');
  } on DioException catch (e) {
    if (e.response != null) {
      // Error HTTP (4xx, 5xx)
      print('Status Code: ${e.response?.statusCode}');
      print('Error Data: ${e.response?.data}');
      
      switch (e.response?.statusCode) {
        case 404:
          print('Recurso no encontrado');
          break;
        case 401:
          print('No autorizado');
          break;
        case 500:
          print('Error en el servidor');
          break;
      }
    } else if (e.type == DioExceptionType.connectionTimeout) {
      print('Timeout de conexión');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      print('Timeout al recibir datos');
    } else {
      print('Error desconocido: ${e.message}');
    }
  } catch (e) {
    print('Error inesperado: $e');
  }
}
```

### Códigos de Error Comunes

| Código | Significado | Solución |
|--------|-------------|----------|
| **200** | OK | Datos recibidos correctamente |
| **201** | Created | Recurso creado exitosamente |
| **400** | Bad Request | Verificar la estructura de datos enviados |
| **401** | Unauthorized | Verificar token/autenticación |
| **404** | Not Found | Verificar la URL/endpoint |
| **500** | Server Error | Error en el servidor |
| **timeout** | Conexión expirada | Aumentar timeout o revisar red |

---

## 5. Solución de Problemas: Sin Conexión a la API

###  Problema: "No se puede acceder a la API"

Si experimentas errores de conexión, timeout o respuestas 404:

```
DioException [connection error]: Failed to connect to the host
```

### Solución: Usar VPN

**¿Por qué usar VPN?**
- Algunos ISP bloquean puertos específicos
- Algunos endpoints públicos pueden no ser accesibles en ciertas regiones
- Problemas de firewall en la red local

**Pasos a seguir:**

#### En tu Computadora:

1. Descarga una VPN confiable:
    - Ejemplos: ProtonVPN, Windscribe, TunnelBear
2. Instala la aplicación VPN

3. Conecta a la VPN (elige un servidor, ej: USA o Europa)

4. Verifica que la VPN está activa

#### En tu Celular (en mi caso Infinix X6826):

A mí me funcionó bien el conectar a una VPN gratuita y conexión directa a ehternet desde el computador

Caso contrario puedes instalar una app de VPN en el celular que sea compatible a la de tu computador.

#### Verificación Final:

1. **Ambos dispositivos (PC y celular) deben estar conectados a la MISMA VPN**
2. **Están conectados a la MISMA red WiFi (opcional pero recomendado)**
3. Reinicia la app en el celular:

```bash
flutter run
```

---

## 6. Validación de Conexión

### Función para Probar Conectividad

```dart
Future<void> testApiConnection() async {
  try {
    final response = await dio.get(
      'https://api.sampleapis.com/wines/reds',
      options: Options(
        validateStatus: (status) => true, // Acepta cualquier status
      ),
    );
    
    print(' Status: ${response.statusCode}');
    print(' Datos recibidos: ${response.data.length} items');
    
    if (response.statusCode == 200) {
      print('Conexión exitosa');
    } else {
      print('Status inesperado: ${response.statusCode}');
    }
  } catch (e) {
    print(' Error de conexión: $e');
  }
}
```



---

## 7. Integración en el Proyecto

### Estructura Recomendada

```
lib/
├── infraestructure/
│   ├── models/
│   │   ├── wine.dart
│   │   └── pokemon.dart
│   └── services/
│       └── api_service.dart  ← Aquí va la lógica centralizada de DIO
├── design/
│   ├── homepage.dart
│   ├── screenWine.dart       ← Aquí se usan los datos
│   ├── atoms/
│   ├── molecules/
│   └── organisms/
└── main.dart
```

### Ejemplo: `lib/infraestructure/services/api_service.dart`

```dart
import 'package:dio/dio.dart';
import '../models/wine.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.sampleapis.com',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
  }

  Future<List<Wine>> getWines() async {
    try {
      final response = await dio.get('/wines/reds');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((item) => Wine.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error DIO: ${e.message}');
    }
  }
}
```

### Uso en `lib/design/screenWine.dart`

```dart
import 'package:api_rest/infraestructure/services/api_service.dart';
import 'package:api_rest/infraestructure/models/wine.dart';

class WineScreen extends StatefulWidget {
  @override
  State<WineScreen> createState() => _WineScreenState();
}

class _WineScreenState extends State<WineScreen> {
  late ApiService apiService;
  List<Wine> wines = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    getWines();
  }

  Future<void> getWines() async {
    setState(() => isLoading = true);
    try {
      final data = await apiService.getWines();
      setState(() {
        wines = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return ListView.builder(
      itemCount: wines.length,
      itemBuilder: (context, index) {
        final wine = wines[index];
        return ListTile(
          title: Text(wine.wine),
          subtitle: Text(wine.winery),
        );
      },
    );
  }
}
```

---

###  ¿Es obligatoria la VPN?
**R:** No siempre, pero úsala si experimentas problemas de conexión. La mayoría de ISP permiten conexiones normales a APIs públicas.

---

**Última actualización:** 22 de Noviembre de 2024  
**Versión de Flutter:** Compatible con Flutter 3.0+  
**Versión de Dio:** 5.3.0+

