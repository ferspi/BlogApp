using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using BlogsApp.WebAPI.Filters;
using Microsoft.AspNetCore.Mvc;
using BlogsApp.IBusinessLogic.Interfaces;
using BlogsApp.Domain.Entities;
using Newtonsoft.Json.Linq;
using BlogsApp.WebAPI.DTOs;

namespace BlogsApp.WebAPI.Controllers
{
    [Route("api/offensive-words")]
    [ServiceFilter(typeof(AuthorizationFilter))]
    public class OffensiveWordsController : BlogsAppControllerBase
    {
        private readonly IOffensiveWordsValidator offensiveWordsValidator;

        public OffensiveWordsController(IOffensiveWordsValidator offensiveWordsValidator, ISessionLogic sessionLogic) : base(sessionLogic)
        {
            this.offensiveWordsValidator = offensiveWordsValidator;
        }

        [HttpPost]
        public IActionResult AddOffensiveWord([FromBody] OffensiveWordDTO wordRequest, [FromHeader] string token)
        {
            offensiveWordsValidator.AddOffensiveWord(base.GetLoggedUser(token), wordRequest.word);
            return new OkObjectResult(new { message = "Palabra '" + wordRequest.word + "' agregada a la lista de palabras ofensivas" });
        }

        [HttpDelete]
        public IActionResult RemoveOffensiveWord([FromBody] OffensiveWordDTO wordRequest, [FromHeader] string token)
        {
            offensiveWordsValidator.RemoveOffensiveWord(base.GetLoggedUser(token), wordRequest.word);
            return new OkObjectResult(new { message = "Palabra '" + wordRequest.word + "' eliminada de la lista de palabras ofensivas" });
        }

        [HttpGet("content")]
        public IActionResult GetContentToReview([FromHeader] string token)
        {
            User loggedUser = base.GetLoggedUser(token);

            ICollection<ContentDTO> articlesToReview = ContentConverter.ArticlesToContentList(offensiveWordsValidator.GetArticlesToReview(loggedUser));
            ICollection<ContentDTO> commentsToReview = ContentConverter.CommentsToContentList(offensiveWordsValidator.GetCommentsToReview(loggedUser));

            return new OkObjectResult(articlesToReview.Concat(commentsToReview));
        }

        [HttpGet]
        public IActionResult GetOffensiveWords([FromHeader] string token)
        {
            return new OkObjectResult(offensiveWordsValidator.GetOffensiveWords(base.GetLoggedUser(token)));
        }

        [HttpPut("notification-dismisser")]
        public IActionResult DismissNotifications([FromHeader] string token)
        {
            User loggedUser = base.GetLoggedUser(token);
            offensiveWordsValidator.UnflagReviewContentForUser(loggedUser, loggedUser);
            return new OkObjectResult(new { message = "Notificaciones marcadas como vistas" });
        }

        [HttpGet("notification-viewer")]
        public IActionResult CheckUserHasContentToReview([FromHeader] string token)
        {
            return new OkObjectResult(offensiveWordsValidator.checkUserHasContentToReview(base.GetLoggedUser(token)));
        }
    }
}