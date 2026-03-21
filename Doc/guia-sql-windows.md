# Fresh - Guia SQL para Windows

## Requisitos

- PowerShell
- VS Code
- Cliente `psql` instalado

Instalar `psql` — elige una de estas opciones:

**Opcion A (recomendada): Instalador oficial de PostgreSQL**

1. Entra a: https://www.postgresql.org/download/windows/
2. Descarga el instalador de EDB para PostgreSQL 16 o superior.
3. Durante la instalacion, marca **Command Line Tools** (incluye `psql`).
4. Finaliza y cierra el instalador.

**Opcion B: Chocolatey** (si ya tienes `choco` instalado)

```powershell
choco install postgresql --params '/Password:sa'
```

**Opcion C: winget** (IDs correctos por version)

> **Nota:** winget descarga y abre un instalador grafico de EDB. Debes completarlo manualmente (ver Opcion A para los pasos).

```powershell
# PostgreSQL 17 (recomendado)
winget install --id PostgreSQL.PostgreSQL.17 --source winget

# PostgreSQL 16
winget install --id PostgreSQL.PostgreSQL.16 --source winget
```

---

Despues de instalar, cierra y abre PowerShell nuevamente.

Verificar instalacion: 

```powershell
psql --version
```

> Si sigue sin reconocerse, agrega la ruta de PostgreSQL al PATH:
> `C:\Program Files\PostgreSQL\16\bin`
> (Menu Inicio → "Variables de entorno" → Path → Nuevo → pega la ruta)

## Ejecutar scripts SQL

1. Abre PowerShell.
2. Ve a la carpeta SQL del proyecto:

```powershell
cd C:\U\fresh-app\Sql
```

3. Define la clave y ejecuta.

Ejecutar todo:

```powershell
$env:DB_PASSWORD="tu_password"
.\run.ps1
```

Ejecutar un script especifico:

```powershell
$env:DB_PASSWORD="tu_password"
.\run.ps1 tables/01_users.sql
```

## Errores comunes

- `psql: command not found`: cierra y abre PowerShell despues de instalar PostgreSQL.
- `No se pueden cargar scripts`: ejecuta `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`.
- `Error: Falta la variable DB_PASSWORD`: define `$env:DB_PASSWORD` antes de correr el script.
