﻿using BlogsApp.Domain.Entities;
using BlogsApp.Logging.Entities;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace BlogsApp.Logging.Test
{
    [TestClass]
    public class LoggingEntitiTest
    {
        [TestMethod]
        public void LogEntry_Constructor_ShouldCreateObjectWithValidData()
        {
            int userId = 1;
            User user = new User();
            string actionType = "search";
            string searchQuery = "blog";
            DateTime timestamp = DateTime.Now;

            LogEntry logEntry = new LogEntry(userId, actionType, searchQuery, timestamp);

            Assert.IsNotNull(logEntry);
            Assert.AreEqual(userId, logEntry.UserId);
            Assert.AreEqual(actionType, logEntry.ActionType);
            Assert.AreEqual(searchQuery, logEntry.SearchQuery);
            Assert.AreEqual(timestamp, logEntry.Timestamp);
        }

        [TestMethod]
        public void LogEntry_Constructor_ShouldThrowArgumentException_WhenActionTypeIsNull()
        {
            int userId = 1;
            string actionType = null;
            string searchQuery = "blog";
            DateTime timestamp = DateTime.Now;

            Assert.ThrowsException<ArgumentException>(() => new LogEntry(userId, actionType, searchQuery, timestamp));
        }
    }
}
