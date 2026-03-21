# Fresh DB

Scripts SQL para la base de datos del proyecto Fresh. Esta es la **fuente principal** para crear y modificar la estructura de la BD.

## Estructura

```
├── run.sh                      ← Script para ejecutar SQL contra la BD
├── init.sql                    ← Script maestro (ejecuta todo en orden)
├── tables/                     ← DDL de cada tabla
├── seeds/                      ← Datos iniciales
├── updates/                    ← Migraciones / updates
├── views/                      ← Vistas
└── Doc/                        ← Documentación SQL
```

## Repositorios relacionados

- [fresh-app](https://github.com/DeybyHiguita/fresh-app) — Frontend Angular
- [fresh-api](https://github.com/DeybyHiguita/fresh-api) — Backend .NET 8

## Uso

### Ejecutar todo (crear tablas + seeds)

```bash
cd Sql
DB_PASSWORD=tu_password ./run.sh
```

### Ejecutar un script específico

```bash
DB_PASSWORD=tu_password ./run.sh tables/01_users.sql
DB_PASSWORD=tu_password ./run.sh seeds/01_categories.sql
```

### Variables de entorno (opcionales)

| Variable     | Default                                                    |
|-------------|-------------------------------------------------------------|
| `DB_HOST`   | `ep-bitter-wildflower-amdy6uti-pooler.c-5.us-east-1.aws.neon.tech` |
| `DB_NAME`   | `dbfresh`                                                   |
| `DB_USER`   | `neondb_owner`                                              |
| `DB_PASSWORD` | *(requerido)*                                             |
| `DB_SSLMODE` | `verify-full`                                              |

## Cómo agregar cambios

1. Crea un nuevo archivo `.sql` en la carpeta correspondiente (`tables/`, `seeds/`, `views/`)
2. Usa la numeración secuencial: `06_nueva_tabla.sql`
3. Agrega el `\i` correspondiente en `init.sql`
4. Ejecuta: `DB_PASSWORD=xxx ./run.sh tables/06_nueva_tabla.sql`

## Notas

- Los scripts usan `IF NOT EXISTS` / `ON CONFLICT DO NOTHING`, así que son **idempotentes** (se pueden ejecutar múltiples veces sin errores).
- La numeración `01_`, `02_`... indica el orden de ejecución (resuelve dependencias de foreign keys).
- Requiere `psql` instalado (`brew install libpq` en macOS).
