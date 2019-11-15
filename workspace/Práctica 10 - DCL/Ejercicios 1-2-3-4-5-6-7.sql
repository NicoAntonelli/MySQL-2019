/*
En cada caso otorgar o revocar los permisos que indica y realizar acciones (a través de SQL o de
los asistentes de tabla) para corroborar los cambios realizados en los permisos.

NOTA: No es necesario FLUSH PRIVILEGES para GRANT, REVOKE, SET PASSWORD, RENAME USER...
*/

# 1) Crear el usuario 'usuario' con contraseña 'entre'.

CREATE USER 'usuario'@'localhost' IDENTIFIED BY 'entre';

############

# 2) Cambiar la contraseña de usuario a 'entrar'.

SET PASSWORD FOR 'usuario'@'localhost' = 'entrar';
# PASSWORD('entrar') No Funciona

############

# 3) Darle permisos a usuario para realizar SELECT de todas las tablas de AGENCIA_PERSONAL.

GRANT SELECT ON agencia_personal.* to 'usuario'@'localhost';

############

# 4) Darle permisos al usuario para realizar (INSERT, UPDATE y DELETE) los datos de la tabla PERSONAS.

GRANT INSERT ON agencia_personal.personas to 'usuario'@'localhost';
GRANT UPDATE ON agencia_personal.personas to 'usuario'@'localhost';
GRANT DELETE ON agencia_personal.personas to 'usuario'@'localhost';

############

# 5) Quitarle todos los permisos a usuario.

# REVOKE ALL PRIVILEGES ON agencia_personal.* FROM 'usuario'@'localhost'; --> No funciona en MySQL 8
# Le Revoco todos los privilegios de todas las DB y el permiso de Grant Option a otros Users
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'usuario'@'localhost';

# O sino, uno por uno:
REVOKE SELECT ON agencia_personal.* FROM 'usuario'@'localhost';
REVOKE INSERT ON agencia_personal.* FROM 'usuario'@'localhost';
REVOKE UPDATE ON agencia_personal.* FROM 'usuario'@'localhost';
REVOKE DELETE ON agencia_personal.* FROM 'usuario'@'localhost';

############

# 6) Darle permisos a usuario de realizar SELECT, INSERT y UPDATE sobre la vista vw_contratos.
/*
Analizar: La vista vw_contratos NO posee las columnas de sueldo y comisión. De esta forma se permite que distintos
usuarios puedan acceder a los datos específicos que pueden y evitar que accedan a datos que no deberían. La vista por
ser simple permite realizar inserciones, actualizaciones y eliminaciones. De esta forma para que un grupo de usuario no
acceda a determinadas columnas y a otras si, el sistema de vistas permite un forma sencilla de gestionar los permisos en
comparación con dar permisos por columna y en caso de tener que cambiar las columnas que pueden ver y modificar sólo debe
modificarse la vista y todos los usuarios que tienen acceso a esa vista tendrán automáticamente el cambio en las columnas.
*/

GRANT UPDATE ON agencia_personal.vw_contratos to 'usuario'@'localhost';
GRANT INSERT ON agencia_personal.vw_contratos to 'usuario'@'localhost';
GRANT DELETE ON agencia_personal.vw_contratos to 'usuario'@'localhost';
# Sin embargo, vw_contratos no existe

############

# 7) Quitarle a usuario todos los permisos.

# Ya fue resuelto en 5) este ejercicio!!
