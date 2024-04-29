use proyecto_ud;

#Crear usuarios 




#333-------


DELIMITER //

CREATE PROCEDURE personaInsertar(
    IN numeroDocumento INT,
    IN primerNombre VARCHAR(45),
    IN segundoNombre VARCHAR(45),
    IN primerApellido VARCHAR(45),
    IN segundoApellido VARCHAR(45),
    IN fechaDeNacimiento DATE,
    IN direccion VARCHAR(45),
    IN telefono VARCHAR(45),
    IN estadoCivil_idEstadoCivil INT,
    IN tipoDeSangre_idTipoDeSangre INT,
    IN genero_idGenero INT,
    IN paisDeNacimiento_idPais INT,
    IN tipoDeDocumento_idTipoDeDocumento INT,
    IN estrato_idEstrato INT,
    IN contrasena VARCHAR(45),
    IN correo VARCHAR(45),
    IN celular VARCHAR(45),
    IN fechaDeRegistro DATE,
    IN rol_idRol INT
)
BEGIN

    INSERT INTO persona (
        numeroDocumento,
        primerNombre,
        segundoNombre,
        primerApellido,
        segundoApellido,
        fechaDeNacimiento,
        direccion,
        telefono,
        estadoCivil_idEstadoCivil,
        tipoDeSangre_idTipoDeSangre,
        genero_idGenero,
        paisDeNacimiento_idPais,
        tipoDeDocumento_idTipoDeDocumento,
        estrato_idEstrato
    )
    VALUES (
        numeroDocumento,
        primerNombre,
        segundoNombre,
        primerApellido,
        segundoApellido,
        fechaDeNacimiento,
        direccion,
        telefono,
        estadoCivil_idEstadoCivil,
        tipoDeSangre_idTipoDeSangre,
        genero_idGenero,
        paisDeNacimiento_idPais,
        tipoDeDocumento_idTipoDeDocumento,
        estrato_idEstrato
    );
    
    CALL usuarioInsertar(contrasena, correo, celular, fechaDeRegistro, rol_idRol,numeroDocumento);
END//



DELIMITER ;




DELIMITER //

CREATE PROCEDURE usuarioInsertar(
    IN contrasena VARCHAR(45),
    IN correo VARCHAR(45),
    IN celular VARCHAR(45),
    IN fechaDeRegistro DATE,
    IN rol_idRol INT,
    IN persona_numeroDocumento INT
)
BEGIN
    INSERT INTO usuario (
        contrasena,
        correo,
        celular,
        fechaDeRegistro,
        rol_idRol,
        persona_numeroDocumento
    )
    VALUES (
        contrasena,
        correo,
        celular,
        fechaDeRegistro,
        rol_idRol,
        persona_numeroDocumento
    );
END//

DELIMITER ;
CALL personaInsertar(10000, "Daniel", "Duban", "Gonzales", "", '2001-07-07', "Calle 27#45-5", "", 4, 2, 1, 1, 1, 2, "Contra1", 'DubanG@gmail.com', '315265', CURDATE(), 2);


DELIMITER //

CREATE PROCEDURE crearUsuario(IN numeroDocumento INT, IN contrasena VARCHAR(45))
BEGIN
    SET @user = QUOTE(CONCAT(numeroDocumento, '@localhost'));
    SET @pass = QUOTE(contrasena);
    
    SET @createUserQuery = CONCAT('CREATE USER ', @user, ' IDENTIFIED BY ', @pass);
    PREPARE stmt FROM @createUserQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET @grantQuery = CONCAT('GRANT INSERT, SELECT, UPDATE ON proyecto_ud.persona TO ', @user);
    PREPARE stmt FROM @grantQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET @grantQuery = CONCAT('GRANT INSERT, SELECT, UPDATE, INSERT ON proyecto_ud.titulos TO ', @user);
    PREPARE stmt FROM @grantQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET @grantQuery = CONCAT('GRANT INSERT, SELECT, UPDATE, INSERT ON proyecto_ud.experiencialaboral TO ', @user);
    PREPARE stmt FROM @grantQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    FLUSH PRIVILEGES;
END//

DELIMITER ;


#persona, esperiencia laboral, titulos
	

#traer todas las experiencias laborales de un usuario y sumarlas 

DELIMITER //

CREATE PROCEDURE semanasAcumuladas(IN usuario INT)
BEGIN
    DECLARE suma FLOAT;
    SELECT sum(DATEDIFF(e.fechaDeRetiro, e.fechaDeIngreso) / 7) INTO suma
    FROM experienciaLaboral e
    WHERE e.persona_numeroDocumento = usuario;
	
    if suma!=0 then
		UPDATE experienciaLaboral e
		SET e.semanasCotizadas=suma
		WHERE e.persona_numeroDocumento = usuario;
    end if;
    SELECT suma;
    select * from experienciaLaboral;
END //

DELIMITER ;

call semanasAcumuladas(1011);
#hacer con un triger cada ves que se cree una experiencia

#modificar estado del trabajador 



DELIMITER //

CREATE PROCEDURE modificarEstadoTrabajador(IN usuario INT, IN opc INT)
BEGIN
    DECLARE existeContrato INT;
    
    SELECT COUNT(*) INTO existeContrato
    FROM persona p
	INNER JOIN contrato c ON c.persona_numeroDocumento = p.numeroDocumento
    WHERE c.persona_numeroDocumento = usuario;
    
    IF existeContrato > 0 THEN
        UPDATE contrato c
        SET c.estadoDelContrato_idEstadoDelContrato = opc
        WHERE c.persona_numeroDocumento = usuario;
    END IF;
END //

DELIMITER ;
call  modificarEstadoTrabajador(1010,3);

DROP PROCEDURE IF EXISTS modificarEstadoTrabajador;


DELIMITER //

CREATE PROCEDURE contarPersonasConEstrato(IN opc INT)
BEGIN
	SELECT p.numeroDocumento,p.primerApellido FROM persona p WHERE p.estrato_idEstrato = opc;
    SELECT COUNT(*) FROM persona p WHERE p.estrato_idEstrato = opc;
END //

DELIMITER ;

	call contarPersonasConEstrato(1);
    #---------------------------------***------------------------
   #agregar datos
  
    
    
    DELIMITER //
#agregarExpe
CREATE PROCEDURE agregarExperienciaLaboral(
    IN nombreEmpresa VARCHAR(45),
    IN telefonoEmpresa VARCHAR(45),
    IN cargo VARCHAR(45),
    IN fechaDeIngreso DATE,
    IN fechaDeRetiro DATE,
    IN semanasCotizadas FLOAT,
    IN sector_idSector INT,
    IN persona_numeroDocumento INT
)
BEGIN
    INSERT INTO experienciaLaboral (
        nombreEmpresa,
        telefonoEmpresa,
        cargo,
        fechaDeIngreso,
        fechaDeRetiro,
        semanasCotizadas,
        sector_idSector,
        persona_numeroDocumento
    )
    VALUES (
        nombreEmpresa,
        telefonoEmpresa,
        cargo,
        fechaDeIngreso,
        fechaDeRetiro,
        semanasCotizadas,
        sector_idSector,
        persona_numeroDocumento
    );
END //

DELIMITER ;

    
    	call agregarExperienciaLaboral('CC.S.A.S','21202','ayudante de bodega','2005-01-01','2006-01-01',0,2,1010);
        
        
        
          
    DELIMITER //
#agregarNivelEducatico
CREATE PROCEDURE agregarNivelEducativo(
    IN nombreInstitucion VARCHAR(45),
    IN nivelDeEducacion_idNivelDeEducacion INT,
    IN nucleoConocimiento_idNucleoConocimiento int,
    IN estadoDelEstudio_idEstadoDelEstudio int,
    IN persona_numeroDocumento int
)
BEGIN
    INSERT INTO titulos(
        nombreInstitucion,
        nivelDeEducacion_idNivelDeEducacion,
        nucleoConocimiento_idNucleoConocimiento,
        estadoDelEstudio_idEstadoDelEstudio,
        persona_numeroDocumento
    )
    VALUES (
        nombreInstitucion,
        nivelDeEducacion_idNivelDeEducacion,
        nucleoConocimiento_idNucleoConocimiento,
        estadoDelEstudio_idEstadoDelEstudio,
        persona_numeroDocumento
    );
END //

DELIMITER ;

call agregarNivelEducativo('Politecnico N', 5, 7, 3 ,'1011');
DROP PROCEDURE IF EXISTS agregarNivelEducatico;

   #-----------------------------------------***---------------------------------- 
  
 #---------------------------------------***--------------------------------------   
     DELIMITER //
#actualizar Datos Personales
CREATE PROCEDURE actualisarDatosPDireccion(in numeroDocumento INT,IN direccion VARCHAR(45) )
BEGIN
	declare existeDocumento int;
    select count(p.numeroDocumento) INTO existeDocumento
    from persona p
    where p.numeroDocumento=numeroDocumento;
    if existeDocumento!=0 then
       UPDATE persona p
        SET p.direccion = direccion
        WHERE p.numeroDocumento = numeroDocumento;
    end if;
END //

DELIMITER ;
    

 
     DELIMITER //
#actualizar Datos Personales
CREATE PROCEDURE actualisarDatosPTelefono(in numeroDocumento INT,IN telefono VARCHAR(45)  )
BEGIN
	declare existeDocumento int;
    select count(p.numeroDocumento) INTO existeDocumento
    from persona p
    where p.numeroDocumento=numeroDocumento;
    if existeDocumento!=0 then
       UPDATE persona p
        SET p.telefono = telefono
        WHERE p.numeroDocumento = numeroDocumento;
    end if;
END //

DELIMITER ;
 
     DELIMITER //
#actualizar Datos Personales
CREATE PROCEDURE actualisarDatosPEstadoCivil(in numeroDocumento INT,IN estadoCivil_idEstadoCivil INT )
BEGIN
	declare existeDocumento int;
    select count(p.numeroDocumento) INTO existeDocumento
    from persona p
    where p.numeroDocumento=numeroDocumento;
    if existeDocumento!=0 then
       UPDATE persona p
        SET p.estadoCivil_idEstadoCivil = estadoCivil_idEstadoCivil
        WHERE p.numeroDocumento = numeroDocumento;
    end if;
END //

DELIMITER ;

       DELIMITER //
#actualizar Datos Personales
CREATE PROCEDURE actualisarDatosPEstrato(in numeroDocumento INT,IN estrato_idEstrato INT )
BEGIN
	declare existeDocumento int;
    select count(p.numeroDocumento) INTO existeDocumento
    from persona p
    where p.numeroDocumento=numeroDocumento;
    if existeDocumento!=0 then
       UPDATE persona p
        SET p.estrato_idEstrato = estrato_idEstrato
        WHERE p.numeroDocumento = numeroDocumento;
    end if;
END //

DELIMITER ;
  #---------------------------------------***-------------------------------------- 
	    call actualisarDatosPDireccion(1011,'Calle 99 #911');#varchar
         call actualisarDatosPTelefono('1010','7777');#varchar
          call actualisarDatosPEstadoCivil('1010','4');#int
           call actualisarDatosPEstrato('1010','5');#int
        
       DROP PROCEDURE IF EXISTS actualisarDatosPDireccion;
 
   #---------------------------------------***-------------------------------------- 

#actualizar Nivel De Educacion

#estadoDelEstudio

DELIMITER //

CREATE PROCEDURE actualizarTituloEstudio(IN numeroDocumento INT, IN idEstadoDelTitulo INT, IN nSeleccionado INT)
BEGIN
    DECLARE existeTitulo INT;
    DECLARE contador INT DEFAULT 0;
    DECLARE idTitulo INT;
    
    SELECT COUNT(*) INTO existeTitulo
    FROM Titulos t
    WHERE t.persona_numeroDocumento = numeroDocumento;
    
    IF existeTitulo != 0 THEN
        SET contador = nSeleccionado - 1;
        SELECT t.idTitulos INTO idTitulo
        FROM (SELECT tt.idTitulos
              FROM titulos tt
              WHERE tt.persona_numeroDocumento = numeroDocumento
              LIMIT contador, 1) AS t;
        
        IF idTitulo IS NOT NULL THEN
            UPDATE Titulos
            SET estadoDelEstudio_idEstadoDelEstudio = idEstadoDelTitulo
            WHERE idTitulos = idTitulo;
        END IF;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE llamarAEstuConVerificacion(IN numeroDocumento INT, IN idEstadoDelTitulo INT, IN nSeleccionado INT)
BEGIN
    DECLARE condicion INT;
    
    SELECT COUNT(idTitulos) INTO condicion
    FROM titulos t
    WHERE persona_numeroDocumento = numeroDocumento
    GROUP BY persona_numeroDocumento;
    
    IF nSeleccionado <= condicion THEN
        CALL actualizarTituloEstudio(numeroDocumento, idEstadoDelTitulo, nSeleccionado);
    ELSE
        -- Genera una excepción personalizada
        SET @errorMsg = CONCAT('Error: El usuario con número de documento ', CAST(numeroDocumento AS CHAR), 
                               ' no tiene ', CAST(nSeleccionado AS CHAR), ' experiencias.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @errorMsg;
    END IF;
END //

DELIMITER ;







call llamarAEstuConVerificacion('1012','1',1);#int

DROP PROCEDURE IF EXISTS actualizarTituloEstudio;

 



#consultar hoja de vida

persona

DELIMITER //

CREATE PROCEDURE ObtenerExperienciaLaboral(IN numero INT)
BEGIN
    SELECT e.nombreEmpresa AS "Nombre De La Empresa", e.telefonoEmpresa AS "Telefono Empresa",
        s.nombreSector AS "Sector", e.cargo AS "Cargo Desempeñado",
        e.fechaDeIngreso AS "Fecha De Ingreso", e.fechaDeRetiro AS "Fecha De Retiro"
    FROM experiencialaboral e
    JOIN sector s ON e.sector_idSector = s.idSector
    WHERE e.persona_numeroDocumento = numero;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE obtenerTitulosPorNumeroDocumento(IN numero INT)
BEGIN
    SELECT t.nombreInstitucion AS "Nombre Institucion",
           n.tipoNivelDeEducacion AS "Nivel de Educacion",
           nc.nombreNucleoConocimiento AS "Nucleo Del Conocimiento",
           et.tipoEstadoDelTitulo AS "Estado DelTitulo"
    FROM titulos t
    JOIN nivelDeEducacion n ON n.idNivelDeEducacion = t.nivelDeEducacion_idNivelDeEducacion
    JOIN nucleoconocimiento nc ON nc.idNucleoConocimiento = t.nucleoConocimiento_idNucleoConocimiento
    JOIN estadodeltitulo et ON et.idEstadoDelTitulo = t.estadoDelEstudio_idEstadoDelEstudio
    WHERE t.persona_numeroDocumento = numero;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE obtenerInformacionPersona(IN numeroDocumento INT)
BEGIN
    SELECT p.numeroDocumento AS "#Documento",
        tp.nombreTipoDeDocumento AS "Tipo De Documento",
        p.primerNombre AS "PrimerNombre",
        p.segundoNombre AS "Segundo Nombre",
        p.primerApellido AS "Primer Apellido",
        p.segundoApellido AS "Segundo Apellido",
        p.fechaDeNacimiento AS "Fecha De Nacimiento",
        g.tipoDeGenero AS "Genero",
        p.direccion AS "Direccion",
        p.telefono AS "Telefono Fijo",
        ec.nombreEstadoCivil AS "Estado Civil",
        ts.nombreTipoDeSangre AS "Tipo De Sangre",
        pi.nombreNacion AS "Nombre Nacion",
        et.nivelEstrato AS "Estrato"
    FROM persona p
    JOIN estadocivil ec ON ec.idEstadoCivil = p.estadoCivil_idEstadoCivil
    JOIN tipodesangre ts ON ts.idTipoDeSangre = p.tipoDeSangre_idTipoDeSangre
    JOIN genero g ON g.idGenero = p.genero_idGenero
    JOIN pais pi ON pi.idPais = p.paisDeNacimiento_idPais
    JOIN tipodedocumento tp ON tp.idTipoDeDocumento = p.tipoDeDocumento_idTipoDeDocumento
    JOIN estrato et ON et.idEstrato = p.estrato_idEstrato
    WHERE p.numeroDocumento = numeroDocumento;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE VisualisarHojaDeVida(
in numero int
)
BEGIN
	CALL ObtenerExperienciaLaboral(numero);
	CALL obtenerTitulosPorNumeroDocumento(numero);
	CALL obtenerInformacionPersona(numero);
END//

DELIMITER ;


CALL VisualisarHojaDeVida(1010);


#Historial-----------------------

   
    drop table historial_usuarios;
    
    #cada vez que se realice algo
    
    CREATE VIEW Historial AS
	SELECT
		id,
		ultimaActualizacion,
		numeroDocumento,
		primerApellido,
		Rol,
		accionRealizada
		FROM historial_usuarios;
	select * from Historial;
    

/*
DELIMITER //

CREATE TRIGGER historial_Actualizacion
AFTER UPDATE, INSERT, DELETE ON persona FOR EACH ROW
BEGIN
    IF NEW.numeroDocumento IS NOT NULL THEN
        -- Actualización
        DECLARE rol VARCHAR(45);
        SELECT usuarios.rol INTO rol FROM usuarios WHERE usuarios.persona_numeroDocumento = NEW.numeroDocumento;
        INSERT INTO historial_usuarios (ultimaActualizacion, numeroDocumento, primerApellido, Rol, accionRealizada)
        VALUES (NOW(), NEW.numeroDocumento, NEW.primerApellido, rol, 'UPDATE');
    ELSEIF OLD.numeroDocumento IS NOT NULL THEN
        -- Eliminación
        DECLARE rol VARCHAR(45);
        SELECT usuarios.rol INTO rol FROM usuarios WHERE usuarios.persona_numeroDocumento = OLD.numeroDocumento;
        INSERT INTO historial_usuarios (ultimaActualizacion, numeroDocumento, primerApellido, Rol, accionRealizada)
        VALUES (NOW(), OLD.numeroDocumento, OLD.primerApellido, rol, 'DELETE');
    ELSE
        -- Inserción
        INSERT INTO historial_usuarios (ultimaActualizacion, numeroDocumento, primerApellido, accionRealizada)
        VALUES (NOW(), NEW.numeroDocumento, NEW.primerApellido, 'INSERT');
    END IF;
END //

DELIMITER ;
*/


#
DROP TRIGGER actualizar_ultimaActualizacion;


#-----------Desde aui Ejecutar-----
DELIMITER //

CREATE TRIGGER historial_Actualizacion_update
AFTER UPDATE ON persona FOR EACH ROW
BEGIN
    DECLARE rol VARCHAR(45);
    SELECT usuario.rol_idRol INTO rol FROM usuario WHERE usuario.persona_numeroDocumento = NEW.numeroDocumento;
    
    INSERT INTO historial_usuarios (ultimaActualizacion, numeroDocumento, primerApellido, Rol, accionRealizada,tabla)
    VALUES (NOW(), NEW.numeroDocumento, NEW.primerApellido, rol, 'UPDATE','persona');
END //

DELIMITER ;
DROP TRIGGER  historial_Actualizacion_update;


DELIMITER //

CREATE TRIGGER historial_Actualizacion_insert
AFTER INSERT ON persona FOR EACH ROW
BEGIN
    
    INSERT INTO historial_usuarios (ultimaActualizacion, numeroDocumento, primerApellido, accionRealizada,tabla)
    VALUES (NOW(), NEW.numeroDocumento, NEW.primerApellido, 'INSERT','persona');
END //

DELIMITER ;



DELIMITER //

CREATE TRIGGER historial_Actualizacion_delete
AFTER DELETE ON persona FOR EACH ROW
BEGIN
    DECLARE rol VARCHAR(45);
    SELECT u.rol INTO rol FROM usuario u
    JOIN persona p ON u.persona_numeroDocumento = p.numeroDocumento
    WHERE p.numeroDocumento = OLD.numeroDocumento;
    
    INSERT INTO historial_usuarios (ultimaActualizacion, numeroDocumento, primerApellido, Rol, accionRealizada,tabla)
    VALUES (NOW(), OLD.numeroDocumento, OLD.primerApellido, rol, 'DELETE','persona');
END //

DELIMITER ;

DROP TRIGGER historial_Actualizacion_insert;


#No ejecutar




