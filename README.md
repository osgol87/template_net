# template_net

Este proyecto es una plantilla para crear una API mínima en .NET 8 con un proyecto de pruebas asociado. El script `generador.sh` automatiza la creación de estos proyectos, la configuración de Docker y la adición de paquetes necesarios para las pruebas.

## Estructura del Proyecto

La estructura del proyecto es la siguiente:

```plaintext
template_net/
├── .gitignore
├── generador.sh
├── NombreDelProyecto.sln
├── NombreDelProyecto/
│   ├── appsettings.Development.json
│   ├── appsettings.json
│   ├── Dockerfile
│   ├── NombreDelProyecto.csproj
│   ├── Program.cs
│   ├── Properties/
│   │   ├── launchSettings.json
├── NombreDelProyecto.Tests
│   ├── NombreDelProyecto.Tests.csproj
│   ├── UnitTest1.cs
├── README.md
```

## Uso

Para usar esta plantilla, sigue los siguientes pasos:

1. Clona el repositorio.
2. Ejecuta el script `generador.sh` proporcionando el nombre del proyecto como argumento:

```sh
./generador.sh NombreDelProyecto
```

Este script realizará las siguientes acciones:

- Creará un proyecto de API mínima en .NET.
- Creará un proyecto de pruebas asociado.
- Agregará referencias y paquetes necesarios.
- Configurará Docker para el proyecto.

## Configuración de Docker

El archivo Dockerfile generado permite construir y ejecutar la aplicación en un contenedor Docker. Para construir y ejecutar el contenedor, usa los siguientes comandos:

```sh
docker build -t nombre-del-proyecto .
docker run -p 80:80 nombre-del-proyecto
```

## Archivos de Configuración

- appsettings.json y appsettings.Development.json: Configuración de la aplicación.
- launchSettings.json: Configuración de lanzamiento para entornos de desarrollo.

## Pruebas

El proyecto de pruebas utiliza xUnit y está configurado para ejecutarse con dotnet test. Para ejecutar las pruebas, usa el siguiente comando:

```sh
dotnet test
```

## Licencia

Este proyecto está licenciado bajo la Licencia MIT.

Este README.md proporciona una introducción clara sobre lo que hace el proyecto, cómo usarlo, su estructura y cómo ejecutar las pruebas.
