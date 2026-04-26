create database b2;
use b2;

-- Bảng danh mục
CREATE TABLE DanhMuc (
    MaDanhMuc INT PRIMARY KEY NOT NULL,
    TenDanhMuc VARCHAR(100)
);

-- Bảng sản phẩm
CREATE TABLE SanPham (
    MaSanPham INT PRIMARY KEY NOT NULL,
    TenSanPham VARCHAR(100),
    MaDanhMuc INT,
    GiaBan DECIMAL(10,0),
    SoLuongTon INT,
    FOREIGN KEY (MaDanhMuc) REFERENCES DanhMuc(MaDanhMuc)
);

-- Bảng khách hàng
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY NOT NULL,
    TenKhachHang VARCHAR(100),
    DiaChi VARCHAR(200),
    SoDienThoai VARCHAR(15)
);

-- Bảng đơn hàng
CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY NOT NULL,
    MaKhachHang INT,
    NgayMua DATE,
    TrangThai NVARCHAR(50),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE ChiTietDonHang (
    MaChiTiet INT PRIMARY KEY NOT NULL,
    MaDonHang INT,
    MaSanPham INT,
    SoLuong INT,
    DonGia DECIMAL(10,0),
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)
);

INSERT INTO DanhMuc VALUES
(1, 'Nước giải khát'),
(2, 'Đồ ăn nhanh'),
(3, 'Thực phẩm khô');

INSERT INTO SanPham VALUES
(1, 'Coca Cola lon', 1, 10000, 50),
(2, 'Pepsi chai', 1, 12000, 30),
(3, 'Trà xanh 0 độ', 1, 9000, 100),
(4, 'Nước cam ép', 1, 45000, 20),
(5, 'Bánh mì', 2, 15000, 0),
(6, 'Mì gói', 3, 5000, 200),
(7, 'Nước suối Lavie', 1, 8000, 0),
(8, 'Sting dâu', 1, 15000, 10);

INSERT INTO KhachHang VALUES
(1, 'Nguyễn Văn A', 'Hà Nội', '0901111111'),
(2, 'Trần Thị B', 'Hồ Chí Minh', '0902222222'),
(3, 'Nguyễn Văn C', 'Đà Nẵng', '0903333333'),
(4, 'Lê Văn D', 'Hà Nội', '0904444444'),
(5, 'Phạm Thị E', 'Hải Phòng', '0905555555'),
(6, 'Hoàng Văn F', 'Cần Thơ', '0906666666');

INSERT INTO DonHang VALUES
(1, 1, '2025-01-10', 'Đã giao'),
(2, 2, '2025-02-15', 'Đang xử lý'),
(3, 3, '2025-03-01', 'Đã hủy'),
(4, 1, '2025-03-20', 'Đã giao'),
(5, 4, '2025-04-01', 'Đã giao');

INSERT INTO ChiTietDonHang VALUES
(1, 1, 1, 2, 10000),
(2, 1, 2, 1, 12000),
(3, 2, 4, 1, 45000),
(4, 3, 2, 3, 12000),
(5, 4, 8, 2, 15000),
(6, 5, 1, 1, 10000);

SELECT 
    *
FROM
    sanpham
WHERE
    MaDanhMuc = 1
        AND (GiaBan BETWEEN 10000 AND 50000)
        AND SoLuongTon > 0;



SELECT 
    *
FROM
    khachhang
WHERE
    TenKhachHang LIKE 'Nguyễn%'
        OR DiaChi = ('Hà Nội');



SELECT 
    d.MaDonHang, d.NgayMua, d.TrangThai, k.TenKhachHang
FROM
    donhang d
        JOIN
    khachhang k ON d.MaKhachHang = k.MaKhachHang
ORDER BY d.NgayMua DESC;




SELECT 
    k.TenKhachHang, d.NgayMua, s.TenSanPham, c.SoLuong, c.DonGia
FROM
    DonHang d
        JOIN
    KhachHang k ON d.MaKhachHang = k.MaKhachHang
        JOIN
    ChiTietDonHang c ON d.MaDonHang = c.MaDonHang
        JOIN
    SanPham s ON c.MaSanPham = s.MaSanPham
WHERE
    d.MaDonHang = 1;



SELECT 
    *
FROM
    khachhang kh
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            donhang dh
        WHERE
            dh.MaKhachHang = kh.MaKhachHang);



