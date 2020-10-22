﻿using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AuthenTestLan2.Models
{
    public class AppUser:IdentityUser<string>
    {
        public AppUser() : base()
        {
            this.Id = Guid.NewGuid().ToString();
        }
        public string MisaIdUserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime? Birthday { get; set; }
        public string Position { get; set; }
        public string Address { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public string Department { get; set; }
    }
    public class LoginSessionLog : IdentityUserLogin<string>
    {
        public string UserName { get; set; }
        public string RoleName { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}
