using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AuthenTestLan2.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace AuthenTestLan2.Controllers
{
    public class AccountController : Controller
    {
        private UserManager<AppUser> _userManager { get; }
        private SignInManager<AppUser> _signInManager { get; }
        private readonly IdentityAppContext _identityAppContext;

        public AccountController(UserManager<AppUser> userManager, SignInManager<AppUser> signInManager, IdentityAppContext identityAppContext)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _identityAppContext = identityAppContext;
        }
        public async Task<IActionResult> Logout()
        {
            try
            {
                await _signInManager.SignOutAsync();
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                ViewBag.Message = ex.ToString();
            }
            return View();
        }
        public async Task<IActionResult> Login()
        {
            try
            {
                var result = await _signInManager.PasswordSignInAsync("dandan", "12345689@Abc", false, false);
                if (result.Succeeded)
                {
                    var user = await _userManager.FindByNameAsync("dandan");
                    var roles = await _userManager.GetRolesAsync(user);
                    if (roles != null)
                    {
                        var role = string.Join(",", roles);
                        var loginSessioLogs = new LoginSessionLog()
                        {
                            UserId = Guid.NewGuid().ToString(),
                            UserName = "Dan",
                            CreatedDate = DateTime.Now,
                            RoleName = role,
                            LoginProvider = "AMIS",
                            ProviderKey = "aaaaaa",
                            ProviderDisplayName = "abbbb"
                        };
                        if (result.Succeeded)
                        {
                            ViewBag.Result = "Đăng nhập thành công";
                        }
                        else
                        {
                            ViewBag.Result = "Đăng nhập không thành công";
                        }
                    }

                }

            }
            catch (Exception ex)
            {
                ViewBag.Message = ex.ToString();
            }
            return View();
        }
        public async Task<IActionResult> Register()
        {
            try
            {

                ViewBag.Message = "User already";
                AppUser appUser = await _userManager.FindByNameAsync("fuckyou");
                var test = _userManager.Users.Where(x => x.UserName == "dandan").FirstOrDefault();
                if (appUser == null)
                {
                    appUser = new AppUser();
                    appUser.Email = "dan@gmail.com";
                    appUser.FirstName = "Dần";
                    appUser.UserName = "dandan";
                    appUser.LastName = "Đẹp trai";

                    IdentityResult result = await _userManager.CreateAsync(appUser, "12345689@Abc");
                    ViewBag.Message = "User was created";
                }
            }
            catch (Exception ex)
            {
                ViewBag.Message = ex.ToString();
            }
            return View();
        }
    }
}
