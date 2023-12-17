using System;
using System.Collections.Generic;
using BlogsApp.Domain.Entities;


namespace BlogsApp.IDataAccess.Interfaces
{
    public interface IUserRepository : IRepository<User>
    {
        void Update(User value);
        int GetUserContentCount(Func<User, bool> userFunc, Func<Content, bool> contentFunc);
    }
}
