using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class DAO_NhanVien
    {
        SqlConnection conn = new SqlConnection(SQLDatabase.ConnectionString);
        public DataTable loadTenNhanVien()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiTenNhanVien", conn);
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
        public DataTable loadChucVu()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiChucVu", conn);
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
        public DataTable loadDSNhanVien()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiDanhSachNV", conn);
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
        public bool themNhanVien(int idChucVu, string tenNV, string gioiTinh, DateTime ngaySinh, string sdt, string diaChi)
        {
            try
            {
                SQLDatabase.OpenConnection(conn);
                SqlCommand cmd = new SqlCommand("sp_ThemNhanVien", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@IDChucVu", SqlDbType.Int);
                par1.Value = idChucVu;
                SqlParameter par2 = new SqlParameter("@TenNhanVien", SqlDbType.NVarChar);
                par2.Value = tenNV;
                SqlParameter par3 = new SqlParameter("@GioiTinh", SqlDbType.NVarChar);
                par3.Value = gioiTinh;
                SqlParameter par4 = new SqlParameter("@NgaySinh", SqlDbType.DateTime);
                par4.Value = ngaySinh;
                SqlParameter par5 = new SqlParameter("@SoDienThoai", SqlDbType.Char);
                par5.Value = sdt;
                SqlParameter par6 = new SqlParameter("@DiaChi", SqlDbType.NVarChar);
                par6.Value = diaChi;
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.Parameters.Add(par3);
                cmd.Parameters.Add(par4);
                cmd.Parameters.Add(par5);
                cmd.Parameters.Add(par6);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.OpenConnection(conn); }
        }
        public bool capNhatNhanVien(int idNhanVien,int idChucVu, string tenNV, string gioiTinh, DateTime ngaySinh, string sdt, string diaChi)
        {
            try
            {
                SQLDatabase.OpenConnection(conn);
                SqlCommand cmd = new SqlCommand("sp_CapNhatNhanVien", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par0 = new SqlParameter("@IDNhanVien", SqlDbType.Int);
                par0.Value = idNhanVien;
                SqlParameter par1 = new SqlParameter("@IDChucVu", SqlDbType.Int);
                par1.Value = idChucVu;
                SqlParameter par2 = new SqlParameter("@TenNhanVien", SqlDbType.NVarChar);
                par2.Value = tenNV;
                SqlParameter par3 = new SqlParameter("@GioiTinh", SqlDbType.NVarChar);
                par3.Value = gioiTinh;
                SqlParameter par4 = new SqlParameter("@NgaySinh", SqlDbType.DateTime);
                par4.Value = ngaySinh;
                SqlParameter par5 = new SqlParameter("@SoDienThoai", SqlDbType.Char);
                par5.Value = sdt;
                SqlParameter par6 = new SqlParameter("@DiaChi", SqlDbType.NVarChar);
                par6.Value = diaChi;
                cmd.Parameters.Add(par0);
                cmd.Parameters.Add(par1);
                cmd.Parameters.Add(par2);
                cmd.Parameters.Add(par3);
                cmd.Parameters.Add(par4);
                cmd.Parameters.Add(par5);
                cmd.Parameters.Add(par6);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.OpenConnection(conn); }
        }
        public bool xoaNhanVien(int idNhanVien)
        {
            try
            {
                SQLDatabase.OpenConnection(conn);
                SqlCommand cmd = new SqlCommand("sp_CapNhatTinhTrangNV", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par0 = new SqlParameter("@IDNhanVien", SqlDbType.Int);
                par0.Value = idNhanVien;
                cmd.Parameters.Add(par0);
                cmd.ExecuteNonQuery();
                return true;
            }
            catch { return false; }
            finally { SQLDatabase.OpenConnection(conn); }
        }
    }
}
