# Fresh - Manual de Base de Datos

## Tabla de Contenido

1. [Visión General](#1-visión-general)
2. [Requisitos Previos](#2-requisitos-previos)
3. [Estructura](#3-estructura)
4. [Crear un Cambio (paso a paso)](#4-crear-un-cambio-paso-a-paso)
5. [Ejecutar Scripts](#5-ejecutar-scripts)
6. [Escenarios Comunes](#6-escenarios-comunes)
7. [Troubleshooting](#7-troubleshooting)
8. [Reglas y Convenciones](#8-reglas-y-convenciones)

---

## 1. Visión General

Fresh usa **scripts SQL planos** para gestionar la base de datos. No se usan migraciones de EF Core.

```
Crear/editar script SQL  →  Ejecutar con run.sh  →  Listo
```

Los scripts están en la carpeta `Sql/` y se ejecutan con `psql` a través del script `run.sh`.

---

## 2. Requisitos Previos

```bash
# psql (cliente de PostgreSQL)
brew install libpq
brew link --force libpq

# Verificar
psql --version
```

---

## 3. Estructura

```
Sql/
├── run.sh                      ← Script para ejecutar SQL contra la BD
├── init.sql                    ← Script maestro (ejecuta todo en orden)
├── tables/                     ← DDL de cada tabla
│   ├── 01_users.sql
│   ├── 02_categories.sql
│   ├── 03_ingredients.sql
│   ├── 04_recipes.sql
│   └── 05_recipe_ingredients.sql
├── seeds/                      ← Datos iniciales
│   └── 01_categories.sql
└── views/                      ← Vistas (futuro)
```

---

## 4. Crear un Cambio (paso a paso)

### Ejemplo: Agregar el campo `phone` a la tabla `users`

#### Paso 1 — Crear el script SQL

Crear `Sql/tables/06_add_phone_to_users.sql`:

```sql
-- Agregar campo phone a users
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone VARCHAR(20);
```

#### Paso 2 — Agregar al init.sql (si aplica)

```sql
\echo '  -> add phone to users'
\i tables/06_add_phone_to_users.sql
```

#### Paso 3 — Actualizar el script de la tabla original

Editar `Sql/tables/01_users.sql` para que refleje el estado actual:

```sql
CREATE TABLE IF NOT EXISTS users (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    password        TEXT            NOT NULL,
    role            VARCHAR(20)     NOT NULL DEFAULT 'employee',
    phone           VARCHAR(20),
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);
```

#### Paso 4 — Ejecutar

```bash
cd Sql
DB_PASSWORD=tu_password ./run.sh tables/06_add_phone_to_users.sql
```

#### Paso 5 — Actualizar la entidad en C# (para que el API la use)

Editar `Api/Fresh.Core/Entities/User.cs`:

```csharp
public string? Phone { get; set; }
```

Y en `FreshDbContext.cs` agregar el mapeo:

```csharp
entity.Property(e => e.Phone).HasColumnName("phone").HasMaxLength(20);
```

---

## 5. Ejecutar Scripts

### Todo desde cero

```bash
cd Sql
DB_PASSWORD=tu_password ./run.sh
```

### Un script específico

```bash
DB_PASSWORD=tu_password ./run.sh tables/01_users.sql
DB_PASSWORD=tu_password ./run.sh seeds/01_categories.sql
```

### Con variables personalizadas

```bash
DB_HOST=otro-host DB_NAME=otra_bd DB_USER=otro_user DB_PASSWORD=xxx ./run.sh
```

### Directo con psql (sin run.sh)

```bash
psql "host=<HOST> dbname=dbfresh user=neondb_owner sslmode=verify-full" -f init.sql
```

---

## 6. Escenarios Comunes

### Agregar una tabla nueva

1. Crear `Sql/tables/06_nueva_tabla.sql` con `CREATE TABLE IF NOT EXISTS`
2. Agregar `\i tables/06_nueva_tabla.sql` en `init.sql`
3. Ejecutar: `DB_PASSWORD=xxx ./run.sh tables/06_nueva_tabla.sql`
4. Crear la entidad correspondiente en `Fresh.Core/Entities/`
5. Agregar `DbSet` y configuración en `FreshDbContext.cs`

### Agregar una columna

1. Crear script con `ALTER TABLE ... ADD COLUMN IF NOT EXISTS`
2. Actualizar el script original de la tabla
3. Ejecutar el nuevo script
4. Actualizar la entidad C# y el DbContext

### Agregar datos iniciales (seed)

1. Crear `Sql/seeds/02_nuevo_seed.sql` con `INSERT ... ON CONFLICT DO NOTHING`
2. Agregar `\i seeds/02_nuevo_seed.sql` en `init.sql`
3. Ejecutar: `DB_PASSWORD=xxx ./run.sh seeds/02_nuevo_seed.sql`

### Renombrar una columna

```sql
ALTER TABLE users RENAME COLUMN old_name TO new_name;
```

### Eliminar una columna

```sql
ALTER TABLE users DROP COLUMN IF EXISTS phone;
```

---

## 7. Troubleshooting

| Problema | Causa | Solución |
|----------|-------|----------|
| `psql: command not found` | psql no instalado | `brew install libpq && brew link --force libpq` |
| `Connection refused` | BD no accesible | Verificar host, credenciales, SSL |
| `Relation already exists` | Tabla ya existe | Usar `IF NOT EXISTS` en CREATE TABLE |
| `Column already exists` | Columna ya agregada | Usar `IF NOT EXISTS` en ADD COLUMN |
| `Permission denied` | run.sh no es ejecutable | `chmod +x Sql/run.sh` |
| `Falta DB_PASSWORD` | Variable no definida | `DB_PASSWORD=xxx ./run.sh` |

---

## 8. Reglas y Convenciones

### Nombrado

| Elemento | Convención | Ejemplo |
|----------|-----------|---------|
| Tablas | snake_case, plural | `users`, `recipe_ingredients` |
| Columnas | snake_case | `created_at`, `category_id` |
| Scripts de tablas | `NN_nombre.sql` | `01_users.sql` |
| Scripts de cambios | `NN_descripcion.sql` | `06_add_phone_to_users.sql` |
| Seeds | `NN_nombre.sql` | `01_categories.sql` |

### Reglas

1. **Siempre** usar `IF NOT EXISTS` / `ON CONFLICT DO NOTHING` para que los scripts sean idempotentes
2. **Siempre** actualizar el script original de la tabla al agregar cambios
3. **Siempre** hacer backup antes de cambios destructivos (DROP, ALTER)
4. Los campos de fecha usan `TIMESTAMPTZ` y default `NOW()`
5. Las tablas incluyen `created_at` y `updated_at`
6. Usar soft delete (`is_active = false`) en lugar de DELETE cuando aplique
7. Mantener sincronizados los scripts SQL con las entidades C# y el DbContext

---

*Última actualización: 19 de marzo de 2026*
