using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DAO;
using DTO;
namespace QL_TOURDL_2
{
    public partial class frmDangNhap : Form
    {
        public frmDangNhap()
        {
            InitializeComponent();
        }

        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            if (txtTenDN.Text == String.Empty)
            {
                lblValidate.Text = "Bạn phải nhập tên đăng nhập";
                return;
            }
            if (txtMatKhau.Text == String.Empty)
            {
                lblValidate.Text = "Bạn phải nhập mật khẩu";
                return;
            }
            try
            {
                string userName = "";
                string passWord = "";
                userName = txtTenDN.Text;
                passWord = txtMatKhau.Text;
                DAO_NguoiDung nguoiDung = new DAO_NguoiDung();
                int kqDN = nguoiDung.sp_KiemTraDangNhap(userName, passWord);
                if (kqDN == 1)
                {
                    int loaiTK = nguoiDung.kiemTraLoaiTaiKhoan(userName);
                    DTO_NguoiDung ND = nguoiDung.layNguoiDung(userName, passWord);
                    frmMain frm = new frmMain(loaiTK,ND);
                    if (ckbNhoMK.Checked == true)
                    {
                        Properties.Settings.Default.Username = userName;
                        Properties.Settings.Default.Password = passWord;
                        Properties.Settings.Default.Save();
                    }
                    if (ckbNhoMK.Checked == false)
                    {
                        Properties.Settings.Default.Username = "";
                        Properties.Settings.Default.Password = "";
                        Properties.Settings.Default.Save();
                    }
                    //this.Hide();
                    frm.Show();
                    
                }
                else

                {
                    MessageBox.Show("Tên đăng nhập hoặc mật khẩu sai!", "Thông báo");
                    txtTenDN.Focus();
                }

            }
            catch
            {
                MessageBox.Show("Đăng nhập không thành công!", "Thông báo");
            }
        }

        private void frmDangNhap_Load(object sender, EventArgs e)
        {
            if (Properties.Settings.Default.Username.Length > 0 && Properties.Settings.Default.Password.Length > 0)
            {
                txtTenDN.Text = Properties.Settings.Default.Username;
                txtMatKhau.Text = Properties.Settings.Default.Password;
            }
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            if (ckbNhoMK.Checked == false)
            {
                Properties.Settings.Default.Username = "";
                Properties.Settings.Default.Password = "";
                Properties.Settings.Default.Save();
            }
            Application.Exit();
        }

        private void txtTenDN_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode == Keys.Enter)
            {
                btnDangNhap.PerformClick();
            }
        }

        private void txtMatKhau_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btnDangNhap.PerformClick();
            }
        }
    }
}
