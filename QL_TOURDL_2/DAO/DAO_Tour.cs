using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class DAO_Tour
    {
        SqlConnection conn = new SqlConnection(SQLDatabase.ConnectionString);
        public DataTable loadTourTatCa()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiThongTinTour", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadTourTatCaQuanTri()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiThongTinTourQuanTri", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadTourTheoNgay(DateTime ngayDi,DateTime ngayVe)
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTourNgayThangNam", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter par1 = new SqlParameter("@ngayDi", SqlDbType.Date);
            par1.Value = ngayDi.Date;
            SqlParameter par2 = new SqlParameter("@ngayVe", SqlDbType.Date);
            par2.Value = ngayVe.Date;
            cmd.Parameters.Add(par1);
            cmd.Parameters.Add(par2);
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadTourTheoTT(int idTrangThai)
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTourTheoTrangThai", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter par1 = new SqlParameter("@IDTrangThai", SqlDbType.Int);
            par1.Value = idTrangThai;
            cmd.Parameters.Add(par1);
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadTourTheoNV(int idNhanVien)
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTourTheoNhanVien", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter par1 = new SqlParameter("@IDNhanVien", SqlDbType.Int);
            par1.Value = idNhanVien;
            cmd.Parameters.Add(par1);
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadDSTrangThai()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTrangThaiTour", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadTourKeHoach()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTourKeHoach", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadTourChuanBi()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTourChuanBi", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable loadTourIDKH(int idKH)
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTourIDKH", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter par1 = new SqlParameter("@idKH", SqlDbType.Int);
            par1.Value = idKH;
            cmd.Parameters.Add(par1);
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable timKiemTourTheoTen(string tenTour)
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_TimKiemTourTheoTen", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter par1 = new SqlParameter("@tenTour", SqlDbType.NVarChar);
            par1.Value = tenTour;
            cmd.Parameters.Add(par1);
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public DataTable timKiemTourTheoQuanTri(string tenTour)
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_TimKiemTourTheoTenQuanTri", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter par1 = new SqlParameter("@tenTour", SqlDbType.NVarChar);
            par1.Value = tenTour;
            cmd.Parameters.Add(par1);
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    SQLDatabase.CloseConnection(conn);
                    return dt;
                }
            }
        }
        public bool themTour(string tenTour,float giaTour,int slVe,DateTime ngaydi,DateTime ngayve,string mota,int idNhanvien,float giaVe)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_ThemTour", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@TenTour", SqlDbType.NVarChar);
                par1.Value = tenTour;
                SqlParameter par2 = new SqlParameter("@GiaTour", SqlDbType.Float);
                par2.Value = giaTour;
                SqlParameter par3 = new SqlParameter("@SoLuong", SqlDbType.Int);
                par3.Value = slVe;
                SqlParameter par4 = new SqlParameter("@NgayDi", SqlDbType.Date);
                par4.Value = ngaydi.Date;
                SqlParameter par5 = new SqlParameter("@NgayVe", SqlDbType.Date);
                par5.Value = ngayve.Date;
                SqlParameter par6 = new SqlParameter("@idTrangThai", SqlDbType.Int);
                par6.Value = 1;
                SqlParameter par7 = new SqlParameter("@MoTa", SqlDbType.NVarChar);
                par7.Value = mota;
                SqlParameter par8 = new SqlParameter("@idNhanVien", SqlDbType.Int);
                par8.Value = idNhanvien;
                SqlParameter par9 = new SqlParameter("@giaVe", SqlDbType.Float);
                par9.Value = giaVe;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.Parameters.Add(par3);
                cmd.Parameters.Add(par4);
                cmd.Parameters.Add(par5);
                cmd.Parameters.Add(par6);
                cmd.Parameters.Add(par7);
                cmd.Parameters.Add(par8);
                cmd.Parameters.Add(par9);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public int layMaxIDTourNV(int idNhanvien)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT MAX(IDTour) FROM dbo.Tour WHERE IDNhanVien = " + idNhanvien, conn);
                return (int)cmd.ExecuteScalar();
            }
            catch { return -1; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool themTourDiaDanh(int idTour,int idDiaDanh)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_ThemTourDiaDanh", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@idTour", SqlDbType.Int);
                par1.Value = idTour;
                SqlParameter par2 = new SqlParameter("@idDiaDanh", SqlDbType.Int);
                par2.Value = idDiaDanh;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool themTourKhachSan(int idTour, int idKhachSan)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_ThemTourKhachSan", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@idTour", SqlDbType.Int);
                par1.Value = idTour;
                SqlParameter par2 = new SqlParameter("@idKhachSan", SqlDbType.Int);
                par2.Value = idKhachSan;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool themTourPhuongTien(int idTour, int idPhuongTien,int sl)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_ThemTourPT", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@idTour", SqlDbType.Int);
                par1.Value = idTour;
                SqlParameter par2 = new SqlParameter("@idPhuongTien", SqlDbType.Int);
                par2.Value = idPhuongTien;
                SqlParameter par3 = new SqlParameter("@SL", SqlDbType.Int);
                par3.Value = sl;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.Parameters.Add(par3);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool huyTour(int idTour)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("UPDATE dbo.Tour SET IdTrangThai = 5 WHERE IDTour = "+idTour, conn);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool capNhatTour(int idTour, string tenTour, float giaTour, int slVe, DateTime ngaydi, DateTime ngayve, string mota, int idNhanvien, float giaVe)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_CapNhatTour", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par0 = new SqlParameter("@idTour", SqlDbType.Int);
                par0.Value = idTour;
                SqlParameter par1 = new SqlParameter("@TenTour", SqlDbType.NVarChar);
                par1.Value = tenTour;
                SqlParameter par2 = new SqlParameter("@GiaTour", SqlDbType.Float);
                par2.Value = giaTour;
                SqlParameter par3 = new SqlParameter("@SoLuong", SqlDbType.Int);
                par3.Value = slVe;
                SqlParameter par4 = new SqlParameter("@NgayDi", SqlDbType.Date);
                par4.Value = ngaydi.Date;
                SqlParameter par5 = new SqlParameter("@NgayVe", SqlDbType.Date);
                par5.Value = ngayve.Date;
                SqlParameter par6 = new SqlParameter("@idTrangThai", SqlDbType.Int);
                par6.Value = 1;
                SqlParameter par7 = new SqlParameter("@MoTa", SqlDbType.NVarChar);
                par7.Value = mota;
                SqlParameter par8 = new SqlParameter("@idNhanVien", SqlDbType.Int);
                par8.Value = idNhanvien;
                SqlParameter par9 = new SqlParameter("@giaVe", SqlDbType.Float);
                par9.Value = giaVe;
                cmd.Parameters.Add(par0);
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.Parameters.Add(par3);
                cmd.Parameters.Add(par4);
                cmd.Parameters.Add(par5);
                cmd.Parameters.Add(par6);
                cmd.Parameters.Add(par7);
                cmd.Parameters.Add(par8);
                cmd.Parameters.Add(par9);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool ThemTourKH(int idTour,int idKH,string ghiChu)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_ThemTourYeuCau", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par0 = new SqlParameter("@idTour", SqlDbType.Int);
                par0.Value = idTour;
                SqlParameter par1 = new SqlParameter("@idKhachHang", SqlDbType.Int);
                par1.Value = idKH;
                SqlParameter par2 = new SqlParameter("@GhiChu", SqlDbType.NVarChar);
                par2.Value = ghiChu;
                cmd.Parameters.Add(par0);
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool capNhatTourKH(int idTour, int idKH, string ghiChu)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_CapNhatTourYC", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par0 = new SqlParameter("@idTour", SqlDbType.Int);
                par0.Value = idTour;
                SqlParameter par1 = new SqlParameter("@idKhachHang", SqlDbType.Int);
                par1.Value = idKH;
                SqlParameter par2 = new SqlParameter("@GhiChu", SqlDbType.NVarChar);
                par2.Value = ghiChu;
                cmd.Parameters.Add(par0);
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
        public bool capNhatTrangThaiTour(int idTour,int idTrangThai)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_SetTrangThaiTour", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par0 = new SqlParameter("@idTrangThai", SqlDbType.Int);
                par0.Value = idTrangThai;
                SqlParameter par1 = new SqlParameter("@idTour", SqlDbType.Int);
                par1.Value = idTour;
                cmd.Parameters.Add(par0);
                cmd.Parameters.Add(par1);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.CloseConnection(conn); }
        }
    }
}
