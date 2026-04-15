-- Agrega columna `difference` a cash_registers
-- Almacena la diferencia firmada al momento del cierre:
--   difference = total_reportado_neto - total_esperado_neto
-- Un valor negativo indica que hay menos dinero del esperado.
-- NULL si la caja aún está abierta.

ALTER TABLE cash_registers
  ADD COLUMN IF NOT EXISTS difference NUMERIC(12, 2) NULL;

-- Almacena los IDs de gastos que el cajero incluyó al cerrar (JSON array de enteros).
-- NULL = cierre antiguo sin registro de selección.
ALTER TABLE cash_registers
  ADD COLUMN IF NOT EXISTS selected_expense_ids TEXT NULL;

-- Observación registrada al momento de abrir la caja (conteo inicial de efectivo).
ALTER TABLE cash_registers
  ADD COLUMN IF NOT EXISTS opening_observations TEXT NULL;

-- Actualizar registros existentes con una aproximación para `difference`:
-- (reported_cash + reported_transfer) - (system_cash + system_transfer)
-- Nota: esto no descuenta gastos/créditos que se procesaron al cierre,
-- pero es la mejor estimación disponible sin historia de esos valores.
UPDATE cash_registers
SET difference = (COALESCE(reported_cash, 0) + COALESCE(reported_transfer, 0))
              - (COALESCE(system_cash,    0) + COALESCE(system_transfer,   0))
WHERE status IN ('Cerrada', 'Descuadrada')
  AND difference IS NULL;
-- selected_expense_ids y opening_observations quedan NULL en registros antiguos (comportamiento esperado).
