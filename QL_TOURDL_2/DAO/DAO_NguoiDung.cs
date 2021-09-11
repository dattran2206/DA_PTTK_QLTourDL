using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using DTO;
using System.Data.SqlClient;
namespace DAO
{
    public class DAO_NguoiDung
    {
        static SqlConnection conn = new SqlConnection(SQLDatabase.ConnectionString);
        public int sp_KiemTraDangNhap(string tenDangnhap, string matKhau)
        {
            try
            {
                int kq = 0;
                SQLDatabase.OpenConnection(conn);
                SqlCommand cmd = new SqlCommand("sp_KiemTraDangNhap", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@tenDangnhap", System.Data.SqlDbType.NVarChar);
                par1.Value = tenDangnhap;
                SqlParameter par2 = new SqlParameter("@Matkhau", System.Data.SqlDbType.NVarChar);
                par2.Value = matKhau;
                SqlParameter par3 = new SqlParameter("@Kq", System.Data.SqlDbType.Int);
                par3.Value = kq;
                par3.Direction = System.Data.ParameterDirection.Output;
                par3.Value = kq;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.Parameters.Add(par3);
                cmd.ExecuteNonQuery();
                return (int)par3.Value;
            }
            catch
            {

            }
            finally
            {
                SQLDatabase.CloseConnection(conn);
            }
            return -1;
        }
        public int kiemTraLoaiTaiKhoan(string tenDN)
        {
            int kq = 0;
            try
            {
                SQLDatabase.OpenConnection(conn);
                SqlCommand cmd = new SqlCommand("spKiemTraTaiKhoanId", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@tenDangnhap", SqlDbType.NVarChar);
                par1.Value = tenDN;
                SqlParameter par2 = new SqlParameter("@kq", conn);
                par2.Value = kq;
                par2.Direction = ParameterDirection.Output;
                par2.Value = kq;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.ExecuteNonQuery();
                return (int)par2.Value;
            }
            catch { }
            finally { SQLDatabase.CloseConnection(conn); }
            return 0;
        }
        public DTO_NguoiDung layNguoiDung(string userName,string pass)
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_LayNguoiDung", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter par1 = new SqlParameter("@userName", SqlDbType.NVarChar);
            par1.Value = userName;
            SqlParameter par2 = new SqlParameter("@passWord", SqlDbType.NVarChar);
            par2.Value = pass;
            cmd.Parameters.Add(par1);
            cmd.Parameters.Add(par2);
            DTO_NguoiDung nguoiDung = null;
            using (DataTable dt = new DataTable())
            {
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                    foreach(DataRow row in dt.Rows)
                    {
                        int idNguoidung = (int)row["IDNguoiDung"];
                        string tenNguoidung = row["TenNhanVien"].ToString();
                        string tenDangNhap = row["TenDangNhap"].ToString();
                        int idNhanVien = (int)row["IDNhanVien"];
                        nguoiDung = new DTO_NguoiDung(idNguoidung, tenNguoidung, tenDangNhap,idNhanVien);
                    }
                }
            }
            SQLDatabase.CloseConnection(conn);
            return nguoiDung;
        }
        public bool capNhatTaiKhoan(string userName, string Pass)
        {
            conn.Open();
            string sql = "UPDATE dbo.NguoiDung SET  MatKhau = N'" + Pass + "' WHERE TenDangNhap = N'" + userName + "'";
            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { conn.Close(); }
        }
        public DataTable loadKieuNguoiDung()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_LayKieuNguoiDung", conn);
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
        public bool themTaiKhoan(int kieuND, int idNhanvien, string tenDN, string matKhau)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("sp_ThemNguoiDung", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@IDKieuNguoiDung", SqlDbType.Int);
                par1.Value = kieuND;
                SqlParameter par5 = new SqlParameter("@IDNhanVien", SqlDbType.Int);
                par5.Value = idNhanvien;
                SqlParameter par3 = new SqlParameter("@TenDangNhap", SqlDbType.NVarChar);
                par3.Value = tenDN;
                SqlParameter par4 = new SqlParameter("@MatKhau", SqlDbType.NVarChar);
                par4.Value = matKhau;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par3);
                cmd.Parameters.Add(par4);
                cmd.Parameters.Add(par5);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch
            {
                return false;
            }
            finally { conn.Close(); }
        }
    }
}
