-- Agrega campo para registrar el efectivo dejado en el cajón para el próximo turno
ALTER TABLE cash_registers
  ADD COLUMN IF NOT EXISTS amount_left_in_register NUMERIC(12, 2) NOT NULL DEFAULT 0;
