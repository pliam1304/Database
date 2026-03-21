/*	HP: Cơ sở dữ liệu
	Lab03: Quản lý nhập xuất hàng hóa
    SV:	Huỳnh Phúc Lâm
	Mã SV: 2411869
	Lớp: CTK48B
	Thời gian: bắt đầu - kết thúc
*/
---------I. TẠO | XÂY DỰNG CƠ SỞ DỮ LIỆU-----------
Create database Lab03_QLNhapXuatHangHoa
go
Use Lab03_QLNhapXuatHangHoa
go

Create table HangHoa
(
MaHH        char(5) primary key,
TenHH       nvarchar(50) not null,
DVT         nvarchar(10) not null,
SoLuongTon  int check (SoLuongTon >= 0)
)
go

Create table DoiTac
(
MaDT        char(5) primary key,
TenDT       nvarchar(50) not null,
DiaChi      nvarchar(100),
DienThoai   varchar(15)
)
go

Create table KhaNangCC
(
MaDT char(5) references DoiTac(MaDT),
MaHH char(5) references HangHoa(MaHH),
Primary key (MaDT, MaHH)
)
go

Create table HoaDon
(
SoHD        char(5) primary key,
NgayLapHD   datetime not null,
MaDT        char(5) references DoiTac(MaDT),
TongTG      int
)
go

Create table CT_HoaDon
(
SoHD    char(5) references HoaDon(SoHD),
MaHH    char(5) references HangHoa(MaHH),
DonGia  int check (DonGia > 0),
SoLuong int check (SoLuong > 0),
Primary key (SoHD, MaHH)
)
go
---Xem các bảng
Select * from HangHoa
Select * from DoiTac
Select * from KhaNangCC
Select * from HoaDon
Select * from CT_HoaDon


------------NHẬP DỮ LIỆU---------
---Nhập bảng HangHoa
Insert into HangHoa values ('CPU01', N'CPU INTEL, CELERON 600 BOX', N'Cái', 5)
Insert into HangHoa values ('CPU02', N'CPU INTEL, PIII 700', N'Cái', 10)
Insert into HangHoa values ('CPU03', N'CPU AMD K7 ATHLON 600', N'Cái', 8)
Insert into HangHoa values ('HDD01', N'HDD 10.2 GB QUANTUM', N'Cái', 10)
Insert into HangHoa values ('HDD02', N'HDD 13.6 GB SEAGATE', N'Cái', 15)
Insert into HangHoa values ('HDD03', N'HDD 20 GB QUANTUM', N'Cái', 6)
Insert into HangHoa values ('KB01', N'KB GENIUS', N'Cái', 12)
Insert into HangHoa values ('KB02', N'KB MITSUMI', N'Cái', 5)
Insert into HangHoa values ('MB01', N'GIGABYTE CHIPSET INTEL', N'Cái', 10)
Insert into HangHoa values ('MB02', N'ACORP BX CHIPSET VIA', N'Cái', 10)
Insert into HangHoa values ('MB03', N'INTEL PHI CHIPSET INTEL', N'Cái', 10)
Insert into HangHoa values ('MB04', N'ECS CHIPSET SIS', N'Cái', 10)
Insert into HangHoa values ('MB05', N'ECS CHIPSET VIA', N'Cái', 10)
Insert into HangHoa values ('MNT01', N'SAMSUNG 14'' SYNCMASTER', N'Cái', 5)
Insert into HangHoa values ('MNT02', N'LG 14''', N'Cái', 5)
Insert into HangHoa values ('MNT03', N'ACER 14''', N'Cái', 8)
Insert into HangHoa values ('MNT04', N'PHILIPS 14''', N'Cái', 6)
Insert into HangHoa values ('MNT05', N'VIEWSONIC 14''', N'Cái', 7)
go
---Xem bảng HangHoa
Select * from HangHoa


---Nhập bảng DoiTac
Insert into DoiTac values ('CC001', N'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
Insert into DoiTac values ('CC002', N'Cty Hoàng Long', N'15A TTT Q1 - TP.HCM', '08.8250898')
Insert into DoiTac values ('CC003', N'Cty Hợp Nhất', N'152 BTX Q1 - TP.HCM', '08.8252376')
Insert into DoiTac values ('KH001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi TP. Đà Lạt', '063.831129')
Insert into DoiTac values ('KH002', N'Như Quỳnh', N'21 Điện Biên Phủ N. Trang', '058.90270')
Insert into DoiTac values ('KH003', N'Trần Nhật Duật', N'Lê Lợi TP. Huế', '054.848376')
Insert into DoiTac values ('KH004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi Nghĩa - TP. Đà Lạt', '063.823409')
go
---Xem bảng DoiTac
Select * from DoiTac


--Nhập bảng HoaDon
Set dateformat dmy
go

Insert into HoaDon values ('N0001', '25/01/2006', 'CC001', null)
Insert into HoaDon values ('N0002', '01/05/2006', 'CC002', null)
Insert into HoaDon values ('X0001', '12/05/2006', 'KH001', null)
Insert into HoaDon values ('X0002', '16/06/2006', 'KH002', null)
Insert into HoaDon values ('X0003', '20/04/2006', 'KH001', null)
go
--xem bảng HoaDon
select * from HoaDon


--nhap bang KhaNangCC
Insert into KhaNangCC values ('CC001', 'CPU01')
Insert into KhaNangCC values ('CC001', 'HDD03')
Insert into KhaNangCC values ('CC001', 'KB01')
Insert into KhaNangCC values ('CC001', 'MB02')
Insert into KhaNangCC values ('CC001', 'MB04')
Insert into KhaNangCC values ('CC001', 'MNT01')
Insert into KhaNangCC values ('CC002', 'CPU01')
Insert into KhaNangCC values ('CC002', 'CPU02')
Insert into KhaNangCC values ('CC002', 'CPU03')
Insert into KhaNangCC values ('CC002', 'KB02')
Insert into KhaNangCC values ('CC002', 'MB01')
Insert into KhaNangCC values ('CC002', 'MB05')
Insert into KhaNangCC values ('CC002', 'MNT03')
Insert into KhaNangCC values ('CC003', 'HDD01')
Insert into KhaNangCC values ('CC003', 'HDD02')
Insert into KhaNangCC values ('CC003', 'HDD03')
Insert into KhaNangCC values ('CC003', 'MB03')
go
--Xem bảng KhaNangCC
Select * from KhaNangCC

Insert into CT_HoaDon values ('N0001', 'CPU01', 63, 10)
Insert into CT_HoaDon values ('N0001', 'HDD03', 97, 7)
Insert into CT_HoaDon values ('N0001', 'KB01', 3, 5)
Insert into CT_HoaDon values ('N0001', 'MB02', 57, 5)
Insert into CT_HoaDon values ('N0001', 'MNT01', 112, 3)
Insert into CT_HoaDon values ('N0002', 'CPU02', 115, 3)
Insert into CT_HoaDon values ('N0002', 'KB02', 5, 7)
Insert into CT_HoaDon values ('N0002', 'MNT03', 111, 5)
Insert into CT_HoaDon values ('X0001', 'CPU01', 67, 2)
Insert into CT_HoaDon values ('X0001', 'HDD03', 100, 2)
Insert into CT_HoaDon values ('X0001', 'KB01', 5, 2)
Insert into CT_HoaDon values ('X0001', 'MB02', 62, 1)
Insert into CT_HoaDon values ('X0002', 'CPU01', 67, 1)
Insert into CT_HoaDon values ('X0002', 'KB02', 7, 3)
Insert into CT_HoaDon values ('X0002', 'MNT01', 115, 2)
Insert into CT_HoaDon values ('X0003', 'CPU01', 67, 1)
Insert into CT_HoaDon values ('X0003', 'MNT03', 115, 2)
go

--Xem bảng CT_HoaDon
Select * from CT_HoaDon

-----------II. TRUY VẤN DỮ LIỆU--------
--q1: Liệt kê các mặt hàng thuộc loại đĩa cứng
Select *
From HangHoa
Where TenHH like N'HDD%'

--q2: Liệt kê các mặt hàng có số lượng tồn trên 10
Select *
From HangHoa
Where SoLuongTon > 10

--q3: Thông tin nhà cung cấp ở TP.HCM
Select *
From DoiTac
Where MaDT like 'CC%'
and DiaChi like N'%TP.HCM%'

--q4: Hóa đơn nhập tháng 5/2006
Select A.SoHD, A.NgayLapHD, B.TenDT, B.DiaChi, B.DienThoai
From HoaDon A
Join DoiTac B on A.MaDT = B.MaDT
Where A.SoHD like 'N%'
and Month(A.NgayLapHD) = 5
and Year(A.NgayLapHD) = 2006

--q5: Nhà cung cấp có cung cấp đĩa cứng
Select distinct A.TenDT
From DoiTac A
Join KhaNangCC B on A.MaDT = B.MaDT
Join HangHoa C on B.MaHH = C.MaHH
Where C.TenHH like N'HDD%'

--q6: Nhà cung cấp có thể cung cấp tất cả đĩa cứng
Select A.TenDT
From DoiTac A
Join KhaNangCC B on A.MaDT = B.MaDT
Join HangHoa C on B.MaHH = C.MaHH
Where C.TenHH like N'HDD%'
Group by A.TenDT
Having Count(distinct C.MaHH) =
(
    Select Count(*)
    From HangHoa
    Where TenHH like N'HDD%'
)

--q7: Nhà cung cấp không cung cấp đĩa cứng
Select TenDT
From DoiTac
Where MaDT like 'CC%'
and MaDT not in
(
    Select B.MaDT
    From KhaNangCC B
    Join HangHoa C on B.MaHH = C.MaHH
    Where C.TenHH like N'HDD%'
)

--q8: Mặt hàng chưa bán được
Select *
From HangHoa
Where MaHH not in
(
    Select MaHH
    From CT_HoaDon A
    Join HoaDon B on A.SoHD = B.SoHD
    Where B.SoHD like 'X%'
)

--q9: Mặt hàng bán chạy nhất (theo số lượng)
Select top 1 C.TenHH, Sum(A.SoLuong) as TongSL
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Join HangHoa C on A.MaHH = C.MaHH
Where B.SoHD like 'X%'
Group by C.TenHH
Order by TongSL desc

--q10: Mặt hàng nhập ít nhất
Select top 1 C.TenHH, Sum(A.SoLuong) as TongNhap
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Join HangHoa C on A.MaHH = C.MaHH
Where B.SoHD like 'N%'
Group by C.TenHH
Order by TongNhap asc

--q11: Hóa đơn nhập nhiều mặt hàng nhất
Select top 1 A.SoHD, Count(A.MaHH) as SoMatHang
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Where B.SoHD like 'N%'
Group by A.SoHD
Order by SoMatHang desc

--q12: Mặt hàng không nhập trong tháng 1/2006
Select *
From HangHoa
Where MaHH not in
(
    Select A.MaHH
    From CT_HoaDon A
    Join HoaDon B on A.SoHD = B.SoHD
    Where B.SoHD like 'N%'
    and Month(B.NgayLapHD) = 1
    and Year(B.NgayLapHD) = 2006
)

--q13: Mặt hàng không bán tháng 6/2006
Select *
From HangHoa
Where MaHH not in
(
    Select A.MaHH
    From CT_HoaDon A
    Join HoaDon B on A.SoHD = B.SoHD
    Where B.SoHD like 'X%'
    and Month(B.NgayLapHD) = 6
    and Year(B.NgayLapHD) = 2006
)

--q14: Cửa hàng bán bao nhiêu mặt hàng
Select Count(distinct MaHH) as SoMatHangBan
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Where B.SoHD like 'X%'

--q15: Số mặt hàng mỗi nhà cung cấp có khả năng cung cấp
Select A.TenDT, Count(B.MaHH) as SoMatHang
From DoiTac A
Join KhaNangCC B on A.MaDT = B.MaDT
Group by A.TenDT

--q16: Khách hàng giao dịch nhiều nhất
Select top 1 B.TenDT, Count(A.SoHD) as SoLanGD
From HoaDon A
Join DoiTac B on A.MaDT = B.MaDT
Where A.SoHD like 'X%'
Group by B.TenDT
Order by SoLanGD desc


--q17: Tổng doanh thu năm 2006
Select Sum(A.SoLuong * A.DonGia) as DoanhThu
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Where B.SoHD like 'X%'
and Year(B.NgayLapHD) = 2006    

--q18: Loại mặt hàng bán chạy nhất
Select top 1 C.DVT, Sum(A.SoLuong) as TongSL
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Join HangHoa C on A.MaHH = C.MaHH
Where B.SoHD like 'X%'
Group by C.DVT
Order by TongSL desc

--q19: Tổng tình bán tháng 5/2006
Select C.MaHH, C.TenHH, C.DVT,
       Sum(A.SoLuong) as TongSL,
       Sum(A.SoLuong * A.DonGia) as TongThanhTien
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Join HangHoa C on A.MaHH = C.MaHH
Where B.SoHD like 'X%'
and Month(B.NgayLapHD) = 5
and Year(B.NgayLapHD) = 2006
Group by C.MaHH, C.TenHH, C.DVT


--q20: Mặt hàng có nhiều người mua nhất
Select top 1 C.TenHH, Count(distinct B.MaDT) as SoNguoiMua
From CT_HoaDon A
Join HoaDon B on A.SoHD = B.SoHD
Join HangHoa C on A.MaHH = C.MaHH
Where B.SoHD like 'X%'
Group by C.TenHH
Order by SoNguoiMua desc

--q21: Cập nhật tổng trị giá hóa đơn
Update HoaDon
Set TongTG =
(
    Select Sum(A.SoLuong * A.DonGia)
    From CT_HoaDon A
    Where A.SoHD = HoaDon.SoHD
)
-----4. Gom nhóm & Hàm kết hợp
----q7: cho biết số lượng nhân viên làm việc ở từng chi nhánh.
--Select		MSCN, count(MaNV) as SoNV
--From		CongNhan
--Group by	MSCN
----Q3a) Với mỗi chi nhánh, hãy cho biết các thông tin sau TenCN, SoNV (số nhân viên của chi nhánh đó). 
--Select		TenCN, count(MaNV) as SoNV
--From		CongNhan A, SanPham B
--Where		A.MSCN = B.MSCN
--Group by	A.MSCN, TenCN
----Q3b) Với mỗi kỹ năng, hãy cho biết TenKN, SoNguoiDung (số nhân viên biết sử dụng kỹ năng đó). 
--Select		TenKN, count(MaNV) as SoNguoiDung
--From		ThanhPham A,ToSX B
--Where		A.MSKN = B.MSKN
--Group by	TenKN
----Q3b) Cho biết TenKN có từ 3 nhân viên trong công ty sử dụng trở lên.  
--Select		TenKN, count(MaNV) as SoNguoiDung
--From		ThanhPham A,ToSX B
--Where		A.MSKN = B.MSKN
--Group by	TenKN
--Having		COUNT(MaNV) >=3		--Điều kiện chọn nhóm (dùng hàm kết hợp count| sum để tính rồi mới so sánh)
----Q3f) Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được.   
--Select		Ho+' '+ Ten as HoTen, MSCN, count(MSKN) as SoKN
--From		ThanhPham A,CongNhan B
--Where		A.MaNV = B.MaNV
--Group by	Ho, Ten, MSCN