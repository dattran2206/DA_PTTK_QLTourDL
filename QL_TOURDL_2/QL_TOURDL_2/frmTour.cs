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
    public partial class frmTour : Form
    {
        DAO_NhanVien nhanVien;
        DAO_Tour tour;
        DAO_DichVu dichVu;
        public frmTour()
        {
            InitializeComponent();
            tour = new DAO_Tour();
            nhanVien = new DAO_NhanVien();
            dichVu = new DAO_DichVu();
        }

        private void frmTour_Load(object sender, EventArgs e)
        {
            loadTourTatCa();
            loadTrangThaiTour();
            loadTenNV();
        }
        public void loadTourTatCa()
        {
            DataTable dt = new DataTable();
            dt = tour.loadTourTatCaQuanTri();
            gridTour.DataSource = dt;
            gridTour.Columns[3].DefaultCellStyle.ForeColor = Color.Red;
            gridTour.Columns[7].DefaultCellStyle.ForeColor = Color.Red;
            DataBindingHT(dt);
        }
        public void loadTenNV()
        {
            DataTable dt = new DataTable();
            dt = nhanVien.loadTenNhanVien();
            cboNhanVien.DataSource = dt;
            cboNhanVien.ValueMember = "IDNhanVien";
            cboNhanVien.DisplayMember = "TenNhanVien";
        }
        public void loadTrangThaiTour()
        {
            DataTable dt = new DataTable();
            dt = tour.loadDSTrangThai();
            cboTrangThaiTour.DataSource = dt;
            cboXacNhanTTTour.DataSource = dt;
            cboXacNhanTTTour.ValueMember = "IDTrangThai";
            cboXacNhanTTTour.DisplayMember = "TenTrangThai";
            cboTrangThaiTour.ValueMember = "IDTrangThai";
            cboTrangThaiTour.DisplayMember = "TenTrangThai";
        }
        public void DataBindingHT(DataTable dt)
        {
            txtIDTourHT.DataBindings.Clear();
            Binding b1 = new Binding("Text", dt, "IDTour", true, DataSourceUpdateMode.Never);
            txtIDTourHT.DataBindings.Add(b1);

            txtTenTourHT.DataBindings.Clear();
            Binding b2 = new Binding("Text", dt, "TenTour", true, DataSourceUpdateMode.Never);
            txtTenTourHT.DataBindings.Add(b2);

            txtGiaTourHT.DataBindings.Clear();
            Binding b3 = new Binding("Text", dt, "GiaTour", true, DataSourceUpdateMode.Never);
            txtGiaTourHT.DataBindings.Add(b3);

            txtSLVeHT.DataBindings.Clear();
            Binding b4 = new Binding("Text", dt, "SoLuong", true, DataSourceUpdateMode.Never);
            txtSLVeHT.DataBindings.Add(b4);

            txtNgayDiHT.DataBindings.Clear();
            Binding b5 = new Binding("Text", dt, "NgayDi", true, DataSourceUpdateMode.Never);
            txtNgayDiHT.DataBindings.Add(b5);

            txtNgayVeHT.DataBindings.Clear();
            Binding b6 = new Binding("Text", dt, "NgayVe", true, DataSourceUpdateMode.Never);
            txtNgayVeHT.DataBindings.Add(b6);

            txtMoTaHT.DataBindings.Clear();
            Binding b7 = new Binding("Text", dt, "MoTa", true, DataSourceUpdateMode.Never);
            txtMoTaHT.DataBindings.Add(b7);

            txtDonGiaHT.DataBindings.Clear();
            Binding b8 = new Binding("Text", dt, "DonGiaVe", true, DataSourceUpdateMode.Never);
            txtDonGiaHT.DataBindings.Add(b8);

            txtTrangThai.DataBindings.Clear();
            Binding b9 = new Binding("Text", dt, "TenTrangThai", true, DataSourceUpdateMode.Never);
            txtTrangThai.DataBindings.Add(b9);
        }

        private void gridTour_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex == -1)
            {
                return;
            }
            if (gridTour.CurrentCell.Value.ToString().Length > 0)
            {
                lstDiaDanh.Rows.Clear();
                int idTour = int.Parse(txtIDTourHT.Text.ToString());
                DataTable dt1 = dichVu.loadTourDiaDanh(idTour);
                DataTable dt3 = dichVu.loadTourPhuongTien(idTour);
                DataTable dt2 = dichVu.loadTourKhachSan(idTour);
                foreach (DataRow row in dt1.Rows)
                {
                    var index = lstDiaDanh.Rows.Add();
                    lstDiaDanh.Rows[index].Cells["IDDD"].Value = row["IDDiaDanh"];
                    lstDiaDanh.Rows[index].Cells["TenDD"].Value = row["TenDiaDanh"];
                }
                lstKhachSan.Rows.Clear();
                foreach (DataRow row in dt2.Rows)
                {
                    var index = lstKhachSan.Rows.Add();
                    lstKhachSan.Rows[index].Cells["IDKS"].Value = row["IDKhachSan"];
                    lstKhachSan.Rows[index].Cells["TenKS"].Value = row["TenKhachSan"];
                }
                lstPhuongTien.Rows.Clear();
                foreach (DataRow rows in dt3.Rows)
                {
                    var index = lstPhuongTien.Rows.Add();
                    lstPhuongTien.Rows[index].Cells["IDPT"].Value = rows["IDPhuongTien"];
                    lstPhuongTien.Rows[index].Cells["TenPT"].Value = rows["TenPhuongTien"];
                    lstPhuongTien.Rows[index].Cells["SL"].Value = rows["SoLuong"];
                }
            }
        }

        private void btnLocTour_Click(object sender, EventArgs e)
        {
            DateTime ngayDi = txtTuNgay.Value;
            DateTime ngayVe = txtDenNgay.Value;
            locTourTheoNgay(ngayDi,ngayVe);
        }

        public void locTourTheoNgay(DateTime ngayDi, DateTime ngayVe)
        {
            DataTable dt = new DataTable();
            dt = tour.loadTourTheoNgay(ngayDi,ngayVe);
            gridTour.DataSource = dt;
            gridTour.Columns[3].DefaultCellStyle.ForeColor = Color.Red;
            gridTour.Columns[7].DefaultCellStyle.ForeColor = Color.Red;
            DataBindingHT(dt);
        }

        private void btnLoadTour_Click(object sender, EventArgs e)
        {
            loadTourTatCa();
        }

        private void btnLocTourTheoTT_Click(object sender, EventArgs e)
        {
            if (cboTrangThaiTour.SelectedValue == null)
            {
                MessageBox.Show("Bạn phải chọn trạng thái", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            int idTT = int.Parse(cboTrangThaiTour.SelectedValue.ToString());
            locTourTheoTT(idTT);
        }
        public void locTourTheoNV(int idNV)
        {
            DataTable dt = new DataTable();
            dt = tour.loadTourTheoNV(idNV);
            gridTour.DataSource = dt;
            gridTour.Columns[3].DefaultCellStyle.ForeColor = Color.Red;
            gridTour.Columns[7].DefaultCellStyle.ForeColor = Color.Red;
            DataBindingHT(dt);
        }
        public void locTourTheoTT(int idTT)
        {
            DataTable dt = new DataTable();
            dt = tour.loadTourTheoTT(idTT);
            gridTour.DataSource = dt;
            gridTour.Columns[3].DefaultCellStyle.ForeColor = Color.Red;
            gridTour.Columns[7].DefaultCellStyle.ForeColor = Color.Red;
            DataBindingHT(dt);
        }

        public void locTourTheoTen(string tenTour)
        {
            DataTable dt = new DataTable();
            dt = tour.timKiemTourTheoQuanTri(tenTour);
            gridTour.DataSource = dt;
            gridTour.Columns[3].DefaultCellStyle.ForeColor = Color.Red;
            gridTour.Columns[7].DefaultCellStyle.ForeColor = Color.Red;
            DataBindingHT(dt);
        }

        private void btnLocTourTheoNV_Click(object sender, EventArgs e)
        {
            if (cboNhanVien.SelectedValue == null)
            {
                MessageBox.Show("Bạn phải chọn nhân viên", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            int idNV = int.Parse(cboNhanVien.SelectedValue.ToString());
            locTourTheoNV(idNV);
        }

        private void btnCapNhatTT_Click(object sender, EventArgs e)
        {
            if (cboXacNhanTTTour.SelectedValue == null)
            {
                MessageBox.Show("Bạn phải chọn trạng thái", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (txtIDTourHT.Text.Length == 0)
            {
                MessageBox.Show("Bạn phải chọn trạng tour muốn cập nhật", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            int idTT = int.Parse(cboXacNhanTTTour.SelectedValue.ToString());
            int idTour = int.Parse(txtIDTourHT.Text.ToString());
            if (MessageBox.Show("Bạn có chắc chắn muốn cập nhật trạng thái cho tour?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if(tour.capNhatTrangThaiTour(idTour,idTT))
                {
                    MessageBox.Show("Cập nhật thành công");
                    loadTourTatCa();
                }
                else
                {
                    MessageBox.Show("Cập nhật không thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void btnTimKiemTourTheoTen_Click(object sender, EventArgs e)
        {
            string tenTour = txtTKTourTheoTen.Text.ToString();
            locTourTheoTen(tenTour);
        }

        private void txtTKTourTheoTen_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btnTimKiemTourTheoTen.PerformClick();
            }
        }
    }
}
