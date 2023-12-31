USE [BlogsApp]
GO
/****** Object:  Table [dbo].[ArticleOffensiveWord]    Script Date: 15/6/2023 4:19:01 ******/
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
/****** Object:  Table [dbo].[Articles]    Script Date: 15/6/2023 4:19:01 ******/
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
/****** Object:  Table [dbo].[CommentOffensiveWord]    Script Date: 15/6/2023 4:19:01 ******/
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
/****** Object:  Table [dbo].[Comments]    Script Date: 15/6/2023 4:19:01 ******/
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
/****** Object:  Table [dbo].[LogEntries]    Script Date: 15/6/2023 4:19:01 ******/
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
/****** Object:  Table [dbo].[OffensiveWords]    Script Date: 15/6/2023 4:19:01 ******/
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
/****** Object:  Table [dbo].[Sessions]    Script Date: 15/6/2023 4:19:01 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 15/6/2023 4:19:01 ******/
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
