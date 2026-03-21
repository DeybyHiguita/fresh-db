-- =============================================
-- Vista: vw_daily_worked_hours
-- Descripción: Calcula las horas netas trabajadas (Jornada total - Descansos)
-- =============================================
CREATE OR REPLACE VIEW vw_daily_worked_hours AS
SELECT 
    ws.id AS shift_id,
    ws.user_id,
    u.name AS user_name,
    ws.shift_date,
    ws.start_time AS shift_start,
    ws.end_time AS shift_end,
    -- Calcula las horas brutas de la jornada (si end_time es null, usa la hora actual)
    EXTRACT(EPOCH FROM (COALESCE(ws.end_time, NOW()) - ws.start_time)) / 3600 AS gross_hours,
    
    -- Suma las horas de todos los descansos de esa jornada
    COALESCE((
        SELECT SUM(EXTRACT(EPOCH FROM (COALESCE(bt.end_time, NOW()) - bt.start_time)) / 3600)
        FROM break_times bt
        WHERE bt.shift_id = ws.id
    ), 0) AS total_break_hours,

    -- Horas netas: Horas brutas menos horas de descanso
    (EXTRACT(EPOCH FROM (COALESCE(ws.end_time, NOW()) - ws.start_time)) / 3600) - 
    COALESCE((
        SELECT SUM(EXTRACT(EPOCH FROM (COALESCE(bt.end_time, NOW()) - bt.start_time)) / 3600)
        FROM break_times bt
        WHERE bt.shift_id = ws.id
    ), 0) AS net_worked_hours

FROM 
    work_shifts ws
JOIN 
    users u ON ws.user_id = u.id;