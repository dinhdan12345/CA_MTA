using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AuthenTestLan2.Models
{
    public class IdentityAppContext : IdentityDbContext<AppUser, AppRole, string>
    {
        public IdentityAppContext(DbContextOptions<IdentityAppContext> options) : base(options)
        {

        }
        public DbSet<LoginSessionLog> LoginSessionLogs { get; set; }
    }
}
