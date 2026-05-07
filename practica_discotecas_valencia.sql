-- ==========================================================
-- 1. PREPARACIÓN DE LA BASE DE DATOS
-- ==========================================================
DROP DATABASE IF EXISTS practica_discotecas_valencia;
CREATE DATABASE practica_discotecas_valencia;
USE practica_discotecas_valencia;

-- ==========================================================
-- 2. CREACIÓN DE TABLAS Y RESTRICCIONES
-- ==========================================================

-- Tabla 1: locales (Entidad Fuerte)
CREATE TABLE locales (
    id_local INT AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    zona ENUM('Puerto', 'Ciutat Arts', 'Ruzafa', 'Carmen', 'Periferia', 'Centro') NOT NULL,
    aforo_maximo INT NOT NULL,
    tiene_terraza BOOLEAN DEFAULT TRUE,
    
    CONSTRAINT pk_locales PRIMARY KEY (id_local),
    CONSTRAINT uq_nombre_local UNIQUE (nombre),
    CONSTRAINT ck_aforo_positivo CHECK (aforo_maximo > 50)
);

-- Tabla 2: djs (Entidad Fuerte)
CREATE TABLE djs (
    id_dj INT AUTO_INCREMENT,
    nombre_artistico VARCHAR(100) NOT NULL,
    estilo_principal VARCHAR(50) NOT NULL,
    pago_por_hora DECIMAL(10, 2) NOT NULL,
    usuario_instagram VARCHAR(100) NULL,
    
    CONSTRAINT pk_djs PRIMARY KEY (id_dj)
);

-- Tabla 3: sesiones (Relación 1:N con locales)
CREATE TABLE sesiones (
    id_sesion INT AUTO_INCREMENT,
    id_local INT NOT NULL,
    nombre_fiesta VARCHAR(100) NOT NULL,
    fecha_evento DATE NOT NULL,
    precio_entrada DECIMAL(5, 2) NOT NULL,
    
    CONSTRAINT pk_sesiones PRIMARY KEY (id_sesion),
    CONSTRAINT ck_precio_valido CHECK (precio_entrada >= 0),
    CONSTRAINT fk_sesiones_local FOREIGN KEY (id_local) 
        REFERENCES locales(id_local) ON DELETE CASCADE
);

-- Tabla 4: actuaciones (Tabla Intermedia N:M)
CREATE TABLE actuaciones (
    id_sesion INT,
    id_dj INT,
    hora_inicio TIME NOT NULL,
    
    CONSTRAINT pk_actuaciones PRIMARY KEY (id_sesion, id_dj),
    CONSTRAINT fk_actuaciones_sesion FOREIGN KEY (id_sesion) 
        REFERENCES sesiones(id_sesion) ON DELETE CASCADE,
    -- Usamos RESTRICT para no borrar a un DJ si tiene actuaciones programadas
    CONSTRAINT fk_actuaciones_dj FOREIGN KEY (id_dj) 
        REFERENCES djs(id_dj) ON DELETE RESTRICT
);

-- Tabla 5: resenas_locales (Relación Opcional 0:N con locales)
CREATE TABLE resenas_locales (
    id_resena INT AUTO_INCREMENT,
    id_local INT NOT NULL,
    puntuacion INT NOT NULL,
    comentario VARCHAR(255) NULL,
    
    CONSTRAINT pk_resenas PRIMARY KEY (id_resena),
    CONSTRAINT ck_puntuacion CHECK (puntuacion BETWEEN 1 AND 5),
    CONSTRAINT fk_resenas_local FOREIGN KEY (id_local) 
        REFERENCES locales(id_local) ON DELETE CASCADE
);

-- ==========================================================
-- 3. ÍNDICE MANUAL
-- ==========================================================
CREATE INDEX idx_fecha_fiesta ON sesiones(fecha_evento);

-- ==========================================================
-- 4. INSERCIÓN DE DATOS
-- ==========================================================

INSERT INTO locales (nombre, zona, aforo_maximo, tiene_terraza) VALUES 
('Mya', 'Ciutat Arts', 2500, TRUE),
('Akuarela Beach', 'Puerto', 3000, TRUE),
('Spook Factory', 'Periferia', 1500, TRUE),
('Play Club', 'Ruzafa', 400, FALSE),
('Committee', 'Centro', 800, DEFAULT);

INSERT INTO djs (nombre_artistico, estilo_principal, pago_por_hora, usuario_instagram) VALUES 
('Paco Pil', 'Remember', 120.50, '@pacopil_oficial'),
('Chimo Bayo', 'Ruta Destroy', 250.00, '@chimobayo'),
('Amelie Lens', 'Techno', 1500.00, '@amelie_lens'),
('DJ Nano', 'Comercial', 300.00, NULL),
('Wade', 'Tech House', 800.00, '@wade_music');

INSERT INTO sesiones (id_local, nombre_fiesta, fecha_evento, precio_entrada) VALUES 
(1, 'L Umbracle Terraza Opening', '2024-06-15', 20.00),
(2, 'Amanecer en el Puerto', '2024-07-01', 25.00),
(3, 'Homenaje a la Ruta', '2024-03-19', 15.00),
(3, 'Hu-Ha Night', '2024-03-20', 18.00),
(4, 'Underground Ruzafa', '2024-05-10', 12.00);

-- Relación N:M: Asignamos DJs a las sesiones (Line-Ups)
INSERT INTO actuaciones (id_sesion, id_dj, hora_inicio) VALUES 
(3, 1, '02:00:00'), -- Paco Pil en el Homenaje a la ruta
(3, 2, '04:00:00'), -- Chimo Bayo también en el Homenaje a la ruta (Line-up de 2 DJs)
(1, 4, '01:30:00'), -- DJ Nano en el Opening
(2, 5, '03:00:00'), -- Wade en el Amanecer
(5, 3, '02:30:00'); -- Amelie Lens en Ruzafa

-- Relación 0:N: Reseñas de los locales
INSERT INTO resenas_locales (id_local, puntuacion, comentario) VALUES 
(1, 5, 'El mejor ambiente de Valencia.'),
(1, 4, 'Mucha cola para entrar, pero buena música.'),
(3, 5, 'Sonido espectacular y puro techno.'),
(4, 3, NULL), -- Reseña sin comentario
(2, 4, 'La terraza es increíble en verano.');

-- ==========================================================
-- 5. BLOQUE DE PRUEBAS (Errores intencionados)
-- ==========================================================

/* PRUEBA 1: Error por FOREIGN KEY (INSERT)
Intento añadir una actuación para un DJ que no existe (id 99).
Mensaje esperado: Cannot add or update a child row: a foreign key constraint fails...
*/
-- INSERT INTO actuaciones (id_sesion, id_dj, hora_inicio) VALUES (1, 99, '01:00:00');

/* PRUEBA 2: Error por CHECK
Intento crear un local con un aforo menor a 50 personas.
Mensaje esperado: Check constraint 'ck_aforo_positivo' is violated.
*/
-- INSERT INTO locales (nombre, zona, aforo_maximo) VALUES ('Local Enano', 'Centro', 20);

/* PRUEBA 3: Demostración de DELETE y ON DELETE CASCADE/RESTRICT 
Si intento borrar a un DJ que tiene actuaciones programadas:
    DELETE FROM djs WHERE id_dj = 1; 
Saltará error por el ON DELETE RESTRICT (protegemos al DJ).

Sin embargo, si borro el local 'Mya' (id_local = 1):
*/
-- DELETE FROM locales WHERE id_local = 1;
/*
EXPLICACIÓN: Al borrar el local 1, MySQL automáticamente aplica ON DELETE CASCADE en cascada:
1. Borra las sesiones asociadas (Opening L'Umbracle).
2. Borra las actuaciones de los DJs en esas sesiones.
3. Borra las reseñas asociadas a ese local.
No quedan datos huérfanos.
*/
