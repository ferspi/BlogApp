﻿using BlogsApp.Domain.Entities;
using BlogsApp.WebAPI.Controllers;
using BlogsApp.IBusinessLogic.Interfaces;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using BlogsApp.WebAPI.DTOs;
using Microsoft.AspNetCore.Mvc;
using BlogsApp.Domain.Exceptions;
using BlogsApp.DataAccess.Interfaces.Exceptions;
using Microsoft.AspNetCore.Http;

namespace WebApi.Test
{
    [TestClass]
    public class UserControllerTest
    {
        private Mock<IUserLogic>? userLogicMock;
        private Mock<IArticleLogic> articleLogicMock;
        private Mock<ISessionLogic> sessionLogicMock;
        private UserController? controller;

        User loggedUser;
        User aValidBlogger;
        User aBloggerToUpdate;
        CreateUserRequestDTO aValidBloggerDTO;
        UserDto updateBloggerRequestDto;
        ICollection<User> usersRanking;
        ICollection<Article> userArticles;
        Article article;
        private Guid token;

        [TestInitialize]
        public void InitTest()
        {
            userLogicMock = new Mock<IUserLogic>(MockBehavior.Default);
            articleLogicMock = new Mock<IArticleLogic>(MockBehavior.Strict);
            sessionLogicMock = new Mock<ISessionLogic>(MockBehavior.Strict);
            controller = new UserController(userLogicMock.Object, articleLogicMock.Object, sessionLogicMock.Object);

            loggedUser = new User() { Id = 1 };
            aValidBlogger = new User(
                "JPerez",
                "jperez123",
                "jperez@mail.com",
                "Juan",
                "Perez",
                 true,
                 false,
                 false
            );
            aValidBlogger.Id = 2;

            aValidBloggerDTO = new CreateUserRequestDTO
            {
                Username = aValidBlogger.Username,
                Password = aValidBlogger.Password,
                Email = aValidBlogger.Email,
                Name = aValidBlogger.Name,
                LastName = aValidBlogger.LastName,
                Blogger = aValidBlogger.Blogger,
                Admin = aValidBlogger.Admin,
            };

            aBloggerToUpdate = new User() { Id = 2, Username = "username", Email = "email@e.com" };
            updateBloggerRequestDto = new UserDto();
            usersRanking = new List<User>() { aValidBlogger, aBloggerToUpdate };
            article = new Article()
            {
                Id = 1,
                Name = "name",
                User = aValidBlogger,
                Body = "body",
                Private = false,
                Template = 1,
                Image = ""
            };
            userArticles = new List<Article>() { article };
            token = Guid.NewGuid();
        }


        [TestMethod]
        public void PostUserOkTest()
        {
            userLogicMock!.Setup(x => x.CreateUser(It.IsAny<User>())).Returns(aValidBlogger);

            var result = controller!.PostUser(aValidBloggerDTO);
            var objectResult = result as ObjectResult;
            var statusCode = objectResult?.StatusCode;

            userLogicMock.VerifyAll();
            Assert.AreEqual(200, statusCode);
            Assert.AreEqual(objectResult.Value, aValidBlogger);
        }

        [TestMethod]
        public void PatchUserOk()
        {
            userLogicMock.Setup(x => x.GetUserById(It.IsAny<int>())).Returns(aBloggerToUpdate);
            userLogicMock.Setup(x => x.UpdateUser(It.IsAny<User>(), It.IsAny<User>())).Returns(aBloggerToUpdate);
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller.PatchUser(aBloggerToUpdate.Id, updateBloggerRequestDto, token.ToString());

            var objectResult = result as OkObjectResult;
            var statusCode = objectResult?.StatusCode;

            userLogicMock.VerifyAll();
            Assert.AreEqual(200, statusCode);
            Assert.AreEqual(objectResult.Value, aBloggerToUpdate);
        }


        [TestMethod]
        [ExpectedException(typeof(UnauthorizedAccessException))]
        public void PatchUserFail()
        {
            userLogicMock.Setup(x => x.GetUserById(It.IsAny<int>())).Returns(aBloggerToUpdate);
            userLogicMock!.Setup(x => x.UpdateUser(It.IsAny<User>(), It.IsAny<User>())).Throws(new UnauthorizedAccessException());
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.PatchUser(aBloggerToUpdate.Id, updateBloggerRequestDto, token.ToString());
            var objectResult = result as ObjectResult;
            var statusCode = objectResult?.StatusCode;

            userLogicMock.VerifyAll();
            Assert.IsNotNull(objectResult);
            Assert.AreEqual(400, statusCode);
        }

        [TestMethod]
        public void DeleteUserOk()
        {
            userLogicMock!.Setup(x => x.DeleteUser(It.IsAny<User>(), It.IsAny<int>())).Returns(aBloggerToUpdate);
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.DeleteUser(aBloggerToUpdate.Id, token.ToString());
            var objectResult = result as OkObjectResult;
            var statusCode = objectResult?.StatusCode;

            userLogicMock.VerifyAll();
            Assert.IsNotNull(objectResult);
            Assert.AreEqual(200, statusCode);
            Assert.AreEqual(objectResult.Value, aBloggerToUpdate);
        }

        [TestMethod]
        [ExpectedException(typeof(UnauthorizedAccessException))]
        public void DeleteUserWithoutPermissions()
        {
            userLogicMock.Setup(m => m.DeleteUser(It.IsAny<User>(), It.IsAny<int>())).Throws(new UnauthorizedAccessException());
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.DeleteUser(It.IsAny<int>(), token.ToString());
            var objectResult = result as ObjectResult;
            var statusCode = objectResult?.StatusCode;

            userLogicMock.VerifyAll();
            Assert.AreEqual(500, statusCode);
        }

        [TestMethod]
        [ExpectedException(typeof(NotFoundDbException))]
        public void DeleteUserNotFound()
        {
            userLogicMock.Setup(m => m.DeleteUser(It.IsAny<User>(), It.IsAny<int>())).Throws(new NotFoundDbException(""));
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.DeleteUser(It.IsAny<int>(), token.ToString());
            var objectResult = result as ObjectResult;
            var statusCode = objectResult?.StatusCode;

            articleLogicMock.VerifyAll();
            Assert.AreEqual(404, statusCode);
        }

        [TestMethod]
        public void GetRankingOk()
        {
            userLogicMock.Setup(m => m.GetUsersRanking(It.IsAny<User>(), It.IsAny<DateTime>(), It.IsAny<DateTime>(), It.IsAny<int>(), It.IsAny<bool>())).Returns(usersRanking);
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.GetRanking(DateTime.Parse("2022/04/03"), DateTime.Parse("2022/04/03"), 10, false, token.ToString());
            var objectResult = result as OkObjectResult;
            var statusCode = objectResult?.StatusCode;

            ICollection<UserRankingDto> expectedResult = new List<UserRankingDto>();

            userLogicMock.VerifyAll();
            Assert.IsNotNull(objectResult);
            Assert.AreEqual(200, statusCode);
            Assert.AreEqual((objectResult.Value).GetType(), expectedResult.GetType());
        }


        [TestMethod]
        [ExpectedException(typeof(UnauthorizedAccessException))]
        public void GetRankingBadRequest()
        {
            userLogicMock.Setup(m => m.GetUsersRanking(It.IsAny<User>(), It.IsAny<DateTime>(), It.IsAny<DateTime>(), It.IsAny<int>(), It.IsAny<bool>())).Throws(new UnauthorizedAccessException());
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.GetRanking(DateTime.Parse("2022/04/03"), DateTime.Parse("2022/04/03"), 10, false, token.ToString());
            var objectResult = result as OkObjectResult;
            var statusCode = objectResult?.StatusCode;

            userLogicMock.VerifyAll();
            Assert.AreEqual(500, statusCode);
        }

        [TestMethod]
        public void GetUserArticlesOk()
        {
            articleLogicMock.Setup(m => m.GetArticlesByUser(It.IsAny<int>(), It.IsAny<User>())).Returns(userArticles);
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.GetUserArticles(aValidBlogger.Id, token.ToString());
            var objectResult = result as OkObjectResult;
            var statusCode = objectResult?.StatusCode;

            articleLogicMock.VerifyAll();
            sessionLogicMock.VerifyAll();
            Assert.IsNotNull(objectResult);
            Assert.AreEqual(200, statusCode);
        }

        [TestMethod]
        [ExpectedException(typeof(NotFoundDbException))]
        public void GetArticlesUserNotFound()
        {
            articleLogicMock.Setup(m => m.GetArticlesByUser(It.IsAny<int>(), It.IsAny<User>())).Throws(new NotFoundDbException(""));
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.GetUserArticles(It.IsAny<int>(), token.ToString());
            var objectResult = result as ObjectResult;
            var statusCode = objectResult?.StatusCode;

            articleLogicMock.VerifyAll();
            Assert.AreEqual(404, statusCode);
        }

        [TestMethod]
        [ExpectedException(typeof(UnauthorizedAccessException))]
        public void GetUserArticlesBadRequest()
        {
            articleLogicMock.Setup(m => m.GetArticlesByUser(It.IsAny<int>(), It.IsAny<User>())).Throws(new UnauthorizedAccessException());
            sessionLogicMock!.Setup(m => m.GetUserFromToken(It.IsAny<Guid>())).Returns(loggedUser);

            var result = controller!.GetUserArticles(It.IsAny<int>(), token.ToString());
            var objectResult = result as OkObjectResult;
            var statusCode = objectResult?.StatusCode;

            articleLogicMock.VerifyAll();
            Assert.AreEqual(500, statusCode);
        }
    }
}

