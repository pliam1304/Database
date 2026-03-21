/*	HP: Cơ sở dữ liệu
	Lab02: Quản lý sản xuất
    SV:	Huỳnh Phúc Lâm
	Mã SV: 2411869
	Lớp: CTK48B
	Thời gian: bắt đầu - kết thúc
*/
---------I. TẠO | XÂY DỰNG CƠ SỞ DỮ LIỆU-----------
Create database	Lab02_QLSX
go
Use	Lab02_QLSX
go

Create table ToSX
(
MaTSX	char(4) primary key,
TenTSX	nvarchar(30)	not null unique
)
go

Create table CongNhan
(
MaCN	char(5) primary key,
Ho		nvarchar(20)	not null,
Ten		nvarchar(10)	not null,
Phai	nvarchar(3) check (Phai in (N'Nam',N'Nu')),
NgaySinh Datetime	not null,
MaTSX	char(4) references ToSX(MaTSX)
)
go

Create table SanPham
(
MaSP	char(5) primary key,
TenSP	nvarchar(20)	not null unique,
DVT		nvarchar(10)	not null,
TienCong int check (TienCong > 0) not null
)
go

Create table ThanhPham
(
MaCN	char(5) references CongNhan(MaCN),
MaSP	char(5) references SanPham(MaSP),
Ngay	Datetime,
SoLuong int check (SoLuong > 0),
Primary key(MaCN, MaSP, Ngay)						
)
go
---Xem các bảng
Select * from CongNhan
Select * from SanPham
Select * from ToSX
Select * from ThanhPham	


------------NHẬP DỮ LIỆU---------
---Nhập bảng SanPham
INSERT INTO SanPham VALUES ('SP001', N'Nồi đất',      N'cái', 10000);
INSERT INTO SanPham VALUES ('SP002', N'Chén',         N'cái', 2000);
INSERT INTO SanPham VALUES ('SP003', N'Bình gốm nhỏ', N'cái', 20000);
INSERT INTO SanPham VALUES ('SP004', N'Bình gốm lớn', N'cái', 25000);
---Xem bảng SanPham
Select * from SanPham
---Nhập bảng CongNhan
SET DATEFORMAT dmy;
GO

INSERT INTO CongNhan VALUES ('CN001', N'Nguyễn Trường', N'An',  N'Nam', '12/05/1981', 'TS01');
INSERT INTO CongNhan VALUES ('CN002', N'Lê Thị Hồng',   N'Gấm', N'Nữ',  '04/06/1980', 'TS01');
INSERT INTO CongNhan VALUES ('CN003', N'Nguyễn Công',   N'Thành', N'Nam','04/05/1981', 'TS02');
INSERT INTO CongNhan VALUES ('CN004', N'Võ Hữu',        N'Hạnh', N'Nam', '15/02/1980', 'TS02');
INSERT INTO CongNhan VALUES ('CN005', N'Lý Thanh',      N'Hân',  N'Nữ',  '03/12/1981', 'TS01');
go
---Xem bảng CongNhan
Select * from CongNhan
--Nhập bảng ToSX
INSERT INTO ToSX VALUES ('TS01', N'Tổ 1');
INSERT INTO ToSX VALUES ('TS02', N'Tổ 2');
--xem bảng ToSX
select * from ToSX
--nhap bang ThanhPham
SET DATEFORMAT dmy;
GO

INSERT INTO ThanhPham VALUES ('CN001','SP001','01/02/2007',10);
INSERT INTO ThanhPham VALUES ('CN002','SP001','01/02/2007',5);
INSERT INTO ThanhPham VALUES ('CN003','SP002','10/01/2007',50);
INSERT INTO ThanhPham VALUES ('CN004','SP003','12/01/2007',10);
INSERT INTO ThanhPham VALUES ('CN005','SP002','12/01/2007',100);
INSERT INTO ThanhPham VALUES ('CN002','SP004','13/02/2007',10);
INSERT INTO ThanhPham VALUES ('CN001','SP003','14/02/2007',15);
INSERT INTO ThanhPham VALUES ('CN003','SP001','15/01/2007',20);
INSERT INTO ThanhPham VALUES ('CN003','SP004','14/02/2007',15);
INSERT INTO ThanhPham VALUES ('CN004','SP002','30/01/2007',100);
INSERT INTO ThanhPham VALUES ('CN005','SP003','01/02/2007',50);
INSERT INTO ThanhPham VALUES ('CN001','SP001','20/02/2007',30);
--Xem bảng ThanhPham
Select * from ThanhPham

-----------II. TRUY VẤN DỮ LIỆU--------
--q1: Liệt kê các công nhân	theo tổ sản xuất
Select B.TenTSX, A.Ho + ' ' + A.Ten as HoTen, CONVERT(char(10),A.NgaySinh,103) as NgaySinh, A.Phai
From CongNhan A
Join ToSX B on A.MaTSX = B.MaTSX
Order by B.TenTSX,A.Ten;

--q2: Liệt kê thành phẩm của 'Nguyễn Trường An' 
Select C.TenSP, B.Ngay, B.SoLuong, B.SoLuong * C.TienCong as ThanhTien
From CongNhan A
Join ThanhPham B on A.MaCN = B.MaCN
Join SanPham C on B.MaSP = B.MaSP
Where A.Ho = N'Nguyễn Trường'
And A.Ten = N'An'
Order by B.Ngay;

--q3: Liệt kê Công nhân KHÔNG sản xuất “Bình gốm lớn”
Select *
From CongNhan
Where MaCN not in (
    Select B.MaCN
    From ThanhPham B
    Join SanPham C ON B.MaSP = C.MaSP
    Where C.TenSP = N'Bình gốm lớn'
);

--q4: Liệt kê Công nhân sản xuất cả “Nồi đất” và “Bình gốm nhỏ”
Select A.MaCN, A.Ho + ' ' + A.Ten as HoTen
From CongNhan A
Where A.MaCN IN (
    Select B.MaCN
    From ThanhPham B
    Join SanPham C ON B.MaSP = C.MaSP
    Where C.TenSP = N'Nồi đất'
)
and A.MACN in (
    Select B.MaCN
    From ThanhPham B
    Join SanPham C ON B.MaSP = C.MaSP
    Where C.TenSP = N'Bình gốm nhỏ'
);

--q5: Thống kê số lượng công nhân theo từng tổ
Select  B.TenTSX, COUNT(A.MaCN) as SoCongNhan
From    CongNhan A
Join    ToSX B on A.MaTSX = B.MaTSX
Group by B.TenTSX;

--q6: Tổng SL thành phẩm theo từng loại mỗi công nhân làm được
Select  A.Ho, A.Ten, C.TenSP, SUM(B.SoLuong) as TongSLThanhPham, SUM(B.SoLuong * C.TienCong) as TongThanhTien
From    CongNhan A
Join    ThanhPham B on A.MaCN = B.MaCN
Join    SanPham C on B.MaSP = C.MaSP
Group by A.Ho, A.Ten, C.TenSP
Order by A.Ten;

--q7: Tổng tiền công trả cho công nhân trong tháng 1/2007
Select  SUM(B.SoLuong * C.TienCong) as TongTienCong
From    ThanhPham B
Join    SanPham C on B.MaSP = C.MaSP
Where   MONTH(B.Ngay) = 1
and     YEAR(B.Ngay) = 2007;

--q8: Cho biết Sản phẩm sản xuất nhiều nhất trong tháng 2/2007
Select top 1 C.TenSP, SUM(B.SoLuong) as TongSL
From    ThanhPham B
Join    SanPham C ON B.MaSP = C.MaSP
Where   MONTH(B.Ngay) = 2
and     YEAR(B.Ngay) = 2007
Group by C.TenSP
Order by TongSL desc;

--q9: Cho biết Công nhân sản xuất nhiều “Chén” nhất
Select top 1 A.Ho + ' ' + A.Ten as HoTen, SUM(B.SoLuong) as TongSL
From    CongNhan A
Join    ThanhPham B ON A.MaCN = B.MaCN
Join    SanPham C ON B.MaSP = C.MaSP
Where   C.TenSP = N'Chén'
Group by A.Ho, A.Ten
Order by TongSL desc;

--q10: Tiền công tháng 2/2007 của CN002
Select  SUM(B.SoLuong * C.TienCong) as TienCong
From    ThanhPham B
Join    SanPham C on B.MaSP = C.MaSP
Where   B.MaCN = 'CN002'
and     MONTH(B.Ngay) = 2
and     YEAR(B.Ngay) = 2007;

--q11: Liệt kê Công nhân sản xuất từ 3 loại sản phẩm trở lên
Select  A.MaCN, A.Ho + ' ' + A.Ten as HoTen, COUNT(Distinct B.MaSP) as SoLoaiSP
From    CongNhan A
Join    ThanhPham B ON A.MaCN = B.MaCN
Group by A.MaCN, A.Ho, A.Ten
Having  COUNT(Distinct B.MaSP) >= 3;

--q12: Cập nhật giá tiền công các loại bình gốm thêm 1000
Update SanPham
Set TienCong = TienCong + 1000
Where TenSP like N'Bình gốm%';

--q13: Thêm công nhân CN006
Insert into CongNhan
Values ('CN006', N'Lê Thị', N'Lan', N'Nữ', '01/01/1985', 'TS02');

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