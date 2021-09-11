using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class DTO_NguoiDung
    {
        int idNguoiDung;
        int idKieuNguoiDung;
        string tenHienthi;
        string tenDangNhap;
        string matKhau;
        int idNhanVien;
        string tinhTrang;
        public int IdNguoiDung { get => idNguoiDung; set => idNguoiDung = value; }
        public int IdKieuNguoiDung { get => idKieuNguoiDung; set => idKieuNguoiDung = value; }
        public string TenDangNhap { get => tenDangNhap; set => tenDangNhap = value; }
        public string MatKhau { get => matKhau; set => matKhau = value; }
        public int IdNhanVien { get => idNhanVien; set => idNhanVien = value; }
        public string TinhTrang { get => tinhTrang; set => tinhTrang = value; }
        public string TenHienthi { get => tenHienthi; set => tenHienthi = value; }

        public DTO_NguoiDung(int idNguoidung,string tenHienthi,string tenDN,int idNhanvien)  
        {
            this.IdNguoiDung = idNguoiDung;
            this.TenHienthi = tenHienthi;
            this.TenDangNhap = tenDN;
            this.IdNhanVien = idNhanvien;
        }
        public DTO_NguoiDung(DataRow row)
        {
            this.idNguoiDung = (int)row["IDNguoiDung"];
            this.idKieuNguoiDung = (int)row["IDKieuNguoiDung"];
            this.tenDangNhap = row["TenDangNhap"].ToString();
            this.matKhau = row["MatKhau"].ToString();
            this.idNhanVien = (int)row["IDNhanVien"];
            this.tinhTrang = row["TinhTrang"].ToString();
        }
    }
}
