#!/bin/bash
# Author: Oscar Gonzalez Luna
# Date: $(date +'%Y-%m-%d')
# Description: Script para crear un proyecto de .NET

# Verifica que se haya pasado el nombre de proyecto
if [ -z "$1" ]; then
    echo "Por favor, proporcione el nombre del proyecto"
    exit 1
fi

# Variables
projectName=$1

# Crea un proyecto de minimal API de .NET
echo "Creando proyecto de minimal API de .NET"
dotnet new webapi -n $projectName

# Crea un proyecto de pruebas para el proyecto de minimal API
echo "Creando proyecto de pruebas para el proyecto de minimal API"
dotnet new xunit -n $projectName.Tests

# Agrega referencia al proyecto de pruebas
echo "Agregando referencia al proyecto de pruebas"
dotnet add $projectName.Tests/$projectName.Tests.csproj reference $projectName/$projectName.csproj

# Crea un archivo de solución
echo "Creando archivo de solución"
dotnet new sln -n $projectName

# Agrega los proyectos al archivo de solución
echo "Agregando proyectos al archivo de solución"
dotnet sln $projectName.sln add $projectName/$projectName.csproj
dotnet sln $projectName.sln add $projectName.Tests/$projectName.Tests.csproj

# Agrega paquetes los paquetes necesarios al proyecto de tests
echo "Agregando paquetes de pruebas"
dotnet add $projectName.Tests/$projectName.Tests.csproj package Microsoft.AspNetCore.Mvc.Testing
dotnet add $projectName.Tests/$projectName.Tests.csproj package MiniValidation

# Agrega un archivo de docker en el proyecto de minimal API
echo "Agregando archivo de docker al proyecto de minimal API"

cat <<EOL > $projectName/Dockerfile
# Use the official .NET SDK image as a build stage.
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS build
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official runtime image as a runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Expose the port
EXPOSE 80

# Run the application
ENTRYPOINT ["dotnet", "$projectName.dll"]
EOL

echo "Archivo de docker agregado"

echo "Proyecto creado exitosamente"
