-- =============================================
-- Tabla: user_sessions
-- Descripción: Control de conexiones activas e historial de sesiones de los usuarios
-- =============================================
CREATE TABLE IF NOT EXISTS user_sessions (
    id                  SERIAL PRIMARY KEY,
    
    -- Relación con el empleado/administrador
    user_id             INTEGER         NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    
    -- Identificador único de SignalR (WebSockets)
    connection_id       VARCHAR(255)    NOT NULL, 
    
    -- Tiempos de conexión
    connected_at        TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    disconnected_at     TIMESTAMPTZ     NULL, -- Se llena cuando cierran la pestaña o se cae el internet
    
    -- Métricas de la sesión
    total_idle_seconds  INTEGER         NOT NULL DEFAULT 0, -- Tiempo total sin mover el mouse/teclado
    last_known_location VARCHAR(255)    NULL DEFAULT 'Dashboard', -- Última pantalla que vio (Ej: '/pos', '/inventory')
    
    -- Auditoría estándar
    created_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

-- Índices clave para búsquedas en tiempo real
CREATE INDEX IF NOT EXISTS ix_user_sessions_user_id ON user_sessions (user_id);
-- Este índice es vital porque SignalR buscará la sesión por connection_id constantemente
CREATE INDEX IF NOT EXISTS ix_user_sessions_connection_id ON user_sessions (connection_id);