----- Criação do banco de dados -----

CREATE DATABASE bdFunctions
USE bdFunctions

----- Criação das functions -----

CREATE FUNCTION multiplicacao(@valor FLOAT) 
RETURNS INT
AS
BEGIN
	SET @valor = @valor * 5
	RETURN @valor
END

DECLARE @number INT
SET @number = DBO.multiplicacao (5)
SELECT @number AS 'Resultado'

-------------------------------------

CREATE FUNCTION tipoConta(@tipoConta INT)
RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @conta VARCHAR(20)
	SET @conta = CASE @tipoConta
		WHEN 1 THEN 'CC'
		WHEN 2 THEN 'CP'
		WHEN 3 THEN 'CS'
		WHEN 4 THEN 'CE'
		ELSE 'Informe uma conta válida.'
	END
	RETURN @conta
END

DECLARE @conta VARCHAR(20)
SET @conta = DBO.tipoConta (2)
SELECT @conta AS 'Tipo de Conta'