-- =============================================
-- Tabla: user_actions
-- Descripción: Historial detallado de las acciones que ocurren dentro de una sesión
-- =============================================
CREATE TABLE IF NOT EXISTS user_actions (
    id                  SERIAL PRIMARY KEY,
    
    -- Se amarra a la sesión específica en la que ocurrió
    session_id          INTEGER         NOT NULL REFERENCES user_sessions(id) ON DELETE CASCADE,
    
    -- Clasificación de la acción
    action_type         VARCHAR(100)    NOT NULL, -- Ej: 'Navegación', 'Inactividad', 'Error Visual', 'Click'
    description         TEXT            NOT NULL, -- Ej: 'Usuario inactivo por 300 segundos', 'Navegó a Cajas'
    
    -- Solo necesitamos saber cuándo pasó (el updated_at no aplica aquí porque es un log histórico)
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índice para poder sacar reportes rápidos de qué hizo un usuario en una sesión
CREATE INDEX IF NOT EXISTS ix_user_actions_session_id ON user_actions (session_id);
-- Índice para ordenar cronológicamente las acciones rápidamente
CREATE INDEX IF NOT EXISTS ix_user_actions_created_at ON user_actions (created_at);