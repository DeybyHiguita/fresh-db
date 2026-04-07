-- =============================================
-- Script: Ejecutar todas las tablas en orden
-- Uso: psql -h host -U user -d dbfresh -f init.sql
-- =============================================

\echo '=== Fresh Database - Creando tablas ==='

\echo '  -> users'
\i tables/01_users.sql

\echo '  -> categories'
\i tables/02_categories.sql

\echo '  -> ingredients'
\i tables/03_ingredients.sql

\echo '  -> recipes'
\i tables/04_recipes.sql

\echo '  -> recipe_ingredients'
\i tables/05_recipe_ingredients.sql

\echo '  -> products'
\i tables/07_products.sql

\echo '  -> ingredient_products'
\i tables/10_ingredient_products.sql

\echo '  -> whatsapp_contacts'
\i tables/40_whatsapp_contacts.sql

\echo '  -> whatsapp_messages'
\i tables/41_whatsapp_messages.sql

\echo ''
\echo '=== Insertando datos iniciales ==='

\echo '  -> categorías'
\i seeds/01_categories.sql

\echo ''
\echo '=== Base de datos lista ==='
