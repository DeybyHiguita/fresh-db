# Fresh - Guia SQL para macOS

## Requisitos

- Terminal
- VS Code
- Cliente `psql` instalado

Instalar `psql` en macOS:

```bash
brew install libpq
brew link --force libpq
```

Verificar instalacion:

```bash
psql --version
```

## Ejecutar scripts SQL

1. Abre Terminal.
2. Ve a la carpeta SQL del proyecto:

```bash
cd /Users/<tu_usuario>/ruta/fresh-app/Sql
```

3. Define la clave y ejecuta.

Ejecutar todo:

```bash
DB_PASSWORD=tu_password ./run.sh
```

Ejecutar un script especifico:

```bash
DB_PASSWORD=tu_password ./run.sh tables/01_users.sql
```

## Errores comunes

- `psql: command not found`: ejecuta `brew install libpq && brew link --force libpq`.
- `Permission denied: ./run.sh`: ejecuta `chmod +x run.sh`.
- `Error: Falta la variable DB_PASSWORD`: agrega `DB_PASSWORD=tu_password` antes del comando.
