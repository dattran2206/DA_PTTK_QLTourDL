CREATE DATABASE QL_TourDuLich
GO
USE QL_TourDuLich
GO

CREATE TABLE ChucVu
(
	IDChucVu INT IDENTITY(1,1) PRIMARY KEY,
	TenChucVu NVARCHAR(100)
)
GO

CREATE TABLE NhanVien
(
	IDNhanVien INT IDENTITY(1,1) PRIMARY KEY,
	IDChucVu INT,
	TenNhanVien NVARCHAR(100),
	GioiTinh NVARCHAR(5),
	NgaySinh DATETIME,
	SoDienThoai CHAR(20),
	DiaChi NVARCHAR(100),
	TinhTrang CHAR(5) --true là còn làm false là không
)
GO
CREATE TABLE KieuNguoiDung
(
	IDKieuNguoiDung INT IDENTITY(1,1) PRIMARY KEY,
	TenKieuNguoiDung NVARCHAR(100)
)
GO

CREATE TABLE NguoiDung
(
	IDNguoiDung INT IDENTITY(1,1) PRIMARY KEY,
	IDKieuNguoiDung INT,
	TenDangNhap NVARCHAR(200),
	MatKhau NVARCHAR(200),
	IDNhanVien INT UNIQUE,
	TinhTrang CHAR(5) --true là còn hoạt động false là không
)
GO

CREATE TABLE TrangThai
(
	IDTrangThai INT PRIMARY KEY,
	TenTrangThai NVARCHAR(100)
)
GO

CREATE TABLE Tour
(
	IDTour INT IDENTITY(1,1) PRIMARY KEY,
	TenTour NVARCHAR(200),
	GiaTour FLOAT,
	SoLuong INT,
	NgayDi DATE,
	NgayVe DATE,
	IdTrangThai INT,
	MoTa NVARCHAR(MAX),
	IDNhanVien INT, -- Nhân viên lập tour
	DonGiaVe FLOAT -- Đơn giá cho mỗi vé
)
GO

CREATE TABLE KhachHang
(
	IDKhachHang INT IDENTITY(1,1) PRIMARY KEY,
	TenKhachHang NVARCHAR(200),
	SoDienThoai CHAR(20),
	DiaChi NVARCHAR(100),
	GioiTinh NVARCHAR(5),
	SoCanCuoc CHAR(20),
	NgaySinh DATE,
	NgayThem DATE
)
GO

CREATE TABLE TourYeuCau
(
	IDTuorYeuCau INT IDENTITY(1,1) PRIMARY KEY,
	IDTour INT,
	IDKhachHang INT,
	GhiChu NVARCHAR(MAX)
)
GO

CREATE TABLE LoaiVe
(
	IDLoaiVe INT IDENTITY(1,1) PRIMARY KEY,
	TenLoaiVe NVARCHAR(20)
)
GO

CREATE TABLE Ve
(
	IDVe INT IDENTITY(1,1) PRIMARY KEY,
	IDTour INT,
	IDKhachHang INT,
	TenVe NVARCHAR(100),
	GiaVe FLOAT,
	IDLoaiVe INT,
	IDNhanVien INT, --Nhân viên bán vé
	NgayXuat DATE
)
GO

CREATE TABLE PhuongTien
(
	IDPhuongTien INT IDENTITY(1,1) PRIMARY KEY,
	TenPhuongTien NVARCHAR(100),
	SoCho INT
)
GO

CREATE TABLE Tour_PhuongTien
(
	IDChiTietPT INT IDENTITY(1,1) PRIMARY KEY,
	IDTuor INT,
	IDPhuongTien INT,
	SoLuong INT
)
GO

CREATE TABLE KhachSan
(
	IDKhachSan INT IDENTITY(1,1) PRIMARY KEY,
	TenKhachSan NVARCHAR(100),
	DiaChi NVARCHAR(100)
)
GO

CREATE TABLE Tour_KhachSan
(
	IDChiTietKhachSan INT IDENTITY(1,1) PRIMARY KEY,
	IDTour INT,
	IDKhachSan INT
)
GO

CREATE TABLE DiaDanh
(
	IDDiaDanh INT IDENTITY(1,1) PRIMARY KEY,
	TenDiaDanh NVARCHAR(100),
	DiaChi NVARCHAR(100)
)
GO

CREATE TABLE Tour_DiaDanh
(
	IDChiTietDiaDanh INT IDENTITY(1,1) PRIMARY KEY,
	IDTour INT,
	IDDiaDanh INT
)
GO
CREATE TABLE NhaCungCap
(
	IDNhaCungCap INT IDENTITY(1,1) PRIMARY KEY,
	TenNhaCungCap NVARCHAR(200),
	DiaChi NVARCHAR(200),
	SoDienThoai CHAR(20),
	Email NVARCHAR(100)
)
GO
CREATE TABLE CongNo
(
	IDCongNo INT IDENTITY(1,1) PRIMARY KEY,
	IDTour INT,
	IDNhaCungCap INT,
	IDNhanVien INT,
	TenCongNo NVARCHAR(200),
	NgayTao DATE,
	HanThanhToan DATE,
	SoTien MONEY,
	TrinhTrang CHAR(20) -- DaThanhToan / ChuaThanhToan
)
GO
-----------------------------------Kết nối khóa ngoại cho các bảng-----------------------------------
ALTER TABLE dbo.NhanVien
ADD FOREIGN KEY(IDChucVu) REFERENCES dbo.ChucVu(IDChucVu)
GO

ALTER TABLE dbo.NguoiDung
ADD FOREIGN KEY (IDNhanVien) REFERENCES dbo.NhanVien(IDNhanVien),
FOREIGN KEY(IDKieuNguoiDung) REFERENCES dbo.KieuNguoiDung(IDKieuNguoiDung)
GO

ALTER TABLE dbo.Tour
ADD FOREIGN KEY(IDNhanVien) REFERENCES dbo.NhanVien(IDNhanVien)
GO

ALTER TABLE dbo.Ve
ADD FOREIGN KEY(IDTour) REFERENCES dbo.Tour(IDTour),
FOREIGN KEY(IDLoaiVe) REFERENCES dbo.LoaiVe(IDLoaiVe),
FOREIGN KEY(IDKhachHang) REFERENCES dbo.KhachHang(IDKhachHang),
FOREIGN KEY(IDNhanVien) REFERENCES dbo.NhanVien(IDNhanVien)
GO

ALTER TABLE dbo.Tour_PhuongTien
ADD FOREIGN KEY(IDTuor) REFERENCES dbo.Tour(IDTour),
FOREIGN KEY(IDPhuongTien) REFERENCES dbo.PhuongTien(IDPhuongTien)
GO

ALTER TABLE dbo.Tour_DiaDanh
ADD FOREIGN KEY(IDTour) REFERENCES dbo.Tour(IDTour),
FOREIGN KEY(IDDiaDanh) REFERENCES dbo.DiaDanh(IDDiaDanh)
GO

ALTER TABLE dbo.Tour_KhachSan
ADD FOREIGN KEY(IDTour) REFERENCES dbo.Tour(IDTour),
FOREIGN KEY(IDKhachSan) REFERENCES dbo.KhachSan(IDKhachSan)
GO

ALTER TABLE dbo.TourYeuCau
ADD FOREIGN KEY(IDTour) REFERENCES dbo.Tour(IDTour),
FOREIGN KEY (IDKhachHang) REFERENCES dbo.KhachHang(IDKhachHang)
GO

ALTER TABLE dbo.Tour
ADD FOREIGN KEY(IDNhanVien) REFERENCES dbo.NhanVien(IDNhanVien),
FOREIGN KEY(IDTrangThai) REFERENCES dbo.TrangThai(IDTrangThai)
GO

ALTER TABLE dbo.CongNo
ADD FOREIGN KEY(IDTour) REFERENCES dbo.Tour(IDTour),
FOREIGN KEY(IDNhaCungCap) REFERENCES dbo.NhaCungCap(IDNhaCungCap),
FOREIGN KEY(IDNhanVien) REFERENCES dbo.NhanVien(IDNhanVien)
-----------------------------------Thêm dữ liệu cho các bảng-----------------------------------
INSERT INTO ChucVu VALUES
(N'Quản trị Tour'), 
(N'Quản trị Hệ Thống'),
(N'Nhân viên Bán vé'),
(N'Nhân viên Tư vấn Khách hàng'),
(N'Hướng dẫn viên Du lịch'),
(N'Nhân viên Hổ trợ HDV Du lịch')
GO

Set DATEFORMAT DMY
INSERT INTO NhanVien VALUES
(1, N'Nguyễn Thế Ngọc', N'Nam', '23/09/2000', '0338016618', N'Hà Nội', 'TRUE' ),
(2, N'Trần Thị Anh Đào', N'Nữ', '12/04/1997', '0123222333', N'TP.HCM', 'TRUE' ),
(4, N'Lê Thị Thanh Hằng', N'Nữ', '25/03/1998', '0123333444', N'Tây Ninh', 'TRUE'),
(4, N'Nguyễn Thị Thu Tuyết', N'Nữ', '19/08/1996', '0123444555', N'Đồng Nai', 'TRUE'),
(3, N'Trần Minh Tuấn', N'Nam', '10/12/1989', '0123555666', N'Tiền Giang', 'TRUE'),
(5, N'Lưu Chính Hào', N'Nam', '30/04/1994', '0123666777', N'Long An', 'TRUE'),
(6, N'Nguyễn Văn Thảo', N'Nam', '02/09/1990', '0123777888', N'Hà Giang', 'TRUE'),
(5, N'Doãn Chí Bình', N'Nam', '15/12/1995', '0123888999', N'Quảng Nam', 'TRUE'),
(6, N'Dương Văn Quá', N'Nam', '20/11/1998', '0123999000', N'Bến Tre', 'TRUE')
GO
INSERT INTO KieuNguoiDung VALUES
(N'Quản lý'),
(N'Quản trị tour'),
(N'Quản trị hệ thống'),
(N'Bán vé'),
(N'Hướng dẫn viên'),
(N'Tư vấn')
GO

INSERT INTO NguoiDung VALUES
(1, 'ngoc123', '123456', 1, 'TRUE'),
(2, 'thungan', '123456', 2, 'TRUE'),
(3, 'banve', '123456', 3, 'TRUE'),
(4, 'hdv', '123456', 4, 'TRUE')
GO

INSERT INTO TrangThai VALUES
(1,N'Lên kế hoạch'), --1
(2,N'Chuẩn bị tiến hành'),--2
(3,N'Đang tiến hành'), --3
(4,N'Đã kết thúc'), --4
(5,N'Bị hủy')--5
GO

SET DATEFORMAT DMY
INSERT INTO Tour VALUES
(N'Hạ Long - 3 ngày 2 đêm', 24000000,20 , '30/05/2021', '02/06/2021', 1, N'Đến với Tour Hạ Long - 3 ngày 2 đêm bạn sẽ có 1 trải nghiệm tuyệt vời cùng với Gió biển mặn mà và nắng cháy đen da', 1, 1200000),
(N'Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm', 27000000 , 30 , '30/05/2021', '01/06/2021',1, N'Đến với Tour Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm bạn sẽ có 1 trải nghiệm tuyệt vời với việc đi bộ rã rời đôi chân và chui hang', 1, 900000),
(N'Vường Quốc Gia Cúc Phương - Tràng An 3 ngày 2 đêm',28000000 , 35, '20/05/2021', '22/05/2021',1, N'Đến với Tour Vường Quốc Gia Cúc Phương - Tràng An 3 ngày 2 đêm bạn sẽ có 1 trải nghiệm tuyệt vời với việc đi bộ trogn rừng một ngày với khỉ và chim rừng, sau đó sẽ đến Tràng An Nghỉ ngơi và tận hượng', 1, 800000),
(N'Vũng Tàu - Côn Đảo 3 ngày 3 đêm', 15000000,25 , '12/05/2021', '15/05/2021', 3, N'Đến với Tour Vũng Tàu - Côn Đảo 3 ngày 3 đêm bạn sẽ có 1 trải nghiệm tuyệt vời với tắm biển và ra Đảo chơi với khỉ', 1, 600000),
(N'Đà Lạt 2 ngày 1 đêm', 48000000, 40, '30/05/2021', '01/06/2021', 1, N'Đến với Tour Đà Lạt 2 ngày 1 đêm bạn sẽ có 1 trải nghiệm tuyệt vời với  không khí hơi lành lạnh giống như ở Paris mà người ta hay nói', 1, 1200000),
(N'Đà Lạt 3 ngày 2 đêm', 36000000, 40, '30/05/2021', '03/06/2021', 1, N'Đến với Tour Đà Lạt 3 ngày 2 đêm bạn sẽ có 1 trải nghiệm tuyệt vời với  không khí hơi lành lạnh giống như ở Paris mà người ta hay nói', 1, 900000),
(N'Đà Lạt 4 ngày 3 đêm', 52000000, 40, '30/05/2021', '05/06/2021', 1, N'Đến với Tour Đà Lạt 4 ngày 3 đêm bạn sẽ có 1 trải nghiệm tuyệt vời với  không khí hơi lành lạnh giống như ở Paris mà người ta hay nói', 1, 1300000),
(N'Sa Pa 5 ngày 5 đêm', 47500000, 25, '30/05/2021', '04/06/2021', 1, N'Đến với Tour Sa Pa 5 ngày 5 đêm bạn sẽ có 1 trải nghiệm tuyệt vời với Sa Pa', 1, 1900000),
(N'Sa Pa 7 ngày 7 đêm', 75000000, 30, '30/05/2021', '02/06/2021', 1, N'Đến với Tour Sa Pa 7 ngày 7 đêm bạn sẽ có 1 trải nghiệm tuyệt vời hơn với Sa Pa 5 ngày 5 đêm ', 1, 2500000),
(N'Địa đạo Củ Chi', 6000000, 20, '20/05/2021', '22/05/2021', 1, N'Đến với Tour Địa đạo Củ Chi bạn sẽ có 1 trải nghiệm tuyệt vời với hệ thống giao thông hào thời chiến tranh còn lưu lại ', 1, 300000),
(N'Địa đạo Củ Chi', 8000000, 20, '20/05/2021', '22/05/2021', 1, N'Đến với Tour Địa đạo Củ Chi bạn sẽ có 1 trải nghiệm tuyệt vời với hệ thống giao thông hào thời chiến tranh còn lưu lại ', 1, 400000),
(N'Địa đạo Củ Chi', 1000000, 20, '20/05/2021', '22/05/2021', 1, N'Đến với Tour Địa đạo Củ Chi bạn sẽ có 1 trải nghiệm tuyệt vời với hệ thống giao thông hào thời chiến tranh còn lưu lại ', 1, 500000),
(N'Địa đạo Củ Chi', 6000000, 20, '20/05/2021', '22/05/2021', 1, N'Đến với Tour Địa đạo Củ Chi bạn sẽ có 1 trải nghiệm tuyệt vời với hệ thống giao thông hào thời chiến tranh còn lưu lại ', 1, 300000),
(N'Địa đạo Củ Chi', 6000000, 20, '20/05/2021', '22/05/2021', 1, N'Đến với Tour Địa đạo Củ Chi bạn sẽ có 1 trải nghiệm tuyệt vời với hệ thống giao thông hào thời chiến tranh còn lưu lại ', 1, 300000),
(N'Địa đạo Củ Chi', 4000000, 20, '20/05/2021', '22/05/2021',1, N'Đến với Tour Địa đạo Củ Chi bạn sẽ có 1 trải nghiệm tuyệt vời với hệ thống giao thông hào thời chiến tranh còn lưu lại ', 1, 200000)
GO
SET DATEFORMAT DMY
INSERT INTO KhachHang VALUES
(N'Nguyễn Thế Ngọc', '0856111222', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM',N'Nam', '062300001122','23/09/2000',GETDATE()),
(N'Lưu Văn Hoàng', '0856333444', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300002233','23/08/2000',GETDATE()),
(N'Trần Văn Ngoan', '0856555666', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam',  '062300003344','23/04/2000',GETDATE()),
(N'Ngô Khiêm', '0856777888' , N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300004455','22/09/2000',GETDATE()),
(N'Nguyễn Thị Mỹ Hạnh', '0856999000', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nữ', '072400015566','23/07/2000',GETDATE()),
(N'Phạm Nguyễn Ngọc Hoài', '0856111333', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nữ', '072409016677','13/09/2000',GETDATE()),
(N'Nguyễn Công Tấn', '0856555777', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300007788','14/02/2000',GETDATE()),
(N'Trần Minh Nhân', '0856999222', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300008899','15/05/2000',GETDATE()),
(N'Nguyễn Cửu Trí', '0856222444', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300009900','22/09/2000',GETDATE()),
(N'Nguyễn Thị Minh Khai', '0856666888', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nữ', '072400010011','23/06/2000',GETDATE()),
(N'Lê Thanh Lâm', '0856222333', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300001133','24/07/2000',GETDATE()),
(N'Lê Hiền Nhân', '0856444555', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300003355','30/04/2000',GETDATE()),
(N'Nguyễn Thành Nhân', '0856666777', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300005577','23/05/2000',GETDATE()),
(N'Ngô Hoàng Thiên Tuệ', '0856888999', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300007799','26/06/2000',GETDATE()),
(N'Lý Hoàng Phi Dũng', '0856123123', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300009922','23/11/2000',GETDATE()),
(N'Trần Văn Hai', '0856456456', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300002244','23/02/2000',GETDATE()),
(N'Lê Văn Ba', '0856789789', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nam', '062300004466','10/10/2000',GETDATE()),
(N'Trần Thị Kiều Diễm', '0856000111', N'140 Lê Trọng Tấn, P.Tây Thạnh, Q.Tân Phú, TP.HCM', N'Nữ', '072400016688','11/11/2000',GETDATE())
GO

INSERT INTO TourYeuCau VALUES
(3, 1,NULL),
(5, 2,NULL),
(6, 3,NULL),
(7, 4,NULL),
(9, 5,NULL),
(11, 6,NULL),
(12, 7,NULL)
GO

INSERT INTO LoaiVe VALUES
(N'Vé người lớn (>6)'), 
(N'Vé trẻ em (<=6)')
GO

--INSERT INTO Ve VALUES
--( 1, 1, N'Vé Người lớn Hạ Long 3 ngày 2 đêm', null, 1, 3),
--( 1, 2, N'Vé Người lớn Hạ Long 3 ngày 2 đêm', null, 1, 3),
--( 1, 3, N'Vé Trẻ em Hạ Long 3 ngày 2 đêm', null, 2, 3),
--( 1, 4, N'Vé Trẻ em Hạ Long 3 ngày 2 đêm', null, 2, 4),
--( 1, 5, N'Vé Người lớn Hạ Long 3 ngày 2 đêm', null, 1, 3),
--( 1, 6, N'Vé Người lớn Hạ Long 3 ngày 2 đêm', null, 1, 3),
--( 2, 7, N'Vé Trẻ em Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm', null, 2, 4),
--( 2, 8, N'Vé Người lớn Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm', null, 1, 3),
--( 2, 9, N'Vé Người lớn Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm', null, 2, 3),
--( 2, 10, N'Vé Người lớn Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm', null, 1, 3),
--( 2, 11, N'Vé Người lớn Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm', null, 1, 4),
--( 2, 12, N'Vé Trẻ em Động Phong Nha - Kẻ Bàng - Hang Sơn Đoòng 2 ngày 1 đêm', null, 2, 4),
--( 3, 13, N'Vé người lớn Vườn Quốc Gia Cúc Phương - Tràng An 3 ngày 2 đêm', null, 1, 3),
--( 3, 14, N'Vé Trẻ em Vườn Quốc Gia Cúc Phương - Tràng An 3 ngày 2 đêm', null, 2, 4),
--( 3, 15, N'Vé Trẻ em Vườn Quốc Gia Cúc Phương - Tràng An 3 ngày 2 đêm', null, 2, 4),
--( 3, 16, N'Vé người lớn Vườn Quốc Gia Cúc Phương - Tràng An 3 ngày 2 đêm', null, 1, 3),
--( 3, 17, N'Vé người lớn Vườn Quốc Gia Cúc Phương - Tràng An 3 ngày 2 đêm', null, 1, 3),
--( 4, 1, N'Vé Người lớn Địa đạo Củ Chi', null, 1, 4),
--( 4, 2, N'Vé Người lớn Địa đạo Củ Chi', null, 1, 4),
--( 4, 3, N'Vé Người lớn Địa đạo Củ Chi', null, 1, 4),
--( 4, 4, N'Vé Người lớn Địa đạo Củ Chi', null, 1, 4),
--( 4, 5, N'Vé Người lớn Địa đạo Củ Chi', null, 1, 4),
--( 4, 6, N'Vé Trẻ em Địa đạo Củ Chi', null, 2, 4),
--( 4, 7, N'Vé Trẻ em Địa đạo Củ Chi', null, 2, 4)
GO
INSERT INTO dbo.NhaCungCap
        ( TenNhaCungCap ,
          DiaChi ,
          SoDienThoai ,
          Email
        )
VALUES  ( N'Nolis Hotel' , -- TenNhaCungCap - nvarchar(200)
          N'Bà Rịa Vũng Tàu' , -- DiaChi - nvarchar(100)
          '0338016614' , -- SoDienThoai - char(20)
          N'nolis999@gmail.com'  -- Email - nvarchar(100)
        ),
		(N'Cen Hotel', N'Bà Rịa Vũng Tàu','0338019112','cenhotel@gamil.com'),
		(N'Sun Beach Hotel', N'Bà Rịa Vũng Tàu','0338019112','cenhotel@gamil.com'),--3
		(N'SeaSala Hotel', N'Bà Rịa Vũng Tàu','03380222112','SeaSala@gamil.com'),--4
		(N'Marine Hotel &  Apartment', N'Bà Rịa Vũng Tàu','0338019112','Marine@gamil.com'),--5
		(N'Marine Thuỳ Hương', N'Tây Ninh','0338019112','Marine@gamil.com'),--6
		(N'Tan My Thien Hotel', N'Tây Ninh','0338019112','tanmythien@gamil.com'),--7
		(N'Mountain View Homestay Tay Ninh', N'Tay Ninh','0338019112','cenhotel@gamil.com'),--8
		(N'Vinpearl Hotel Quang Binh', N'Quảng Bình','0338019112','cenhotel@gamil.com'),--9
		(N'Song Châu Villa', N'Quảng Ninh','0338019112','cenhotel@gamil.com'),--10
		(N'Starlight Boutique Hotel', N'Quảng Ninh','0338019112','cenhotel@gamil.com'),--11
		(N'The Oriental Jade Hotel', N'Hà Nội','0338019112','cenhotel@gamil.com'),--12
		(N'Peridot Grand Hotel & Spa by AIRA', N'Hà Nội','0338019112','cenhotel@gamil.com'),--13
		(N'Acoustic Hotel & Spa', N'Hà Nội','0338019112','cenhotel@gamil.com'),--14
		(N'Little Riverside Hoi An . A Luxury Hotel & Spa', N'Quảng Nam','0338019112','cenhotel@gamil.com'),--15
		(N'Allegro Hoi An . A Little Luxury Hotel & Spa', N'Quảng Nam','0338019112','cenhotel@gamil.com'),--16
		(N'Les Hameaux de l`Orient', N'H.Củ Chi - TP.HCM','0338019112','cenhotel@gamil.com'),--17
		(N'Muong Thanh Grand Lao Cai Hotel', N'Lào Cai','0338019112','cenhotel@gamil.com'),--18
		(N'SOL by Meliá Phu Quoc', N'Đảo Phú Quốc - Kiên Giang','0338019112','cenhotel@gamil.com'),--19
		(N'Movenpick Resort Waverly Phu Quoc', N'Đảo Phú Quốc - Kiên Giang','0338019112','cenhotel@gamil.com'),--20
		(N'Max Boutique Hotel', N'Cao Bằng','0338019112','cenhotel@gamil.com'),--21
		(N'HIGHLANDS HOTEL CAO BANG', N'Cao Bằng','0338019112','cenhotel@gamil.com'),--22
		(N'Terracotta Hotel & Resort Dalat', N'Lâm Đồng','0338019112','cenhotel@gamil.com'),--23
		(N'Dalat Wonder Resort', N'Lâm Đồng','0338019112','cenhotel@gamil.com'),--24
		(N'Ana Villas Dalat Resort & Spa', N'Lâm Đồng','0338019112','cenhotel@gamil.com'),--25
		(N'Cuc Phuong Bungalow', N'Ninh Bình','0338019112','cenhotel@gamil.com'),--26
		(N'CÔNG TY TNHH THƯƠNG MẠI DU LỊCH PHI LOAN','145/4 Đường Nguyễn Đình Chính, Phường 11, Quận Phú Nhuận, TP. Hồ Chí Minh (TPHCM)','0903163615','phanquochung15@gmail.com'),
		(N'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ VẬN TẢI ĐẠI NGHĨA','Số 181/21 Nghĩa Phát, Phường 6, Q. Tân Bình, TP. Hồ Chí Minh (TPHCM)','0908847405','  dainghia65@yahoo.com.vn'),
		(N'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ DU LỊCH VIỆT TÍN','204E Sư Vạn Hạnh, Phường 9, Quận 5, Tp. Hồ Chí Minh (TPHCM)','0908223757',' info@viettintravel.com.vn'),
		(N'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ SUKAMI VN','Số 4, Đường Số 22, CV Phần Mềm Quang Trung, P. Tân Chánh Hiệp, Quận 12, Tp. Hồ Chí Minh (TPHCM)','0903984604','tramdulichkimdung@gmail.com'),
		(N'CÔNG TY TNHH DU LỊCH ĐẠI THẾ GIỚI','471 Minh Phụng, Phường 10, Quận 11, Tp. Hồ Chí Minh (TPHCM)',' 0903998111','  daithegioitour@gmail.com'),
		(N'CÔNG TY TNHH THƯƠNG MẠI DỊCH VỤ DU LỊCH THIÊN ĐĂNG','151 Đề Thám, Phường Cô Giang, Quận 1, Tp. Hồ Chí Minh (TPHCM)','0909501401','vmbthiendang@gmail.com')

GO
INSERT INTO PhuongTien VALUES
(N'Xe oto con 4 chổ', 4),
(N'Xe oto con 7 chổ', 7),
(N'Xe Khách nhỏ', 15),
(N'Xe Khách vừa', 24),
(N'Xe Khách lớn', 48),
(N'xe giường nằm', 38),
(N'Tàu Hỏa', null),
(N'Máy bay', null)
GO

INSERT INTO Tour_PhuongTien VALUES
(1, 8, 4),--CẬP NHẬT SỐ LƯỢNG KHI BIẾT SỐ LƯỢNG KHÁCH
(2, 2,2 ),
(2, 3, 2),
(3, 3, 2)
GO

INSERT INTO KhachSan VALUES
(N'Nolis Hotel', N'Bà Rịa Vũng Tàu'), --1
(N'Cen Hotel', N'Bà Rịa Vũng Tàu'), --2
(N'Sun Beach Hotel', N'Bà Rịa Vũng Tàu'),--3
(N'SeaSala Hotel', N'Bà Rịa Vũng Tàu'),--4
(N'Marine Hotel &  Apartment', N'Bà Rịa Vũng Tàu'),--5
(N'Motel Thuỳ Hương', N'Tây Ninh'),--6
(N'Tan My Thien Hotel', N'Tây Ninh'),--7
(N'Mountain View Homestay Tay Ninh', N'Tay Ninh'),--8
(N'Vinpearl Hotel Quang Binh', N'Quảng Bình'),--9
(N'Song Châu Villa', N'Quảng Ninh'),--10
(N'Starlight Boutique Hotel', N'Quảng Ninh'),--11
(N'The Oriental Jade Hotel', N'Hà Nội'),--12
(N'Peridot Grand Hotel & Spa by AIRA', N'Hà Nội'),--13
(N'Acoustic Hotel & Spa', N'Hà Nội'),--14
(N'Little Riverside Hoi An . A Luxury Hotel & Spa', N'Quảng Nam'),--15
(N'Allegro Hoi An . A Little Luxury Hotel & Spa', N'Quảng Nam'),--16
(N'Les Hameaux de l`Orient', N'H.Củ Chi - TP.HCM'),--17
(N'Muong Thanh Grand Lao Cai Hotel', N'Lào Cai'),--18
(N'SOL by Meliá Phu Quoc', N'Đảo Phú Quốc - Kiên Giang'),--19
(N'Movenpick Resort Waverly Phu Quoc', N'Đảo Phú Quốc - Kiên Giang'),--20
(N'Max Boutique Hotel', N'Cao Bằng'),--21
(N'HIGHLANDS HOTEL CAO BANG', N'Cao Bằng'),--22
(N'Terracotta Hotel & Resort Dalat', N'Lâm Đồng'),--23
(N'Dalat Wonder Resort', N'Lâm Đồng'),--24
(N'Ana Villas Dalat Resort & Spa', N'Lâm Đồng'),--25
(N'Cuc Phuong Bungalow', N'Ninh Bình')--26
GO

INSERT INTO Tour_KhachSan VALUES
(1, 11),
(1, 10),
(2, 9),
(3, 26),
(4, 3),
(4, 4),
(4, 5),
(5, 23),
(5, 24),
(5, 25),
(6, 23),
(6, 24),
(6, 25),
(7, 23),
(7, 24),
(7, 25),
(8, 18),
(9, 18),
(10, null),
(11, null),
(12, null),
(13, null),
(14, null),
(15, null) 
GO

INSERT INTO DiaDanh VALUES
(N'Vịnh Hạ Long', N'Quảng Ninh'),
(N'Vường Quốc gia Phong Nha - Kẻ Bàng', N'Quảng Bình'),
(N'Hang Sơn Đoòng', N'Quảng Bình'),
(N'Chùa Một Cột', N'Hà Nội'),
(N'Phố Cổ Hội An', N'Quảng Nam'),
(N'Địa đạo Củ Chi', N'H.Củ Chi - TP.HCM'),
(N'Sa-Pa', N'Lào Cai'),
(N'Đảo Phú Quốc', N'Đảo Phú Quốc - Kiên Giang'),
(N'Tòa Thánh Cao Đài', N'Tây Ninh'),
(N'Núi Bà Đen', N'Tây Ninh'),
(N'Côn Đảo', N'Bà Rịa - Vũng Tàu'),
(N'Thác Bản Giốc', N'Cao Bằng'),
(N'Đà Lạt', N'Lâm Đồng'),
(N'Vườn quốc gia Cúc Phương', N'Ninh Bình'),
(N'Biển Vũng Tàu', N'Bà Rịa - Vũng Tàu'),
(N'Tràng An', N'Ninh Bình')
GO

INSERT INTO Tour_DiaDanh VALUES
(1, 1),
(2, 2),
(2, 3),
(3, 14),
(3, 16),
(4, 15),
(4, 11),
(5, 13),
(6, 13),
(7, 13),
(8, 7),
(9, 7),
(10, 6),
(11, 6),
(12, 6),
(13, 6),
(14, 6),
(15, 6)
GO

-----------------------------STORED PROCEDURE CHO NGUOI DUNG-----------------------------
--Thủ tục kiểm tra đăng nhập
CREATE PROC sp_KiemTraDangNhap @tenDangnhap NVARCHAR(200), @Matkhau NVARCHAR(200), @Kq INT OUTPUT
AS
	BEGIN
	DECLARE @count INT
	SET @count = (SELECT COUNT(*) FROM dbo.NguoiDung WHERE TenDangNhap = @tenDangnhap AND MatKhau = @Matkhau AND TinhTrang = 'TRUE')
	IF @count > 0
		SET @Kq = 1
	ELSE
		SET @Kq = 0
	END
GO

--Thủ tục lấy tên đăng nhập
CREATE PROC sp_LayTenDangNhap @tenDangNhap NVARCHAR(200)
AS
	BEGIN
	SELECT TenDangNhap FROM dbo.NguoiDung WHERE TenDangNhap=@tenDangNhap
	END
GO
--Thủ tục kiểm tra loại tài khoản trả về idKieunguoidung
CREATE PROC spKiemTraTaiKhoanId @tenDangnhap NVARCHAR(100),@kq INT OUTPUT
AS
	BEGIN 
	SET @kq = (SELECT idKieunguoidung FROM dbo.NguoiDung WHERE TenDangNhap = @tenDangnhap)
	END
GO
--Thủ tục lấy người dùng
CREATE PROC sp_LayNguoiDung @userName NVARCHAR(200),@passWord NVARCHAR(200)
AS
	BEGIN 
	SELECT IDNguoiDung,dbo.NhanVien.TenNhanVien,TenDangNhap,NguoiDung.IDNhanVien FROM dbo.NguoiDung,dbo.NhanVien WHERE dbo.NhanVien.IDNhanVien = dbo.NguoiDung.IDNguoiDung AND TenDangNhap = @userName AND MatKhau = @passWord
	END	
GO
-----------------------------STORED PROCEDURE CHO TOUR-----------------------------
--Hiển thị thông tin tất cả các Tour trong Quản trị tour
CREATE PROC sp_HienThiThongTinTourQuanTri
AS
	BEGIN
		SELECT dbo.Tour.IDTour,TenTour,GiaTour,(GiaTour - (SELECT SUM(GiaVe) FROM dbo.Ve WHERE dbo.Tour.IDTour = dbo.Ve.IDTour)) AS 'ConLai',SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien
	END
GO
--Hiển thị tất cả trạng thái tour
CREATE PROC sp_HienThiTrangThaiTour
AS
	BEGIN
	SELECT * FROM dbo.TrangThai
	END
GO
--Hiển thị tour theo ngày tháng năm
CREATE PROC sp_HienThiTourNgayThangNam @ngayDi DATE,@ngayVe DATE
AS
	BEGIN
	SELECT IDTour,TenTour,GiaTour,(GiaTour - (SELECT SUM(GiaVe) FROM dbo.Ve WHERE dbo.Tour.IDTour = dbo.Ve.IDTour)) AS 'ConLai',SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND NgayDi BETWEEN @ngayDi AND @ngayVe AND NgayVe BETWEEN @ngayDi AND @ngayVe
    END
GO
--Hiển thị tour theo trạng thái
CREATE PROC sp_HienThiTourTheoTrangThai @IDTrangThai INT
AS
	BEGIN
	SELECT IDTour,TenTour,GiaTour,(GiaTour - (SELECT SUM(GiaVe) FROM dbo.Ve WHERE dbo.Tour.IDTour = dbo.Ve.IDTour)) AS 'ConLai',SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND Tour.IdTrangThai = @IDTrangThai
	END
GO
--Hiển thị tour theo nhân viên
CREATE PROC sp_HienThiTourTheoNhanVien @IDNhanVien INT
AS
	BEGIN
	SELECT IDTour,TenTour,GiaTour,(GiaTour - (SELECT SUM(GiaVe) FROM dbo.Ve WHERE dbo.Tour.IDTour = dbo.Ve.IDTour)) AS 'ConLai',SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND Tour.IDNhanVien = @IDNhanVien
	END
GO
--Hiển thị thông tin tất cả các Tour
CREATE PROC sp_HienThiThongTinTour
AS
	BEGIN
		SELECT IDTour,TenTour,GiaTour,SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien
	END
GO
--Hiển thị thông tin tour đang lên kế hoạch
CREATE PROC sp_HienThiTourKeHoach
AS
	BEGIN
		SELECT IDTour,TenTour,GiaTour,SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND Tour.IdTrangThai = 1
    END
GO
--Hiển thị các tour chuẩn bị tiến hành
GO
CREATE PROC sp_HienThiTourChuanBi
AS
	BEGIN
		SELECT IDTour,TenTour,GiaTour,SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND Tour.IdTrangThai = 2
    END
GO
--Hiển thị tour theo khách hàng
CREATE PROC sp_HienThiTourIDKH @idKH INT
AS
	BEGIN
		SELECT dbo.Tour.IDTour,TenTour,GiaTour,SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,GhiChu,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien,dbo.TourYeuCau WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND dbo.Tour.IDTour = dbo.TourYeuCau.IDTour AND IDKhachHang = @idKH
    END
GO
--Cập nhật tour KH
CREATE PROC sp_CapNhatTourYC @idTour INT,@idKhachHang INT, @GhiChu NVARCHAR(MAX)
AS
	BEGIN
	UPDATE dbo.TourYeuCau SET GhiChu = @GhiChu WHERE IDTour = @idTour AND IDKhachHang = @idKhachHang
    END

GO
--Tìm kiếm Tour theo IdTour nhận vào
CREATE PROC sp_TimKiemTourTheoID @idTour INT
AS
	BEGIN
		SELECT * FROM dbo.Tour WHERE IDTour = @idTour
	END
GO
--Tìm kiếm Tour theo tên
CREATE PROC sp_TimKiemTourTheoTen @tenTour NVARCHAR(100)
AS
	BEGIN
		SELECT IDTour,TenTour,GiaTour,SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND TenTour LIKE +'%'+@tenTour+'%'
	END
GO
--Tìm kiếm tour theo tên quản trị
CREATE PROC sp_TimKiemTourTheoTenQuanTri @tenTour NVARCHAR(100)
AS
	BEGIN
		SELECT IDTour,TenTour,GiaTour,(GiaTour - (SELECT SUM(GiaVe) FROM dbo.Ve WHERE dbo.Tour.IDTour = dbo.Ve.IDTour)) AS 'ConLai',SoLuong,NgayDi,NgayVe,dbo.TrangThai.TenTrangThai,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND TenTour LIKE +'%'+@tenTour+'%'
	END
GO
--Tìm kiếm Tour theo giá lấy tham số đầu vào là một giá trị
CREATE PROC sp_TimKiemTourTheoGia @giaTour FLOAT
AS
	BEGIN
		SELECT TenTour,GiaTour,SoLuong,NgayDi,NgayVe FROM Tour WHERE GiaTour <= @giaTour
	END
GO
--Hiển thị các Tour còn lại
CREATE PROC sp_HienThiTourCon
AS
	BEGIN
		SELECT TenTour,GiaTour,SoLuong,NgayDi,NgayVe FROM Tour WHERE SoLuong > 0
	END
GO
--Hiển thị các Tuor chưa khởi hành
CREATE PROC sp_HienThiTourChuaChay @ngayHeThong DATETIME
AS
	BEGIN
		SELECT TenTour,GiaTour,SoLuong,NgayDi,NgayVe FROM Tour WHERE NgayDi > @ngayHeThong
	END
GO
--Set trạng thái cho Tour
CREATE PROC sp_SetTrangThaiTour @idTrangThai INT,@idTour INT
AS
	BEGIN
		UPDATE dbo.Tour SET IdTrangThai = @idTrangThai WHERE IDTour = @idTour
	END
GO
--Kiểm tra số lượng Tour có còn hay không
CREATE PROC sp_KiemTraTour @tenTour NVARCHAR(200), @kq INT OUTPUT
AS
	BEGIN
	DECLARE @sl INT
	SET @sl = (SELECT SoLuong FROM Tour WHERE TenTour = @tenTour)
	IF(@sl>0)
		SET @kq = 1 --Tour còn
	ELSE
		SET @kq = 0	--Tour đã hết
	END
GO
--Hiển thị địa danh
CREATE PROC sp_LayDiaDanh
AS
	BEGIN
	SELECT * FROM dbo.DiaDanh
    END

GO
--Hiển thị khách sạn
CREATE PROC sp_LayKhachSan
AS
	BEGIN
	SELECT * FROM dbo.KhachSan
	END
GO
--Hiển thị phương tiện
CREATE PROC sp_LayPhuongTien
AS
	BEGIN
	SELECT * FROM dbo.PhuongTien
    END
GO
--Thủ tục thêm Tour 
CREATE PROC sp_ThemTour @TenTour NVARCHAR(200),@GiaTour FLOAT,@SoLuong INT,@NgayDi DATE,@NgayVe DATE,@idTrangThai INT,@MoTa NVARCHAR(MAX),@idNhanVien INT,@giaVe FLOAT
AS
	BEGIN
	INSERT INTO dbo.Tour
	(
	    TenTour,
	    GiaTour,
	    SoLuong,
	    NgayDi,
	    NgayVe,
	    IdTrangThai,
	    MoTa,
	    IDNhanVien,
		DonGiaVe
	)
	VALUES
	(   @TenTour,       -- TenTour - nvarchar(200)
	    @GiaTour,       -- GiaTour - float
	    @SoLuong,         -- SoLuong - int
	    @NgayDi, -- NgayDi - date
	    @NgayVe, -- NgayVe - date
	    @idTrangThai,         -- IdTrangThai - int
	    @MoTa,       -- MoTa - nvarchar(max)
	    @idNhanVien,       -- IDNhanVien - int
		@giaVe
	    )
	END
GO
--Lấy max idtour
CREATE PROC sp_LayMaxIdTour @idNhanVien INT
AS
	BEGIN
		 SELECT MAX(IDTour) FROM dbo.Tour WHERE IDNhanVien = @idNhanVien
	END
GO
--Cập nhật tour
CREATE PROC sp_CapNhatTour @idTour INT,@TenTour NVARCHAR(200),@GiaTour FLOAT,@SoLuong INT,@NgayDi DATE,@NgayVe DATE,@idTrangThai INT,@MoTa NVARCHAR(MAX),@idNhanVien INT,@giaVe FLOAT
AS
	BEGIN
	UPDATE dbo.Tour SET TenTour = @TenTour,GiaTour = @GiaTour,SoLuong = @SoLuong, NgayDi = @NgayDi,NgayVe = @NgayVe,IdTrangThai = @idTrangThai,MoTa = @MoTa,IDNhanVien = @idNhanVien, DonGiaVe = @giaVe WHERE IDTour = @idTour
    END
GO
--Thêm Tour yêu cầu
CREATE PROC sp_ThemTourYeuCau @idTour INT, @idKhachHang INT, @GhiChu NVARCHAR(MAX)
AS
	BEGIN
		INSERT INTO dbo.TourYeuCau
		(
		    IDTour,
		    IDKhachHang,
		    GhiChu
		)
		VALUES
		(   @idTour, -- IDTour - int
		    @idKhachHang, -- IDKhachHang - int
		    @GhiChu  -- GhiChu - nvarchar
		    )
	END
GO
--Thêm tour dia danh
CREATE PROC sp_ThemTourDiaDanh @idTour INT,@idDiaDanh INT
AS
	BEGIN
	INSERT INTO dbo.Tour_DiaDanh
	        ( IDTour, IDDiaDanh )
	VALUES  ( @idTour, -- IDTour - int
	          @idDiaDanh  -- IDDiaDanh - int
	          )
    END
GO
--Thêm tour khách sạn
CREATE PROC sp_ThemTourKhachSan @idTour INT,@idKhachSan INT
AS
	BEGIN
	INSERT INTO dbo.Tour_KhachSan
	        ( IDTour, IDKhachSan )
	VALUES  ( @idTour, -- IDTour - int
	          @idKhachSan -- IDKhachSan - int
	          )
	END
GO

--Thêm tour Phương tiện
CREATE PROC sp_ThemTourPT @idTour INT,@idPhuongTien INT,@SL INT
AS
	BEGIN
	INSERT INTO dbo.Tour_PhuongTien
	        ( IDTuor, IDPhuongTien, SoLuong )
	VALUES  ( @idTour, -- IDTuor - int
	          @idPhuongTien, -- IDPhuongTien - int
	          @SL  -- SoLuong - int
	          )
	END
GO
--Xóa tour dia danh
CREATE PROC sp_XoaTourDiaDanh @idTour INT
AS
	BEGIN
		DELETE FROM dbo.Tour_DiaDanh WHERE IDTour = @idTour
	END
GO
--Xóa tour khách sạn
CREATE PROC sp_XoaTourKhachSan @idTour INT
AS
	BEGIN
		DELETE FROM dbo.Tour_KhachSan WHERE IDTour = @idTour
	END
GO
--Xóa tour phương tiện
CREATE PROC sp_XoaTourPhuongTien @idTour INT
AS
	BEGIN
		DELETE FROM dbo.Tour_PhuongTien WHERE IDTuor = @idTour
	END
GO
-----------------------------STORED PROCEDURE CHO PHUONGTIEN-----------------------------

--Hiển thị chi tiết phương tiện theo IdTour nhận vào
CREATE PROC sp_HienThiTour_PhuongTien @idTour INT
AS
	BEGIN
	SELECT PhuongTien.IDPhuongTien,TenPhuongTien,SoLuong FROM dbo.Tour_PhuongTien,dbo.PhuongTien WHERE dbo.PhuongTien.IDPhuongTien = dbo.Tour_PhuongTien.IDPhuongTien AND IDTuor = @idTour
	END
GO
--Hiển thị các phương tiện trong chi tiết phương tiện
CREATE PROC sp_HienThiPhuongTien @idChiTietPT INT
AS
	BEGIN
	SELECT dbo.PhuongTien.IDPhuongTien,TenPhuongTien,SoCho FROM dbo.PhuongTien,dbo.Tour_PhuongTien WHERE IDChiTietPT = @idChiTietPT AND dbo.Tour_PhuongTien.IDPhuongTien = dbo.PhuongTien.IDPhuongTien
	END
GO
--EXEC dbo.sp_HienThiPhuongTien @idChiTietPT = 3 -- int

-----------------------------STORED PROCEDURE CHO KHACH SAN-----------------------------

--Hiển thị chi tiết khách sạn theo IdTour nhận vào
CREATE PROC sp_HienThiTour_KhachSan @idTour INT
AS
	BEGIN
	SELECT dbo.KhachSan.IDKhachSan,TenKhachSan FROM dbo.Tour_KhachSan,dbo.KhachSan WHERE dbo.KhachSan.IDKhachSan = dbo.Tour_KhachSan.IDKhachSan AND IDTour = @idTour
	END
GO
--Hiển thị các khách sạn trong chi tiết khách sạn
CREATE PROC sp_HienThiKhachSan @idChiTietKhachSan INT
AS
	BEGIN
	SELECT dbo.KhachSan.IDKhachSan,TenKhachSan,DiaChi FROM dbo.KhachSan,dbo.Tour_KhachSan WHERE IDChiTietKhachSan = @idChiTietKhachSan AND dbo.Tour_KhachSan.IDKhachSan = dbo.KhachSan.IDKhachSan
	END
GO
--EXEC dbo.sp_HienThiKhachSan @idChiTietKhachSan = 0 -- int

-----------------------------STORED PROCEDURE CHO DIA DANH-----------------------------

--Hiển thị chi tiết địa danh theo IdTour nhận vào
CREATE PROC sp_HienThiTour_DiaDanh @idTour INT
AS
	BEGIN
	SELECT DiaDanh.IDDiaDanh,TenDiaDanh FROM dbo.Tour_DiaDanh,dbo.DiaDanh WHERE dbo.Tour_DiaDanh.IDDiaDanh = dbo.DiaDanh.IDDiaDanh AND IDTour = @idTour
	END
GO
--Hiển thị các địa danh trong chi tiết địa danh
CREATE PROC sp_HienThiDiaDanh @idChiTietDiaDanh INT
AS
	BEGIN
	SELECT dbo.DiaDanh.IDDiaDanh,TenDiaDanh,DiaChi FROM dbo.DiaDanh,dbo.Tour_DiaDanh WHERE IDChiTietDiaDanh = @idChiTietDiaDanh AND dbo.Tour_DiaDanh.IDDiaDanh = dbo.DiaDanh.IDDiaDanh
	END
GO
-----------------------------SOTRE PROCDEDURE CHO KHÁCH HÀNG--------------------=
--Lấy danh sách khách hàng
CREATE PROC sp_HienThiDanhSachKhachHang
AS
	BEGIN
	SELECT IDKhachHang,TenKhachHang,SoDienThoai,DiaChi,GioiTinh,SoCanCuoc, FORMAT(NgaySinh,'dd/MM/yyyy') AS NgaySinh,FORMAT(NgayThem,'dd/MM/yyyy') AS NgayThem FROM dbo.KhachHang
	END
GO
--Hiển thị danh sách sinh nhật khách hàng
CREATE PROC sp_HienThiDanhSachSNKhachHang @thang INT
AS
	BEGIN
	SELECT TenKhachHang,SoDienThoai,DiaChi,GioiTinh, FORMAT(NgaySinh,'dd/MM/yyyy') AS NgaySinh FROM dbo.KhachHang WHERE MONTH(NgaySinh) = @thang
	END
GO
--Tìm kiếm khách hàng
CREATE PROC sp_TimKiemKhachHang @TenKhachHang NVARCHAR(200)
AS
	BEGIN
	SELECT IDKhachHang,TenKhachHang,SoDienThoai,DiaChi,GioiTinh,SoCanCuoc, FORMAT(NgaySinh,'dd/MM/yyyy') AS NgaySinh,FORMAT(NgayThem,'dd/MM/yyyy') AS NgayThem FROM dbo.KhachHang WHERE TenKhachHang LIKE + '%'+@TenKhachHang+'%'
    END
GO
--Thêm khách hàng
CREATE PROC sp_ThemKhachHang @TenKhachHang NVARCHAR(200),
	@SoDienThoai CHAR(20),
	@DiaChi NVARCHAR(100),
	@GioiTinh NVARCHAR(5),
	@SoCanCuoc CHAR(20),
	@NgaySinh DATE
AS
	BEGIN
	INSERT INTO dbo.KhachHang
	        ( TenKhachHang ,
	          SoDienThoai ,
	          DiaChi ,
	          GioiTinh ,
	          SoCanCuoc,
			  NgaySinh,
			  NgayThem
	        )
	VALUES  ( @TenKhachHang , -- TenKhachHang - nvarchar(200)
	          @SoDienThoai , -- SoDienThoai - char(20)
	          @DiaChi , -- DiaChi - nvarchar(100)
	          @GioiTinh , -- GioiTinh - nvarchar(5)
	          @SoCanCuoc,  -- SoCanCuoc - char(20)
			  @NgaySinh,
			  GETDATE()
	        )
	END
GO
--Cập nhật thông tin khách hàng
CREATE PROC sp_CapNhatKhachHang @IDKhachHang INT,
	@TenKhachHang NVARCHAR(200),
	@SoDienThoai CHAR(20),
	@DiaChi NVARCHAR(100),
	@GioiTinh NVARCHAR(5),
	@SoCanCuoc CHAR(20),
	@NgaySinh DATE
AS
	BEGIN
	UPDATE dbo.KhachHang SET TenKhachHang = @TenKhachHang,SoDienThoai = @SoDienThoai,DiaChi = @DiaChi,GioiTinh = @GioiTinh,SoCanCuoc = @SoCanCuoc,NgaySinh = @NgaySinh WHERE IDKhachHang = @IDKhachHang
	END
GO
--Xóa khách hàng
CREATE PROC sp_XoaKhachHang @IDKhachHang INT,@kq INT OUTPUT
AS
	BEGIN
	DECLARE @count INT
	DECLARE @count2 INT
	SET @count = (SELECT COUNT(*) FROM dbo.TourYeuCau WHERE IDKhachHang = @IDKhachHang)
	SET @count2 = (SELECT COUNT(*) FROM dbo.Ve WHERE IDKhachHang = @IDKhachHang)
	IF @count > 0 OR @count2 > 0
	SET @kq = -1
	ELSE
		BEGIN
			DELETE dbo.KhachHang WHERE IDKhachHang = @IDKhachHang
			SET @kq = 1
		END
    END
GO
-----------------------------STORED PROCEDURE CHO VE-----------------------------
--Hiển thị thông tin loại vé
CREATE PROC sp_HienThiLoaiVe
AS
	BEGIN
		SELECT * FROM dbo.LoaiVe
    END
GO
--Hiển thị giá vé cho khách thấy trước khi mua
CREATE PROC sp_HienThiGiaVe  @idTour INT,@idLoaiVe INT,@GiaVe FLOAT OUTPUT
AS
	BEGIN
	DECLARE @dongiave FLOAT
	SET @dongiave = (SELECT DonGiaVe FROM dbo.Tour WHERE IDTour = @idTour)
	IF(@idLoaiVe = 1)
	SET @GiaVe = @dongiave 
	ELSE 
	SET @GiaVe = @dongiave*0.7
	END
GO

--Thủ tục khi bấm mua vé
CREATE PROC sp_NhapVe @idTour INT,@idKhachHang INT,@TenVe NVARCHAR(MAX),@idLoaiVe INT,@SLVe INT,@IDNhanVien INT
AS
	BEGIN
	DECLARE @giave FLOAT
	DECLARE @soluong INT
	DECLARE @DonGiaVe FLOAT
	DECLARE @sl INT
	SET @DonGiaVe = (SELECT DonGiaVe FROM Tour WHERE Tour.IDTour = @idTour)
	IF(@idLoaiVe = 1)
	SET  @giave = @DonGiaVe
	--
	IF(@idLoaiVe = 2) 
	SET @giave = @DonGiaVe*0.7
	--
	WHILE(@SLVe > 0)
	BEGIN
		INSERT INTO dbo.Ve
			(
				IDTour,
				IDKhachHang,
				TenVe,
				GiaVe,
				IDLoaiVe,
				IDNhanVien,
				NgayXuat
			)
			VALUES
			(   @idTour,   -- IDTour - int
				@idKhachHang,   -- IDKhachHang - int
				@TenVe, -- TenVe - nvarchar(100)
				@giave, -- GiaVe - float
				@idLoaiVe,   -- IDLoaiVe - int
				@idNhanVien,    -- IDNhanVien - int
				GETDATE()
			)
			SET @sl = (SELECT SoLuong FROM Tour WHERE IDTour = @idTour)
			SET @SLVe = @SLVe - 1
			UPDATE Tour SET SoLuong = @sl-1 WHERE IDTour = @idTour
		END
	END
GO

--Gán giá trị cho vé theo Tour 

--Tìm kiếm vé theo id khách hàng
CREATE PROC sp_TimVeTheoKhach @idKhachHang INT
AS
	BEGIN
	SELECT * FROM dbo.Ve WHERE IDKhachHang = @idKhachHang
	END
GO
--Tìm kiếm vé theo id Tour
CREATE PROC sp_TimVeTheoTour @idTour INT
AS
	BEGIN
	SELECT * FROM dbo.Ve WHERE IDKhachHang = @idTour
	END
GO

-----------------------------STORED PROCEDURE CHO NHAN VIEN-----------------------------
--Hiển thị nhân viên
--Hiển thị tên và id nhân viên
CREATE PROC sp_HienThiTenNhanVien
AS
	BEGIN
	SELECT IDNhanVien,TenNhanVien FROM dbo.NhanVien
	END
GO
--Set tình trạng cho nhân viên
CREATE PROC sp_SetTinhTrangNV @idNhanVien INT,@tinhTrang INT
AS
	BEGIN
	UPDATE dbo.NhanVien SET TinhTrang = @tinhTrang WHERE IDNhanVien = @idNhanVien
	END
GO

-----------------------------STORED PROCEDURE CHO NGUOI DUNG-----------------------------

--Set tình trạng cho người dùng
CREATE PROC sp_SetTinhTrangND @idNguoiDung INT,@tinhTrang INT
AS
	BEGIN
	UPDATE dbo.NguoiDung SET TinhTrang = @tinhTrang WHERE IDNguoiDung = @idNguoiDung
	END
GO
--Cập nhật tài khoản
-----------------------------STORE PROCDEDURE CHO DOANH THU------------------------------
--Lấy doanh thu tour theo từng tháng
CREATE PROC sp_LayDoanhThuTourThang @nam INT
AS
	BEGIN
	SELECT MONTH(NgayVe) AS 'Thang',SUM(GiaVe) AS 'TongTien' FROM dbo.Tour,dbo.Ve WHERE dbo.Tour.IDTour = dbo.Ve.IDTour AND YEAR(NgayVe) = @nam GROUP BY(MONTH(NgayVe))
	END
GO
--Lấy số khách hàng đăng kí mới trog từng tháng
CREATE PROC sp_LaySLKhachDangKyMoi @nam INT
AS
	BEGIN
	SELECT MONTH(NgayThem) AS 'Thang',COUNT(IDKhachHang) AS SoLuong FROM dbo.KhachHang WHERE YEAR(NgayThem) = 2021 GROUP BY(MONTH(NgayThem))
    END
GO
--Lấy danh sách tour đã hoàn thành theo tháng
CREATE PROC sp_LayDSTourHoanThanh @thang INT,@nam INT
AS
	BEGIN
	SELECT IDTour,TenTour,GiaTour,(SELECT SUM(GiaVe) FROM dbo.Ve WHERE dbo.Tour.IDTour = dbo.Ve.IDTour) AS 'TongThu',SoLuong,NgayDi,NgayVe,MoTa,dbo.NhanVien.TenNhanVien,DonGiaVe FROM dbo.Tour,dbo.TrangThai,dbo.NhanVien WHERE dbo.Tour.IdTrangThai = dbo.TrangThai.IDTrangThai AND dbo.NhanVien.IDNhanVien = dbo.Tour.IDNhanVien AND dbo.Tour.IdTrangThai = 4 AND MONTH(NgayVe) = @thang AND YEAR(NgayVe) = @nam
    END
GO
------------------------------STORE PROCEDURE CHO CÔNG NỢ--------------------------------
--Lấy danh sách công nợ chưa thanh toán
SELECT TenTour,TenNhanVien FROM dbo.CongNo,dbo.Tour,dbo.NhanVien,dbo.NhaCungCap