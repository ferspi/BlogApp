USE [BlogsApp]
GO
/****** Object:  Table [dbo].[ArticleOffensiveWord]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArticleOffensiveWord](
	[OffensiveWordsId] [int] NOT NULL,
	[articlesContainingWordId] [int] NOT NULL,
 CONSTRAINT [PK_ArticleOffensiveWord] PRIMARY KEY CLUSTERED 
(
	[OffensiveWordsId] ASC,
	[articlesContainingWordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Articles]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Private] [bit] NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateDeleted] [datetime2](7) NULL,
	[Image] [nvarchar](max) NULL,
	[Template] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[State] [int] NOT NULL,
	[HadOffensiveWords] [bit] NOT NULL,
 CONSTRAINT [PK_Articles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CommentOffensiveWord]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentOffensiveWord](
	[OffensiveWordsId] [int] NOT NULL,
	[commentsContainingWordId] [int] NOT NULL,
 CONSTRAINT [PK_CommentOffensiveWord] PRIMARY KEY CLUSTERED 
(
	[OffensiveWordsId] ASC,
	[commentsContainingWordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[CommentId] [int] NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
	[DateDeleted] [datetime2](7) NULL,
	[ArticleId] [int] NOT NULL,
	[State] [int] NOT NULL,
	[isSubComment] [bit] NOT NULL,
	[HadOffensiveWords] [bit] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogEntries]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogEntries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ActionType] [nvarchar](max) NOT NULL,
	[SearchQuery] [nvarchar](max) NULL,
	[Timestamp] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_LogEntries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OffensiveWords]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OffensiveWords](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Word] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_OffensiveWords] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Token] [uniqueidentifier] NOT NULL,
	[DateTimeLogin] [datetime2](7) NOT NULL,
	[DateTimeLogout] [datetime2](7) NULL,
 CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 15/6/2023 3:29:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Blogger] [bit] NOT NULL,
	[Admin] [bit] NOT NULL,
	[DateDeleted] [datetime2](7) NULL,
	[Moderador] [bit] NOT NULL,
	[HasContentToReview] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[ArticleOffensiveWord] ([OffensiveWordsId], [articlesContainingWordId]) VALUES (23, 82)
INSERT [dbo].[ArticleOffensiveWord] ([OffensiveWordsId], [articlesContainingWordId]) VALUES (22, 83)
GO
SET IDENTITY_INSERT [dbo].[Articles] ON 

INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId], [State], [HadOffensiveWords]) VALUES (79, N'Articulo 3', N'Lórem ipsum dolor sit amet, consectetur adipiscing elit. Sed placerat eu risus non imperdiet. Praesent sagittis, ex quis cursus molestie, mauris arcu lobortis libero, nec aliquam nunc nisl id mauris. Orci varius nato penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas tincidunt non purus non pulvinar. Fusce id dignissim nunc, in ultricies massa. Curabitur consequat pharetra quam a auctor. Etiam tincidunt cursus nibh sed ultrices. Suspendisse sit amet urna eget elit aliquam lobortis sit amet nec arcu.', 0, CAST(N'2023-06-15T02:57:41.1499106' AS DateTime2), CAST(N'2023-06-15T02:58:35.8169033' AS DateTime2), NULL, N'data:image/jpeg;base64,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 ', 2, 20, 2, 1)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId], [State], [HadOffensiveWords]) VALUES (80, N'Articulo4', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed placerat eu risus non imperdiet. Praesent sagittis, ex quis cursus molestie, mauris arcu lobortis libero, nec aliquam nunc nisl id mauris. Orci varius nato penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas tincidunt non purus non pulvinar. Fusce id dignissim nunc, in ultricies massa. Curabitur consequat pharetra quam a auctor. Etiam tincidunt cursus nibh sed ultrices. Suspendisse sit amet urna eget elit aliquam lobortis sit amet nec arcu.', 1, CAST(N'2023-06-15T02:59:42.7637349' AS DateTime2), CAST(N'2023-06-15T02:59:42.7637351' AS DateTime2), NULL, N'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Test-Logo.svg/783px-Test-Logo.svg.png data:image/jpeg;base64,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', 3, 20, 0, 0)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId], [State], [HadOffensiveWords]) VALUES (81, N'Articulo5', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed placerat eu risus non imperdiet. Praesent sagittis, ex quis cursus molestie, mauris arcu lobortis libero, nec aliquam nunc nisl id mauris. Orci varius nato penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas tincidunt non purus non pulvinar. Fusce id dignissim nunc, in ultricies massa. Curabitur consequat pharetra quam a auctor. Etiam tincidunt cursus nibh sed ultrices. Suspendisse sit amet urna eget elit aliquam lobortis sit amet nec arcu.', 0, CAST(N'2023-06-15T03:00:47.6039572' AS DateTime2), CAST(N'2023-06-15T03:00:47.6039573' AS DateTime2), CAST(N'2023-06-15T03:00:51.0554277' AS DateTime2), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKreZAwpY2GQxNFHYBJ2y_PrHA8j_jQA2-LA&usqp=CAU ', 0, 20, 3, 0)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId], [State], [HadOffensiveWords]) VALUES (82, N'Articulo 1', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed placerat eu risus non imperdiet. Praesent sagittis, ex quis cursus molestie, mauris arcu lobortis libero, nec aliquam nunc nisl id mauris. Orci varius nato penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas tincidunt non purus non pulvinar. Fusce id dignissim nunc, in ultricies massa. Curabitur consequat pharetra quam a auctor. Etiam tincidunt cursus nibh sed ultrices. Suspendisse sit amet urna eget elit aliquam lobortis sit amet nec arcu que.', 0, CAST(N'2023-06-15T03:01:54.6297618' AS DateTime2), CAST(N'2023-06-15T03:01:54.6297629' AS DateTime2), NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKreZAwpY2GQxNFHYBJ2y_PrHA8j_jQA2-LA&usqp=CAU ', 0, 22, 1, 1)
INSERT [dbo].[Articles] ([Id], [Name], [Body], [Private], [DateCreated], [DateModified], [DateDeleted], [Image], [Template], [UserId], [State], [HadOffensiveWords]) VALUES (83, N'Articulo2', N'Lorem Hola ipsum dolor sit amet, consectetur adipiscing elit. Sed placerat eu risus non imperdiet. Praesent sagittis, ex quis cursus molestie, mauris arcu lobortis libero, nec aliquam nunc nisl id mauris. Orci varius nato penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas tincidunt non purus non pulvinar. Fusce id dignissim nunc, in ultricies massa. Curabitur consequat pharetra quam a auctor. Etiam tincidunt cursus nibh sed ultrices. Suspendisse sit amet urna eget elit aliquam lobortis sit amet nec arcu.', 0, CAST(N'2023-06-15T03:03:07.7093179' AS DateTime2), CAST(N'2023-06-15T03:03:07.7093191' AS DateTime2), NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKreZAwpY2GQxNFHYBJ2y_PrHA8j_jQA2-LA&usqp=CAU ', 1, 21, 1, 1)
SET IDENTITY_INSERT [dbo].[Articles] OFF
GO
INSERT [dbo].[CommentOffensiveWord] ([OffensiveWordsId], [commentsContainingWordId]) VALUES (22, 178)
GO
SET IDENTITY_INSERT [dbo].[Comments] ON 

INSERT [dbo].[Comments] ([Id], [UserId], [Body], [CommentId], [DateCreated], [DateModified], [DateDeleted], [ArticleId], [State], [isSubComment], [HadOffensiveWords]) VALUES (178, 21, N'Hola', NULL, CAST(N'2023-06-15T03:03:22.7365270' AS DateTime2), CAST(N'2023-06-15T03:03:22.7365279' AS DateTime2), NULL, 79, 1, 0, 1)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [CommentId], [DateCreated], [DateModified], [DateDeleted], [ArticleId], [State], [isSubComment], [HadOffensiveWords]) VALUES (179, 21, N'Ey', NULL, CAST(N'2023-06-15T03:03:41.5366390' AS DateTime2), CAST(N'2023-06-15T03:03:41.5366400' AS DateTime2), NULL, 79, 2, 0, 0)
INSERT [dbo].[Comments] ([Id], [UserId], [Body], [CommentId], [DateCreated], [DateModified], [DateDeleted], [ArticleId], [State], [isSubComment], [HadOffensiveWords]) VALUES (180, 21, N'Bueno', NULL, CAST(N'2023-06-15T03:03:51.0787315' AS DateTime2), CAST(N'2023-06-15T03:03:51.0787322' AS DateTime2), NULL, 79, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[Comments] OFF
GO
SET IDENTITY_INSERT [dbo].[LogEntries] ON 

INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (294, 18, N'Login', NULL, CAST(N'2023-06-15T05:10:25.7826163' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (295, 19, N'Login', NULL, CAST(N'2023-06-15T05:11:21.4151535' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (296, 18, N'Login', NULL, CAST(N'2023-06-15T05:18:52.0539781' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (297, 19, N'Login', NULL, CAST(N'2023-06-15T05:22:27.8543726' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (298, 19, N'Login', NULL, CAST(N'2023-06-15T05:22:59.8963567' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (299, 19, N'Login', NULL, CAST(N'2023-06-15T05:48:35.9461398' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (300, 20, N'Login', NULL, CAST(N'2023-06-15T05:53:41.0639972' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (301, 22, N'Login', NULL, CAST(N'2023-06-15T06:01:12.5855259' AS DateTime2))
INSERT [dbo].[LogEntries] ([Id], [UserId], [ActionType], [SearchQuery], [Timestamp]) VALUES (302, 21, N'Login', NULL, CAST(N'2023-06-15T06:02:14.9687493' AS DateTime2))
SET IDENTITY_INSERT [dbo].[LogEntries] OFF
GO
SET IDENTITY_INSERT [dbo].[OffensiveWords] ON 

INSERT [dbo].[OffensiveWords] ([Id], [Word]) VALUES (22, N'Hola')
INSERT [dbo].[OffensiveWords] ([Id], [Word]) VALUES (23, N'Que')
INSERT [dbo].[OffensiveWords] ([Id], [Word]) VALUES (24, N'Tal')
SET IDENTITY_INSERT [dbo].[OffensiveWords] OFF
GO
SET IDENTITY_INSERT [dbo].[Sessions] ON 

INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (235, 18, N'fd506911-3f54-4a84-9fe7-6febf5f19f54', CAST(N'2023-06-15T02:10:25.6121980' AS DateTime2), CAST(N'2023-06-15T02:10:41.8536390' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (236, 19, N'9cd652eb-5fd4-4ecc-b8f5-daf51622fd33', CAST(N'2023-06-15T02:11:21.3981760' AS DateTime2), CAST(N'2023-06-15T02:21:23.0600000' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (237, 18, N'ef32d4b5-6d21-4f02-a718-2eb5d28ad294', CAST(N'2023-06-15T02:18:51.8240732' AS DateTime2), CAST(N'2023-06-15T02:21:23.0600000' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (238, 19, N'fb1ff860-734d-4738-98a6-17008430b96f', CAST(N'2023-06-15T02:22:27.8440855' AS DateTime2), CAST(N'2023-06-15T02:22:53.5275017' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (239, 19, N'2a202882-7d64-4806-bf91-8da056500843', CAST(N'2023-06-15T02:22:59.8834476' AS DateTime2), CAST(N'2023-06-15T02:48:31.2166667' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (240, 19, N'4e0068b5-5fd4-4b7e-aae2-b63a1d55b206', CAST(N'2023-06-15T02:48:35.7182580' AS DateTime2), CAST(N'2023-06-15T02:53:34.1097370' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (241, 20, N'c706c1d9-31c9-4526-9d16-dd46e7f262da', CAST(N'2023-06-15T02:53:41.0507726' AS DateTime2), CAST(N'2023-06-15T03:01:06.8347459' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (242, 22, N'696422fb-a78f-455d-ab1a-8fb29b823b22', CAST(N'2023-06-15T03:01:12.5745974' AS DateTime2), CAST(N'2023-06-15T03:02:08.3521703' AS DateTime2))
INSERT [dbo].[Sessions] ([Id], [UserId], [Token], [DateTimeLogin], [DateTimeLogout]) VALUES (243, 21, N'4bb389c9-7ab1-41b4-926d-7d0bca950232', CAST(N'2023-06-15T03:02:14.9568154' AS DateTime2), CAST(N'2023-06-15T03:05:39.2645126' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Sessions] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted], [Moderador], [HasContentToReview]) VALUES (18, N'Juan', N'12345', N'j@j.com', N'Juan', N'Perez', 0, 0, NULL, 1, 1)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted], [Moderador], [HasContentToReview]) VALUES (19, N'admin', N'12345', N'admin@admin.com', N'admin', N'admin', 0, 1, NULL, 0, 1)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted], [Moderador], [HasContentToReview]) VALUES (20, N'Pedro', N'12345', N'p@p.com', N'Pedro', N'Perez', 1, 0, NULL, 0, 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted], [Moderador], [HasContentToReview]) VALUES (21, N'Juana', N'12345', N'ju@j.com', N'Juana', N'Lopez', 1, 1, NULL, 0, 0)
INSERT [dbo].[Users] ([Id], [Username], [Password], [Email], [Name], [LastName], [Blogger], [Admin], [DateDeleted], [Moderador], [HasContentToReview]) VALUES (22, N'Monica', N'12345', N'm@m.com', N'Monica', N'Alonso', 1, 0, NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Articles] ADD  DEFAULT ((0)) FOR [Template]
GO
ALTER TABLE [dbo].[Articles] ADD  DEFAULT ((0)) FOR [UserId]
GO
ALTER TABLE [dbo].[Articles] ADD  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[Articles] ADD  DEFAULT (CONVERT([bit],(0))) FOR [HadOffensiveWords]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT ((0)) FOR [ArticleId]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT (CONVERT([bit],(0))) FOR [isSubComment]
GO
ALTER TABLE [dbo].[Comments] ADD  DEFAULT (CONVERT([bit],(0))) FOR [HadOffensiveWords]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (CONVERT([bit],(0))) FOR [Moderador]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (CONVERT([bit],(0))) FOR [HasContentToReview]
GO
ALTER TABLE [dbo].[ArticleOffensiveWord]  WITH CHECK ADD  CONSTRAINT [FK_ArticleOffensiveWord_Articles_articlesContainingWordId] FOREIGN KEY([articlesContainingWordId])
REFERENCES [dbo].[Articles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArticleOffensiveWord] CHECK CONSTRAINT [FK_ArticleOffensiveWord_Articles_articlesContainingWordId]
GO
ALTER TABLE [dbo].[ArticleOffensiveWord]  WITH CHECK ADD  CONSTRAINT [FK_ArticleOffensiveWord_OffensiveWords_OffensiveWordsId] FOREIGN KEY([OffensiveWordsId])
REFERENCES [dbo].[OffensiveWords] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ArticleOffensiveWord] CHECK CONSTRAINT [FK_ArticleOffensiveWord_OffensiveWords_OffensiveWordsId]
GO
ALTER TABLE [dbo].[Articles]  WITH CHECK ADD  CONSTRAINT [FK_Articles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Articles] CHECK CONSTRAINT [FK_Articles_Users_UserId]
GO
ALTER TABLE [dbo].[CommentOffensiveWord]  WITH CHECK ADD  CONSTRAINT [FK_CommentOffensiveWord_Comments_commentsContainingWordId] FOREIGN KEY([commentsContainingWordId])
REFERENCES [dbo].[Comments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommentOffensiveWord] CHECK CONSTRAINT [FK_CommentOffensiveWord_Comments_commentsContainingWordId]
GO
ALTER TABLE [dbo].[CommentOffensiveWord]  WITH CHECK ADD  CONSTRAINT [FK_CommentOffensiveWord_OffensiveWords_OffensiveWordsId] FOREIGN KEY([OffensiveWordsId])
REFERENCES [dbo].[OffensiveWords] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CommentOffensiveWord] CHECK CONSTRAINT [FK_CommentOffensiveWord_OffensiveWords_OffensiveWordsId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Articles_ArticleId] FOREIGN KEY([ArticleId])
REFERENCES [dbo].[Articles] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Articles_ArticleId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Comments_CommentId] FOREIGN KEY([CommentId])
REFERENCES [dbo].[Comments] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Comments_CommentId]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users_UserId]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [FK_Sessions_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [FK_Sessions_Users_UserId]
GO
