using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class DTO_DiaDanh
    {
        int idDiadanh;
        string tenDiadanh;

        public string TenDiadanh { get => tenDiadanh; set => tenDiadanh = value; }
        public int IdDiadanh { get => idDiadanh; set => idDiadanh = value; }
        public DTO_DiaDanh(int id,string ten)
        {
            this.idDiadanh = id;
            this.tenDiadanh = ten;
        }
        public DTO_DiaDanh() { }
        
    }
}
