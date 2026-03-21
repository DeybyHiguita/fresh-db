# Fresh DB

Scripts SQL para la base de datos del proyecto Fresh. Esta es la **fuente principal** para crear y modificar la estructura de la BD.

## Estructura

```
├── run.sh              ← Script para ejecutar SQL contra la BD (macOS/Linux)
├── run.ps1             ← Script para ejecutar SQL contra la BD (Windows)
├── init.sql            ← Script maestro (ejecuta todo en orden)
├── tables/             ← DDL de cada tabla (CREATE TABLE)
├── seeds/              ← Datos iniciales (INSERT)
├── updates/            ← Migraciones / cambios incrementales
├── views/              ← Vistas SQL
└── Doc/                ← Documentación de la base de datos
```

## Repositorios relacionados

- [fresh-app](https://github.com/DeybyHiguita/fresh-app) — Frontend Angular
- [fresh-api](https://github.com/DeybyHiguita/fresh-api) — Backend .NET 8

---

## Requisitos

- `psql` (cliente de PostgreSQL)
  - **macOS**: `brew install libpq && brew link --force libpq`
  - **Windows**: se instala con [PostgreSQL](https://www.postgresql.org/download/windows/)

---

## Uso

### Ejecutar todo (crear tablas + seeds)

```bash
DB_PASSWORD=tu_password ./run.sh
```

### Ejecutar un script específico

```bash
DB_PASSWORD=tu_password ./run.sh tables/01_users.sql
DB_PASSWORD=tu_password ./run.sh seeds/01_categories.sql
```

### Windows (PowerShell)

```powershell
$env:DB_PASSWORD="tu_password"
.\run.ps1
# o un script específico:
.\run.ps1 tables/01_users.sql
```

---

## Variables de entorno

| Variable | Default | Descripción |
|----------|---------|-------------|
| `DB_HOST` | `ep-bitter-wildflower-amdy6uti-pooler.c-5.us-east-1.aws.neon.tech` | Host de la BD |
| `DB_NAME` | `dbfresh` | Nombre de la BD |
| `DB_USER` | `neondb_owner` | Usuario |
| `DB_PASSWORD` | *(requerido)* | Contraseña |
| `DB_SSLMODE` | `require` | Modo SSL |

---

## Cómo agregar cambios

1. Crea un nuevo archivo `.sql` en la carpeta correspondiente (`tables/`, `seeds/`, `views/`, `updates/`)
2. Usa la numeración secuencial: `17_nueva_tabla.sql`
3. Si es una tabla nueva, agrega el `\i` correspondiente en `init.sql`
4. Ejecuta: `DB_PASSWORD=xxx ./run.sh tables/17_nueva_tabla.sql`

---

## Notas

- Los scripts usan `IF NOT EXISTS` / `ON CONFLICT DO NOTHING`, así que son **idempotentes** (se pueden ejecutar múltiples veces sin errores)
- La numeración `01_`, `02_`... indica el orden de ejecución (resuelve dependencias de foreign keys)
- La carpeta `updates/` es para cambios incrementales (ALTER TABLE, etc.) que no van en el `init.sql`
- Ver la carpeta `Doc/` para guías detalladas sobre SQL
