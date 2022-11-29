USE [ZASYLOGIC]
GO
/****** Object:  StoredProcedure [dbo].[sp_motivo_sel]    Script Date: 29/11/2022 10:30:44 ******/
DROP PROCEDURE [dbo].[sp_motivo_sel]
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_sel]    Script Date: 29/11/2022 10:30:44 ******/
DROP PROCEDURE [dbo].[sp_cliente_sel]
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_ins]    Script Date: 29/11/2022 10:30:44 ******/
DROP PROCEDURE [dbo].[sp_cliente_ins]
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_get]    Script Date: 29/11/2022 10:30:44 ******/
DROP PROCEDURE [dbo].[sp_cliente_get]
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_edi]    Script Date: 29/11/2022 10:30:44 ******/
DROP PROCEDURE [dbo].[sp_cliente_edi]
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_del]    Script Date: 29/11/2022 10:30:44 ******/
DROP PROCEDURE [dbo].[sp_cliente_del]
GO
/****** Object:  Table [dbo].[Tmotivo]    Script Date: 29/11/2022 10:30:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tmotivo]') AND type in (N'U'))
DROP TABLE [dbo].[Tmotivo]
GO
/****** Object:  Table [dbo].[TatencionCliente]    Script Date: 29/11/2022 10:30:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TatencionCliente]') AND type in (N'U'))
DROP TABLE [dbo].[TatencionCliente]
GO
/****** Object:  Table [dbo].[TatencionCliente]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TatencionCliente](
	[idAtencionCliente] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](100) NULL,
	[apellidos] [varchar](100) NULL,
	[celular] [varchar](9) NULL,
	[email] [varchar](100) NULL,
	[sexo] [int] NULL,
	[idMotivo] [int] NULL,
	[fecha] [date] NULL,
 CONSTRAINT [PK_contacto] PRIMARY KEY CLUSTERED 
(
	[idAtencionCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tmotivo]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tmotivo](
	[idMotivo] [int] IDENTITY(1,1) NOT NULL,
	[descMotivo] [varchar](100) NULL,
 CONSTRAINT [PK_Tmotivo] PRIMARY KEY CLUSTERED 
(
	[idMotivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TatencionCliente] ON 
GO
INSERT [dbo].[TatencionCliente] ([idAtencionCliente], [nombres], [apellidos], [celular], [email], [sexo], [idMotivo], [fecha]) VALUES (1, N'Juan', N'Salazar', N'993943554', N'juan.salazar@hotmail.com', 1, 1, CAST(N'2022-11-29' AS Date))
GO
INSERT [dbo].[TatencionCliente] ([idAtencionCliente], [nombres], [apellidos], [celular], [email], [sexo], [idMotivo], [fecha]) VALUES (3, N'José', N'Castro', N'993943557', N'jose.castro@hotmail.com', 1, 1, CAST(N'2022-11-29' AS Date))
GO
SET IDENTITY_INSERT [dbo].[TatencionCliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Tmotivo] ON 
GO
INSERT [dbo].[Tmotivo] ([idMotivo], [descMotivo]) VALUES (1, N'Incidencia')
GO
INSERT [dbo].[Tmotivo] ([idMotivo], [descMotivo]) VALUES (2, N'Queja')
GO
INSERT [dbo].[Tmotivo] ([idMotivo], [descMotivo]) VALUES (3, N'Reclamación')
GO
INSERT [dbo].[Tmotivo] ([idMotivo], [descMotivo]) VALUES (4, N'Sugerencia')
GO
SET IDENTITY_INSERT [dbo].[Tmotivo] OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_del]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cliente_del] (
	@idAtencionCliente INT
)
AS
BEGIN
	DELETE FROM TatencionCliente
	WHERE idAtencionCliente = @idAtencionCliente
END
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_edi]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cliente_edi] (
	@idAtencionCliente INT,
	@nombres			VARCHAR(100),
	@apellidos			VARCHAR(100),
	@celular			VARCHAR(9),
	@email				VARCHAR(100),
	@sexo				INT,
	@idMotivo			INT
)
AS
BEGIN
	UPDATE TatencionCliente
	SET
		nombres		= @nombres, 
		apellidos	= @apellidos, 
		celular		= @celular, 
		email		= @email, 
		sexo		= @sexo, 
		idMotivo	= @idMotivo
	WHERE idAtencionCliente = @idAtencionCliente
END
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_get]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cliente_get] (
	@idAtencionCliente INT
)
AS
BEGIN
	SELECT 
		idAtencionCliente, nombres, apellidos, celular, email,
		sexo, CASE WHEN sexo = 1 THEN 'Hombre' ELSE 'Mujer' END descSexo,
		TatencionCliente.idMotivo, Tmotivo.descMotivo descMotivo, CONVERT(VARCHAR, fecha, 103) fecha
	FROM TatencionCliente
	INNER JOIN Tmotivo ON TatencionCliente.idMotivo = Tmotivo.idMotivo
	WHERE idAtencionCliente = @idAtencionCliente
END
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_ins]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cliente_ins] (
	@nombres	VARCHAR(100),
	@apellidos	VARCHAR(100),
	@celular	VARCHAR(9),
	@email		VARCHAR(100),
	@sexo		INT,
	@idMotivo	INT
)
AS
BEGIN
	DECLARE @rpt AS INT = 0
	IF NOT EXISTS(SELECT * FROM TatencionCliente WHERE celular = @celular AND CONVERT(VARCHAR, fecha, 103) = CONVERT(VARCHAR, GETDATE(), 103))
		BEGIN
			SET @rpt = 1;
			INSERT INTO TatencionCliente (nombres, apellidos, celular, email, sexo, idMotivo, fecha)
			VALUES (@nombres, @apellidos, @celular, @email, @sexo, @idMotivo, GETDATE());
		END
	ELSE
		SET @rpt = 0;
	
	RETURN @rpt;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_cliente_sel]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_cliente_sel]
	@fecha VARCHAR(10)
AS
BEGIN
	SELECT 
		idAtencionCliente, nombres, apellidos, celular, email,
		sexo, CASE WHEN sexo = 1 THEN 'Hombre' ELSE 'Mujer' END descSexo,
		TatencionCliente.idMotivo, Tmotivo.descMotivo descMotivo, CONVERT(VARCHAR, fecha, 103) fecha
	FROM TatencionCliente
	INNER JOIN Tmotivo ON TatencionCliente.idMotivo = Tmotivo.idMotivo
	WHERE (LEN(@fecha) > 0 AND CONVERT(VARCHAR, fecha, 103) = CONVERT(VARCHAR, @fecha, 103)) OR 
	(LEN(@fecha) = 0 AND CONVERT(VARCHAR, fecha, 103) > CONVERT(VARCHAR, @fecha, 103))
END
GO
/****** Object:  StoredProcedure [dbo].[sp_motivo_sel]    Script Date: 29/11/2022 10:30:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_motivo_sel]
AS
BEGIN
	SELECT idMotivo, descMotivo FROM Tmotivo
END
GO
