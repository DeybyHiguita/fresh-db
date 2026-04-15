-- Agrega columna `difference` a cash_registers
-- Almacena la diferencia firmada al momento del cierre:
--   difference = total_reportado_neto - total_esperado_neto
-- Un valor negativo indica que hay menos dinero del esperado.
-- NULL si la caja aún está abierta.

ALTER TABLE cash_registers
  ADD COLUMN IF NOT EXISTS difference NUMERIC(12, 2) NULL;

-- Actualizar registros existentes con una aproximación:
-- (reported_cash + reported_transfer) - (system_cash + system_transfer)
-- Nota: esto no descuenta gastos/créditos que se procesaron al cierre,
-- pero es la mejor estimación disponible sin historia de esos valores.
UPDATE cash_registers
SET difference = (COALESCE(reported_cash, 0) + COALESCE(reported_transfer, 0))
              - (COALESCE(system_cash,    0) + COALESCE(system_transfer,   0))
WHERE status IN ('Cerrada', 'Descuadrada');
