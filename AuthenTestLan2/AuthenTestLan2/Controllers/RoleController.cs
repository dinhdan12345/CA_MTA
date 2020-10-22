using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AuthenTestLan2.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace AuthenTestLan2.Controllers
{
    public class RoleController : Controller
    {
        private RoleManager<AppRole> _roleManager { get; }
        private UserManager<AppUser> _userManager { get; }
        public RoleController(RoleManager<AppRole> roleManager, UserManager<AppUser> userManager)
        {
            this._roleManager = roleManager;
            this._userManager = userManager;
        }
        public IActionResult Index()
        {
            return View();
        }
        [Authorize(Roles = "testadmin1")]
        //[Authorize(Policy = "RequireAdministratorRole")]
        public async Task<IActionResult> CreateRole(AddRoleReq objReq)
        {
            var user = await _userManager.FindByNameAsync("dandan");
            var roleOfUser = await _userManager.GetRolesAsync(user);
            if (User.IsInRole("admin"))
            {
                var role = new AppRole()
                {
                    Id = Guid.NewGuid().ToString(),
                    DisplayName = "administrator",
                    Name = "admin"
                };
                var roleExist = await _roleManager.RoleExistsAsync("admin");
                if (!roleExist)
                {
                    var result = await _roleManager.CreateAsync(role);
                }
                ViewBag.test = "Có vai trò";
            }
            else
            {
                ViewBag.test = "Không có vai trò";
            }
            return View();
        }
        [HttpPost]
        public async Task<string> AddUserToRole()
        {
            var result= string.Empty;
            var user = await _userManager.FindByNameAsync("dandan");
            var roleOfUser = await _userManager.GetRolesAsync(user);
            var result1 = await _userManager.AddToRoleAsync(user, "admin");
            if(result1.Succeeded)
            {
                result = "Success";
            }    
            return result;
        }
    }
}
