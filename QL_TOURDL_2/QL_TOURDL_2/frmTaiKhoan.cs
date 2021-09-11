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
    public partial class frmTaiKhoan : Form
    {
        DTO_NguoiDung nguoiDung;
        public frmTaiKhoan(DTO_NguoiDung nguoiDung)
        {
            InitializeComponent();
            this.nguoiDung = nguoiDung;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            txtMatKhauCu.Enabled = true;
            txtMatKhau.Enabled = true;
            txtNhapLaiMatKhau.Enabled = true;
        }

        private void frmTaiKhoan_Load(object sender, EventArgs e)
        {
            txtTenHienThi.Text = nguoiDung.TenHienthi;
            txtTenDN.Text = nguoiDung.TenDangNhap;
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            DAO_NguoiDung dAO_NguoiDung = new DAO_NguoiDung();
            if (MessageBox.Show("Bạn có chắc chắn muốn cập nhật tài khoản", "Xác nhận", MessageBoxButtons.OKCancel,MessageBoxIcon.Question) == DialogResult.OK)
            {
                int kq = dAO_NguoiDung.sp_KiemTraDangNhap(txtTenDN.Text, txtMatKhauCu.Text);
                if (kq == 0)
                {
                    MessageBox.Show("Mật khẩu cũ không đúng", "Thông báo");
                    return;
                }
                if (txtMatKhau.Text.Equals(txtNhapLaiMatKhau.Text) == false)
                {
                    MessageBox.Show("Mật khẩu không trùng nhau", "Thông báo");
                    return;
                }
                else
                {
                    if(dAO_NguoiDung.capNhatTaiKhoan(txtTenDN.Text, txtNhapLaiMatKhau.Text))
                    {
                        MessageBox.Show("Cập nhật thành công", "Thông báo");
                    }
                    else
                    {
                        MessageBox.Show("Cập nhật không thành công", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Error);
                    }
                }
            }
        }
    }
}
