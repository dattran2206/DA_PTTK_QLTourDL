using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DTO;

namespace QL_TOURDL_2
{
    public partial class frmMain : Form
    {
        private Form activeForm;
        private int loaiTK;
        DTO_NguoiDung nguoiDung;
        public frmMain()
        {
            InitializeComponent();
        }
        public frmMain(int loaiTK,DTO_NguoiDung nguoiDung)
        {
            
            this.loaiTK = loaiTK;
            InitializeComponent();
            DisableTK();
            this.nguoiDung = nguoiDung;
            if (loaiTK == 1)
            {
                btnBanVe.Enabled = true;
                btnFrmThemMoiTour.Enabled = true;
                btnDSTour.Enabled = true;
                btnKhachHang.Enabled = true;
                btnDoanhThu.Enabled = true;
                btnDichVu.Enabled = true;
                btnFrmNhanVien.Enabled = true;
                btnMenuDSTour.Enabled = true;
                banVeToolStripMenuItem.Enabled = true;
                btnFrmKhachHang.Enabled = true;
                btnFrmDoanhThu.Enabled = true;
                btnQLDichVu.Enabled = true;
            }
            if (loaiTK == 2)
            {
                btnDSTour.Enabled = true;
            }
            if (loaiTK == 3)
            {
                btnFrmThemMoiTour.Enabled = true;
            }
            if (loaiTK == 4)
            {
                btnFrmThemMoiTour.Enabled = true;
                btnKhachHang.Enabled = true;
            }
        }
        public void DisableTK()
        {
            btnBanVe.Enabled = false;
            btnFrmThemMoiTour.Enabled = false;
            btnDSTour.Enabled = false;
            btnKhachHang.Enabled = false;
            btnDoanhThu.Enabled = false;
            btnDichVu.Enabled = false;
            btnFrmNhanVien.Enabled = false;
            btnMenuDSTour.Enabled = false;
            banVeToolStripMenuItem.Enabled = false;
            btnFrmKhachHang.Enabled = false;
            btnFrmDoanhThu.Enabled = false;
            btnQLDichVu.Enabled = false;
        }
        private void frmMain_Load(object sender, EventArgs e)
        {
            OpenChildForm(new frmTour());
            statusBottomBar.Panels[0].Text = "Xin chào "+nguoiDung.TenHienthi;
        }

        private void btnMenuDSTour_Click(object sender, EventArgs e)
        {
            OpenChildForm(new frmTour());
        }
        private void OpenChildForm(Form childForm)
        {
            if(activeForm != null)
            {
                activeForm.Close();
            }
            activeForm = childForm;
            activeForm.TopLevel = false;
            childForm.FormBorderStyle = FormBorderStyle.None;
            childForm.Dock = DockStyle.Fill;
            this.panel1.Controls.Add(childForm);
            childForm.BringToFront();
            childForm.Show();
        }

        private void btnFrmThemMoiTour_Click(object sender, EventArgs e)
        {
            OpenChildForm(new frmThemTour(nguoiDung));
        }

        private void btnKhachHang_Click(object sender, EventArgs e)
        {
            
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            statusBottomBar.Panels[1].Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm tt");
        }

        private void tOURToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void btnBanVe_Click(object sender, EventArgs e)
        {
            
        }

        private void banVeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }

        private void frmMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(MessageBox.Show("Bạn có chắc chắn muốn thoát?","Xác nhận",MessageBoxButtons.OKCancel,MessageBoxIcon.Question) != System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

        private void btnDSTour_Click(object sender, EventArgs e)
        {
            OpenChildForm(new frmTour());
        }

        private void btnDangXuat_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnDichVu_Click(object sender, EventArgs e)
        {
            
        }

        private void btnDoanhThu_Click(object sender, EventArgs e)
        {
           
        }

        private void btnFrmKhachHang_Click(object sender, EventArgs e)
        {
           
        }

        private void btnFrmTaiKhoan_Click(object sender, EventArgs e)
        {
            frmTaiKhoan frm = new frmTaiKhoan(nguoiDung);
            frm.Show();
        }

        private void btnFrmDoanhThu_Click(object sender, EventArgs e)
        {
            
        }

        private void btnFrmNhanVien_Click(object sender, EventArgs e)
        {
            
        }

        private void btnQLDichVu_Click(object sender, EventArgs e)
        {
            
        }

        private void statusBottomBar_PanelClick(object sender, StatusBarPanelClickEventArgs e)
        {

        }
    }
}
