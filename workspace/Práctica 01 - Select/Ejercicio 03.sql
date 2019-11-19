/*
3) Guardar el siguiente query en un archivo de extensión .sql, para luego correrlo. Mostrar los
títulos con el formato de columna: Código Descripción y Tipo ordenarlo alfabéticamente
por descripción.
*/

SELECT cod_titulo AS "CODIGO", desc_titulo AS "DESCRIPCION", tipo_titulo AS "TITULO" FROM agencia_personal.titulos ORDER BY desc_titulo ASC;

/*
Para Correrlo (Run) externamente, File --> Run SQL Script... --> Seleccionar este Archivo .sql
Se puede especificar el Character Set (UTF-8) y el Schema a utilizar (agencia_personal)
Sin embargo, debería funcionar correectamente dejando en Default ambas cosas!
*/
 