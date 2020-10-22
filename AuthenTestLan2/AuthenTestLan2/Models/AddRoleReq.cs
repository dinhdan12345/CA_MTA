using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AuthenTestLan2.Models
{
    public class AddRoleReq
    {
        public Guid? RoleID { get; set; }
        public string RoleName { get; set; }
    }
}
