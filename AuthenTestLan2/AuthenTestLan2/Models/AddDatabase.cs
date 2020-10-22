using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AuthenTestLan2.Models
{
    public static class AddDatabase
    {
        public static void RegisterDatabases(this IServiceCollection services, IConfiguration configuration)
        {
            //we are dealing with real databases
            services.AddDbContext<IdentityAppContext>(options =>
                options.UseMySql(configuration.GetConnectionString("DefaultConnection")));
        }
    }
}
