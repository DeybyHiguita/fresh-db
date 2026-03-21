# Fresh - Guia Paso a Paso para Desplegar Scripts SQL en Windows

## Lo que necesitas

| # | Aplicación | Para qué |
|---|------------|----------|
| 1 | **PowerShell** (ya viene en Windows) | Ejecutar los comandos |
| 2 | **VS Code** | Ver y editar los scripts SQL |

> En Windows usa el script `run.ps1`.

---

## Requisito único (solo la primera vez)

Instalar `psql` (cliente de PostgreSQL) en Windows:

```powershell
winget install --id PostgreSQL.PostgreSQL --source winget
```

Verificar que quedó instalado:

```powershell
psql --version
```

---

## Paso a paso: Ejecutar un script SQL

### 1. Abrir Terminal

- Opcion A: Menu Inicio -> escribir "PowerShell" -> Enter
- Opcion B: En VS Code -> menu Terminal -> New Terminal

### 2. Ir a la carpeta Sql

```powershell
cd C:\U\fresh-app\Sql
```

### 3. Ejecutar el script

**Ejecutar TODO (tablas + seeds):**

```powershell
$env:DB_PASSWORD="npg_qYzDMSV8OF6U"
.\run.ps1
```

**Ejecutar solo un script específico:**

```powershell
$env:DB_PASSWORD="npg_qYzDMSV8OF6U"
.\run.ps1 tables/06_Logs.sql
```

### 4. Ver el resultado

Si todo sale bien, verás algo así:

```
=== Fresh Database ===
  Host: ep-bitter-wildflower-amdy6uti-pooler.c-5.us-east-1.aws.neon.tech
  Base: dbfresh
  Script: tables/01_users.sql

CREATE TABLE

=== Listo ===
```

---

## Ejemplo completo: Crear una tabla nueva

### 1. Abrir VS Code

Abrir la carpeta del proyecto: `File -> Open Folder -> fresh-app`

### 2. Crear el archivo SQL

Crear un nuevo archivo en `Sql/tables/`, por ejemplo `06_productos.sql`:

```sql
CREATE TABLE IF NOT EXISTS productos (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100)    NOT NULL,
    price           DECIMAL(10,2)   NOT NULL,
    category_id     INTEGER         REFERENCES categories(id),
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);
```

### 3. Agregar al init.sql (opcional)

Abrir `Sql/init.sql` y agregar antes de los seeds:

```sql
\echo '  -> productos'
\i tables/06_productos.sql
```

### 4. Abrir PowerShell y ejecutar

```powershell
cd C:\U\fresh-app\Sql
$env:DB_PASSWORD="npg_qYzDMSV8OF6U"
.\run.ps1 tables/06_productos.sql
```

### 5. Verificar que se creó

```powershell
$env:DB_PASSWORD="npg_qYzDMSV8OF6U"
.\run.ps1
```

Si la tabla ya existe, no dará error gracias al `IF NOT EXISTS`.

---

## Ejemplo completo: Agregar una columna a una tabla existente

### 1. Crear el script SQL en VS Code

Crear `Sql/tables/06_add_phone_to_users.sql`:

```sql
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone VARCHAR(20);
```

### 2. Ejecutar en PowerShell

```powershell
cd C:\U\fresh-app\Sql
$env:DB_PASSWORD="npg_qYzDMSV8OF6U"
.\run.ps1 tables/06_add_phone_to_users.sql
```

### 3. Actualizar el script original

Editar `Sql/tables/01_users.sql` para que refleje el campo nuevo (para referencia futura).

---

## Resumen rápido

```
1. Abrir VS Code         → crear/editar el .sql
2. Abrir Terminal         → cd Sql
3. Ejecutar               → $env:DB_PASSWORD="xxx"; .\run.ps1 tables/mi_script.sql
4. Listo ✓
```

---

## Si algo falla

| Error | Qué hacer |
|-------|-----------|
| `psql: command not found` | Instalar PostgreSQL con `winget install --id PostgreSQL.PostgreSQL --source winget` y reabrir PowerShell |
| `Error: Falta la variable DB_PASSWORD` | Ejecutar `$env:DB_PASSWORD="npg_qYzDMSV8OF6U"` antes de `.\run.ps1` |
| `No se pueden cargar scripts` | Ejecutar `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` en esa terminal |
| `Connection refused` | Verificar que tienes internet (la BD está en Neon) |
| `Relation already exists` | No pasa nada, el `IF NOT EXISTS` lo maneja |
