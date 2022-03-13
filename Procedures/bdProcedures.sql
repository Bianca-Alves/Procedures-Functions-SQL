----- Criação do banco de dados -----

CREATE DATABASE bdProcedures
USE bdProcedures

----- Criação das procedures -----

-- 1)
CREATE PROCEDURE somaValor(@a INT, @b INT, @c INT)
AS
BEGIN
	DECLARE @soma INT
	SET @soma = @a + @b
	IF @soma < @c
		BEGIN
			PRINT 'Valor A: ' + CAST(@a AS VARCHAR)
			PRINT 'Valor B: ' + CAST(@b AS VARCHAR)
			PRINT 'Valor C: ' + CAST(@c AS VARCHAR)
			PRINT ''
			PRINT 'A soma de A e B é menor que o valor C.'
		END
	ELSE
		BEGIN
			PRINT 'Valor A: ' + CAST(@a AS VARCHAR)
			PRINT 'Valor B: ' + CAST(@b AS VARCHAR)
			PRINT 'Valor C: ' + CAST(@c AS VARCHAR)
			PRINT ''
			PRINT 'A soma de A e B é maior que o valor C.'
		END
END

EXECUTE somaValor 1, 2, 5


-- 2)
CREATE PROCEDURE dadosPessoais(@nome VARCHAR(50), @sexo CHAR(01), @ec VARCHAR(20))
AS
BEGIN
	IF @sexo = 'F' AND @ec = 'Casada'
		PRINT @nome + ', digite o tempo de casada (anos).'
	ELSE
		PRINT @nome + ', seus dados pessoais foram enviados com sucesso.'
END

EXECUTE dadosPessoais 'Bianca', 'F', 'Casada'


-- 3)
CREATE PROCEDURE parOuImpar(@number INT)
AS
BEGIN
	IF @number % 2 = 0
		PRINT 'O número digitado é par.'
	ELSE
		PRINT 'O número digitado é ímpar.'
END

EXECUTE parOuImpar 3


-- 4)
CREATE PROCEDURE operacoes(@a INT, @b INT)
AS
BEGIN
	DECLARE @c INT
	IF @a = @b
		BEGIN
			SET @c = @a + @b
			PRINT 'Valor A: ' + CAST(@a AS VARCHAR)
			PRINT 'Valor B: ' + CAST(@b AS VARCHAR)
			PRINT ''
			PRINT 'Resultado: ' + CAST(@c AS VARCHAR)
		END
	ELSE
		BEGIN
			SET @c = @a * @b
			PRINT 'Valor A: ' + CAST(@a AS VARCHAR)
			PRINT 'Valor B: ' + CAST(@b AS VARCHAR)
			PRINT ''
			PRINT 'Resultado: ' + CAST(@c AS VARCHAR)
		END
END

EXECUTE operacoes 6, 4


-- 5)
CREATE PROCEDURE positivoNegativo(@number INT)
AS
BEGIN
	DECLARE @result INT
	IF @number > 0
		BEGIN
			SET @result = @number * 2
			PRINT 'O número digitado é positivo, o dobro dele é ' + CAST(@result AS VARCHAR) + '.'
		END
	ELSE
		BEGIN
			SET @result = @number * 3
			PRINT 'O número digitado é negativo, o triplo dele é ' + CAST(@result AS VARCHAR) + '.'
		END
END

EXECUTE positivoNegativo 5


-- 6)
CREATE PROCEDURE trueOrFalse(@valor1 BIT, @valor2 BIT)
AS
BEGIN
	IF @valor1 = 0
		PRINT 'O valor 1 é falso.'
	ELSE
		PRINT 'O valor 1 é verdadeiro.'
	IF @valor2 = 0
		PRINT 'O valor 2 é falso.'
	ELSE
		PRINT 'O valor 2 é verdadeiro.'
END

EXECUTE trueOrFalse 0, 1


-- 7)
CREATE PROCEDURE parImparSoma(@number INT)
AS
BEGIN
	IF @number % 2 = 0
		BEGIN
			PRINT 'O número digitado é par.'
			SET @number = @number + 5
			PRINT 'Resultado: ' + CAST(@number AS VARCHAR)
		END
	ELSE
		BEGIN
			PRINT 'O número digitado é ímpar.'
			SET @number = @number + 8
			PRINT 'Resultado: ' + CAST(@number AS VARCHAR)
		END
END

EXECUTE parImparSoma 2


-- 8)
CREATE PROCEDURE ordemDesc(@valor1 INT, @valor2 INT, @valor3 INT)
AS
BEGIN
	CREATE TABLE ordem (valores INT NOT NULL);

	INSERT ordem VALUES (@valor1), (@valor2), (@valor3)

	SELECT valores AS 'Valores digitados em ordem decrescente' FROM ordem ORDER BY valores DESC

	DROP TABLE ordem
END

EXECUTE ordemDesc 5, 9, 2


-- 9)
CREATE PROCEDURE pesoIdeal(@h FLOAT, @sexo CHAR(01))
AS
BEGIN
	DECLARE @peso FLOAT
	IF @sexo = 'M'
		BEGIN
			SET @peso = (72.7 * @h) - 58
			PRINT 'Altura: ' + CAST(@h AS VARCHAR)
			PRINT 'Sexo: ' + @sexo
			PRINT ''
			PRINT 'Seu peso ideal é: ' + CAST(CAST(@peso AS NUMERIC(10,2)) AS VARCHAR) + ' quilos.'
		END
	ELSE
		IF @sexo = 'F'
			BEGIN
				SET @peso = (62.1 * @h) - 44.7
				PRINT 'Altura: ' + CAST(@h AS VARCHAR)
				PRINT 'Sexo: ' + @sexo
				PRINT ''
				PRINT 'Seu peso ideal é: ' + CAST(CAST(@peso AS NUMERIC(10,2)) AS VARCHAR) + ' quilos.'
			END
END

EXECUTE pesoIdeal 1.62, 'F'


-- 10)
CREATE PROCEDURE calcularImc(@peso FLOAT, @altura FLOAT)
AS
BEGIN
	DECLARE @imc FLOAT
	SET @imc = @peso/(@altura*@altura)
	IF @imc <= 18.5
		BEGIN
			PRINT 'Você está abaixo do peso.'
			PRINT 'Seu IMC é: ' + CAST(CAST(@imc AS NUMERIC(10,1)) AS VARCHAR)
		END
	ELSE 
		IF @imc >= 18.6 AND @imc <= 24.9
			BEGIN
				PRINT 'Você está no peso normal.'
				PRINT 'Seu IMC é: ' + CAST(CAST(@imc AS NUMERIC(10,1)) AS VARCHAR)
			END
		ELSE 
			IF @imc >= 25.0 AND @imc <= 30.0
				BEGIN
					PRINT 'Você está acima do peso.'
					PRINT 'Seu IMC é: ' + CAST(CAST(@imc AS NUMERIC(10,1)) AS VARCHAR)
				END
			ELSE 
				IF @imc > 30.0
					BEGIN
						PRINT 'Você está obeso.'
						PRINT 'Seu IMC é: ' + CAST(CAST(@imc AS NUMERIC(10,1)) AS VARCHAR)
					END
END

EXECUTE calcularImc 50, 1.62


-- 11)
CREATE PROCEDURE calcularPreco(@precoNormal FLOAT, @escolhaPag CHAR(01))
AS
BEGIN
	IF @escolhaPag = 'A'
		BEGIN
			SET @precoNormal = @precoNormal - (@precoNormal/10)
			PRINT 'Escolha de pagamento: À vista em dinheiro ou cheque, recebe 10% de desconto.'
			PRINT 'Valor final: R$ ' + CAST(CAST(@precoNormal AS NUMERIC(10,2)) AS VARCHAR)
		END
	ELSE
		IF @escolhaPag = 'B'
			BEGIN
				SET @precoNormal = @precoNormal - (@precoNormal/15)
				PRINT 'À vista no cartão de crédito, recebe 15% de desconto.'
				PRINT 'Valor final: R$ ' + CAST(CAST(@precoNormal AS NUMERIC(10,2)) AS VARCHAR)
			END
		ELSE
			IF @escolhaPag = 'C'
				BEGIN
					PRINT 'Em duas vezes, preço normal de etiqueta sem juros.'
					PRINT 'Valor final: R$ ' + CAST(CAST(@precoNormal AS NUMERIC(10,2)) AS VARCHAR)
				END
			ELSE
				IF @escolhaPag = 'D'
				BEGIN
					SET @precoNormal = @precoNormal + (@precoNormal/10)
					PRINT 'Em duas vezes, preço normal de etiqueta mais juros de 10%.'
					PRINT 'Valor final: R$ ' + CAST(CAST(@precoNormal AS NUMERIC(10,2)) AS VARCHAR)
				END
END

EXECUTE calcularPreco 50.25, 'B'


-- 12)
CREATE PROCEDURE notaAluno(@RM INT, @nota1 FLOAT, @nota2 FLOAT, @nota3 FLOAT)
AS
BEGIN
	DECLARE @media FLOAT
	SET @media = (@nota1 * 1 + @nota2 * 2 + @nota3 * 3)/6
	IF @media >= 8.5
		BEGIN
			PRINT 'RM do Aluno: ' + CAST(@RM AS VARCHAR)
			PRINT 'Notas: ' + CAST(@nota1 AS VARCHAR) + ' | ' + CAST(@nota2 AS VARCHAR) + ' | ' + CAST(@nota3 AS VARCHAR)
			PRINT 'Média aritmética: ' + CAST(CAST(@media AS NUMERIC(10,1)) AS VARCHAR)
			PRINT 'Desempenho: A'
			PRINT 'Situação: APROVADO'
		END
	ELSE
		IF @media >= 7.0
			BEGIN
				PRINT 'RM do Aluno: ' + CAST(@RM AS VARCHAR)
				PRINT 'Notas: ' + CAST(@nota1 AS VARCHAR) + ' | ' + CAST(@nota2 AS VARCHAR) + ' | ' + CAST(@nota3 AS VARCHAR)
				PRINT 'Média aritmética: ' + CAST(CAST(@media AS NUMERIC(10,1)) AS VARCHAR)
				PRINT 'Desempenho: B'
				PRINT 'Situação: APROVADO'
			END
		ELSE
			IF @media >= 6.0
				BEGIN
					PRINT 'RM do Aluno: ' + CAST(@RM AS VARCHAR)
					PRINT 'Notas: ' + CAST(@nota1 AS VARCHAR) + ' | ' + CAST(@nota2 AS VARCHAR) + ' | ' + CAST(@nota3 AS VARCHAR)
					PRINT 'Média aritmética: ' + CAST(CAST(@media AS NUMERIC(10,1)) AS VARCHAR)
					PRINT 'Desempenho: C'
					PRINT 'Situação: APROVADO'
				END
			ELSE
				IF @media >= 4.0
					BEGIN
						PRINT 'RM do Aluno: ' + CAST(@RM AS VARCHAR)
						PRINT 'Notas: ' + CAST(@nota1 AS VARCHAR) + ' | ' + CAST(@nota2 AS VARCHAR) + ' | ' + CAST(@nota3 AS VARCHAR)
						PRINT 'Média aritmética: ' + CAST(CAST(@media AS NUMERIC(10,1)) AS VARCHAR)
						PRINT 'Desempenho: D'
						PRINT 'Situação: REPROVADO'
					END
				ELSE
					IF @media < 4.0
						BEGIN
							PRINT 'RM do Aluno: ' + CAST(@RM AS VARCHAR)
							PRINT 'Notas: ' + CAST(@nota1 AS VARCHAR) + ' | ' + CAST(@nota2 AS VARCHAR) + ' | ' + CAST(@nota3 AS VARCHAR)
							PRINT 'Média aritmética: ' + CAST(CAST(@media AS NUMERIC(10,1)) AS VARCHAR)
							PRINT 'Desempenho: E'
							PRINT 'Situação: REPROVADO'
						END
END

EXECUTE notaAluno 20284, 10, 9.5, 8


-- Exercício extra

CREATE PROCEDURE tabuada(@mult VARCHAR)
AS
BEGIN
	DECLARE @contador INT
	SET @contador = 1
	WHILE (@contador <= 10)
		BEGIN
			PRINT CAST(@mult AS VARCHAR) + ' x ' + CAST(@contador AS VARCHAR) + ' = ' + CAST((@mult * @contador) AS VARCHAR)
			SET @contador = @contador + 1
		END
END

EXECUTE tabuada 5