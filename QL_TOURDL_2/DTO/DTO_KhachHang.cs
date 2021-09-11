using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class DTO_KhachHang
    {
        int idKH;
        string ten;
        string diaChi;
        string soDienThoai;
        string canCuoc;
        string gioiTinh;

        public int IdKH { get => idKH; set => idKH = value; }
        public string Ten { get => ten; set => ten = value; }
        public string DiaChi { get => diaChi; set => diaChi = value; }
        public string SoDienThoai { get => soDienThoai; set => soDienThoai = value; }
        public string CanCuoc { get => canCuoc; set => canCuoc = value; }
        public string GioiTinh { get => gioiTinh; set => gioiTinh = value; }
        public DTO_KhachHang(int idKH,string ten,string diaChi,string soDienThoai,string canCuoc,string gioiTinh)
        {
            this.IdKH = idKH;
            this.Ten = ten;
            this.DiaChi = diaChi;
            this.SoDienThoai = soDienThoai;
            this.CanCuoc = canCuoc;
            this.GioiTinh = gioiTinh;
        }
        public DTO_KhachHang() { }
    }
}
