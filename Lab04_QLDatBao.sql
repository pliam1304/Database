/*	HP: Cơ sở dữ liệu
	Lab04: Quản lý đặt báo
	SV:	Huỳnh Phúc Lâm
	Mã SV: 2411869
	Lớp: CTK48B
	Thời gian: bắt đầu - kết thúc
*/
---------I. TẠO | XÂY DỰNG CƠ SỞ DỮ LIỆU-----------
Create database Lab04_QLDatBao
go
Use Lab04_QLDatBao
go

Create table BaoChi
(
MaBaoTC   char(4) primary key,
Ten       nvarchar(50) not null,
DinhKy    nvarchar(30),
SoLuong   int check (SoLuong > 0),
GiaBan    int check (GiaBan > 0)
)
go

Create table PhatHanh
(
MaBaoTC   char(4) references BaoChi(MaBaoTC),
SoBaoTC   int,
NgayPH    datetime,
Primary key (MaBaoTC, SoBaoTC)
)
go

Create table KhachHang
(
MaKH    char(4) primary key,
TenKH   nvarchar(30) not null,
DiaChi  nvarchar(50)
)
go

Create table DatBao
(
MaKH     char(4) references KhachHang(MaKH),
MaBaoTC  char(4) references BaoChi(MaBaoTC),
SLMua    int check (SLMua > 0),
NgayDM   datetime,
Primary key (MaKH, MaBaoTC)
)
go


---Xem các bảng
Select * from BaoChi
Select * from PhatHanh
Select * from KhachHang
Select * from DatBao


------------NHẬP DỮ LIỆU---------
---Nhập bảng BaoChi
Insert into BaoChi values ('TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500)
Insert into BaoChi values ('KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000)
Insert into BaoChi values ('TN01', N'Thanh niên', N'Nhật báo', 1000, 2000)
Insert into BaoChi values ('PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000)
Insert into BaoChi values ('PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000)
go
---Xem bảng BaoChi
Select * from BaoChi


---Nhập bảng PhatHanh
Set dateformat dmy
go

Insert into PhatHanh values ('TT01', 123, '15/12/2005')
Insert into PhatHanh values ('KT01', 70,  '15/12/2005')
Insert into PhatHanh values ('TT01', 124, '16/12/2005')
Insert into PhatHanh values ('TN01', 256, '17/12/2005')
Insert into PhatHanh values ('PN01', 45,  '23/12/2005')
Insert into PhatHanh values ('PN02', 111, '18/12/2005')
Insert into PhatHanh values ('PN02', 112, '19/12/2005')
Insert into PhatHanh values ('TT01', 125, '17/12/2005')
Insert into PhatHanh values ('PN01', 46,  '30/12/2005')
go
---Xem bảng PhatHanh
Select * from PhatHanh


--Nhập bảng KhachHang
Insert into KhachHang values ('KH01', N'LAN',  N'2 NCT')
Insert into KhachHang values ('KH02', N'NAM',  N'32 THĐ')
Insert into KhachHang values ('KH03', N'NGOC', N'16 LHP')
go
--xem bảng KhachHang
select * from KhachHang


--nhap bang DatBao
Set dateformat dmy
go

Insert into DatBao values ('KH01', 'TT01', 100, '12/01/2000')
Insert into DatBao values ('KH02', 'TN01', 150, '01/05/2001')
Insert into DatBao values ('KH01', 'PN01', 200, '25/06/2002')
Insert into DatBao values ('KH03', 'KT01', 50,  '17/03/2002')
Insert into DatBao values ('KH03', 'PN02', 200, '26/08/2003')
Insert into DatBao values ('KH02', 'TT01', 250, '15/01/2004')
Insert into DatBao values ('KH01', 'KT01', 300, '14/10/2004')
go
--Xem bảng DatBao
Select * from DatBao

-----------II. TRUY VẤN DỮ LIỆU--------
--q1: Báo phát hành hàng tuần (Tuần báo)
Select MaBaoTC, Ten, GiaBan
From BaoChi
Where DinhKy = N'Tuần báo'

--q2:Báo phụ nữ (mã bắt đầu PN)
Select *
From BaoChi
Where MaBaoTC like 'PN%'

--q3: Khách hàng đặt mua báo phụ nữ (không trùng)
Select distinct A.MaKH, B.TenKH
From DatBao A
Join KhachHang B on A.MaKH = B.MaKH
Where A.MaBaoTC like 'PN%'

--q4: Khách hàng đặt mua tất cả báo phụ nữ
Select B.MaKH, B.TenKH
From DatBao A
Join KhachHang B on A.MaKH = B.MaKH
Where A.MaBaoTC like 'PN%'
Group by B.MaKH, B.TenKH
Having Count(distinct A.MaBaoTC) =
(
    Select Count(*)
    From BaoChi
    Where MaBaoTC like 'PN%'
)

--q5: Khách hàng không đặt mua báo Thanh niên
Select *
From KhachHang
Where MaKH not in
(
    Select MaKH
    From DatBao
    Where MaBaoTC = 'TN01'
)

--q6: Số tờ báo mỗi khách hàng đã đặt
Select A.MaKH, B.TenKH, Count(A.MaBaoTC) as SoBaoDat
From DatBao A
Join KhachHang B on A.MaKH = B.MaKH
Group by A.MaKH, B.TenKH

--q7: Số khách hàng đặt báo trong năm 2004
Select Count(distinct MaKH) as SoKhachHang
From DatBao
Where Year(NgayDM) = 2004

--q8: Thông tin đặt mua của khách hàng (có tính tiền)
Select B.TenKH, C.Ten, C.DinhKy,
       A.SLMua,
       A.SLMua * C.GiaBan as SoTien
From DatBao A
Join KhachHang B on A.MaKH = B.MaKH
Join BaoChi C on A.MaBaoTC = C.MaBaoTC

--q9: Tên báo và tổng số lượng đặt mua
Select B.Ten, B.DinhKy, Sum(A.SLMua) as TongSL
From DatBao A
Join BaoChi B on A.MaBaoTC = B.MaBaoTC
Group by B.Ten, B.DinhKy

--q10: Báo dành cho học sinh, sinh viên (mã HS)
Select *
From BaoChi
Where MaBaoTC like 'HS%'

--q11: Báo không có người đặt mua
Select *
From BaoChi
Where MaBaoTC not in
(
    Select MaBaoTC
    From DatBao
)

--q12: Báo có nhiều người đặt mua nhất
Select top 1 B.Ten, Count(distinct A.MaKH) as SoNguoiDat
From DatBao A
Join BaoChi B on A.MaBaoTC = B.MaBaoTC
Group by B.Ten
Order by SoNguoiDat desc

--q13: Khách hàng đặt mua nhiều báo nhất
Select top 1 B.TenKH, Sum(A.SLMua) as TongSL
From DatBao A
Join KhachHang B on A.MaKH = B.MaKH
Group by B.TenKH
Order by TongSL desc

--q14: Báo phát hành định kỳ một tháng 2 lần (Bán nguyệt san)
Select *
From BaoChi
Where DinhKy = N'Bán nguyệt san'

--q15: Báo có từ 3 khách hàng đặt mua trở lên
Select B.Ten, Count(distinct A.MaKH) as SoKhach
From DatBao A
Join BaoChi B on A.MaBaoTC = B.MaBaoTC
Group by B.Ten
Having Count(distinct A.MaKH) >= 3

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