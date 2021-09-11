using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class DAO_Ve
    {
        SqlConnection conn = new SqlConnection(SQLDatabase.ConnectionString);
        public DataTable loadLoaiVe()
        {
            SQLDatabase.OpenConnection(conn);
            SqlCommand cmd = new SqlCommand("sp_HienThiLoaiVe", conn);
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
        public bool nhapVe(int idTour,int idKhachHang,string tenVe,int idLoaiVe,int slVe,int idNhanVien)
        {
            SQLDatabase.OpenConnection(conn);
            try
            {
                SqlCommand cmd = new SqlCommand("sp_NhapVe", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter par1 = new SqlParameter("@idTour", SqlDbType.Int);
                par1.Value = idTour;
                SqlParameter par2 = new SqlParameter("@idKhachHang", SqlDbType.Int);
                par2.Value = idKhachHang;
                SqlParameter par3 = new SqlParameter("@TenVe", SqlDbType.NVarChar);
                par3.Value = tenVe;
                SqlParameter par4 = new SqlParameter("@idLoaiVe", SqlDbType.Int);
                par4.Value = idLoaiVe;
                SqlParameter par5 = new SqlParameter("@SLVe", SqlDbType.Int);
                par5.Value = slVe;
                SqlParameter par6 = new SqlParameter("@IDNhanVien", SqlDbType.Int);
                par6.Value = idNhanVien;
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
            finally { SQLDatabase.CloseConnection(conn); }
        }
    }
}
