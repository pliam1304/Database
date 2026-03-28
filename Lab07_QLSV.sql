/*	
HP: Cơ sở dữ liệu
	Lab07: Quản lý Sinh viên
	SV:	Huỳnh Phúc Lâm
	Mã SV: 2411869
	Lớp: CTK48B
	Thời gian: 02/02/26 - kết thúc
*/

Create Database Lab07_QLSV
go
Use Lab07_QLSV
go

-- Tạo bảng Khoa
Create Table Khoa
(
MSKhoa			char(2)			primary key,
TenKhoa			nvarchar(30)	not null unique,
TenTat			nvarchar(4)		not null unique,
)
go

-- Tạo bảng Lop
Create Table Lop
(
MSLop			char(5)			primary key,
TenLop			nvarchar(30)	not null,
MSKhoa			char(2)			references Khoa(MSKhoa),
NienKhoa		smallint		not null,
)
go

-- Tạo bảng Tinh
Create Table Tinh
(
MSTinh			char(2)			primary key,
TenTinh			nvarchar(20)	not null unique
)
go

-- Tạo bảng MonHoc
Create Table MonHoc
(
MSMH			char(4)			primary key,
TenMH			nvarchar(30)	not null unique,
HeSo			tinyint			check (HeSo > 0 and HeSo <= 3)
)
go

-- Tạo bảng SinhVien
Set dateformat dmy
Create Table SinhVien
(
MSSV			char(7)			primary key,
Ho				nvarchar(20)	not null,
Ten				nvarchar(10)	not null,
NgaySinh		date			not null,
MSTinh			char(2)			references Tinh(MSTinh),
NgayNhapHoc		date			not null,
MSLop			char(5)			references Lop(MSLop),
Phai			nvarchar(4)		not null,
DiaChi			nvarchar(40)	not null,
DienThoai		varchar(10),
)
go

-- Tạo bảng BangDiem
Create Table BangDiem
(
MSSV			char(7)			references SinhVien(MSSV),
MSMH			char(4)			references MonHoc(MSMH),
LanThi			tinyint			not null,
Diem			float			not null check (Diem >= 0.0 and Diem <= 10.0)
Primary key(MSSV, MSMH, LanThi)
)
go


-- Xem bảng
select * from Khoa
select * from Tinh
select * from Lop
select * from MonHoc
select * from SinhVien
select * from BangDiem
go

-- Nhập liệu
-- Nhập bảng Khoa
Insert Into Khoa Values ('01', N'Công nghệ thông tin', 'CNTT')
Insert Into Khoa Values ('02', N'Điện tử viễn thông', 'DTVT')
Insert Into Khoa Values ('03', N'Quản trị kinh doanh', 'QTKD')
Insert Into Khoa Values ('04', N'Công nghệ sinh học', 'CNSH')
select * from Khoa

-- Nhập bảng Lop
Insert Into Lop Values ('98TH', N'Tin học khóa 1998', '01', 1998)
Insert Into Lop Values ('98VT', N'Viễn thông khóa 1998', '02', 1998)
Insert Into Lop Values ('99TH', N'Tin học khóa 1999', '01', 1999)
Insert Into Lop Values ('99VT', N'Viễn thông khóa 1999', '02', 1999)
Insert Into Lop Values ('99QT', N'Quản trị khóa 1999', '03', 1999)
select * from Lop
go

-- Nhập bảng Tinh
Insert Into Tinh Values ('01', N'An Giang')
Insert Into Tinh Values ('02', N'TPHCM')
Insert Into Tinh Values ('03', N'Đồng Nai')
Insert Into Tinh Values ('04', N'Long An')
Insert Into Tinh Values ('05', N'Huế')
Insert Into Tinh Values ('06', N'Cà Mau')
select * from Tinh
go

-- Nhập bảng MonHoc
Insert Into MonHoc Values ('TA01', N'Nhập môn tin học', 2)
Insert Into MonHoc Values ('TA02', N'Lập trình cơ bản', 3)
Insert Into MonHoc Values ('TB01', N'Cấu trúc dữ liệu', 2)
Insert Into MonHoc Values ('TB02', N'Cơ sở dữ liệu', 2)
Insert Into MonHoc Values ('QA01', N'Kinh tế vi mô', 2)
Insert Into MonHoc Values ('QA02', N'Quản trị chất lượng', 3)
Insert Into MonHoc Values ('VA01', N'Điện tử cơ bản', 2)
Insert Into MonHoc Values ('VA02', N'Mạch số', 3)
Insert Into MonHoc Values ('VB01', N'Truyền số liệu', 3)
Insert Into MonHoc Values ('XA01', N'Vật lý đại cương', 2)
select * from MonHoc
go

-- Nhập bảng SinhVien
Set DateFormat dmy
Insert Into SinhVien Values ('98TH001', N'Nguyen Van', N'An', '06/08/1980', '01', '03/09/1998', '98TH', N'Yes', N'12 Tran Hung Dao, Q.1', '8234512')
Insert Into SinhVien Values ('98TH002', N'Le Thi', N'An', '17/10/1979', '01', '03/09/1998', '98TH', N'No', N'23 CMT8, Q. Tan Binh', '0303234342')
Insert Into SinhVien Values ('98VT001', N'Nguyen Duc', N'Binh', '25/11/1981', '02', '03/09/1998', '98VT', N'Yes', N'245 Lac Long Quan, Q.11', '8654323')
Insert Into SinhVien Values ('98VT002', N'Tran Ngoc', N'Anh', '19/08/1980', '02', '03/09/1998', '98VT', N'No', N'242 Tran Hung Dao, Q.1', null)
Insert Into SinhVien Values ('99TH001', N'Ly Van Hung', N'Dung', '27/09/1981', '03', '05/10/1999', '99TH', N'Yes', N'178 CMT8, Q. Tan Binh', '7563213')
Insert Into SinhVien Values ('99TH002', N'Van Minh', N'Hoang', '01/01/1981', '04', '05/10/1999', '99TH', N'Yes', N'272 Ly Thuong Kiet, Q.10', '8341234')
Insert Into SinhVien Values ('99TH003', N'Nguyen', N'Tuan', '12/01/1980', '03', '05/10/1999', '99TH', N'Yes', N'162 Tran Hung Dao, Q.5', null)
Insert Into SinhVien Values ('99TH004', N'Tran Van', N'Minh', '25/06/1981', '04', '05/10/1999', '99TH', N'Yes', N'147 Dien Bien Phu, Q.3', '7236754')
Insert Into SinhVien Values ('99VT001', N'Nguyen Thai', N'Minh', '01/01/1980', '04', '05/10/1999', '99VT', N'Yes', N'345 Le Dai Hanh, Q.11', null)
Insert Into SinhVien Values ('99QT001', N'Le Ngoc', N'Mai', '21/06/1982', '01', '05/10/1999', '99QT', N'No', N'129 Tran Hung Dao, Q.1','0903124534')
Insert Into SinhVien Values ('99QT002', N'Nguyen Thi', N'Oanh', '19/08/1973', '04', '05/10/1999', '99QT', N'No', N'76 Hung Vuong, Q.5', '0901654324')
Insert Into SinhVien Values ('99QT003', N'Le My', N'Hanh', '20/05/1976', '04', '05/10/1999', '99QT', N'No', N'12 Pham Ngoc Thach, Q.3', null)
select * from SinhVien
go

-- Nhập bảng BangDiem
Insert Into BangDiem Values ('98TH001', 'TA01', 1, 8.5)
Insert Into BangDiem Values ('98TH001', 'TA02', 1, 8)
Insert Into BangDiem Values ('98TH002', 'TA01', 1, 4)
Insert Into BangDiem Values ('98TH002', 'TA01', 2, 5.5)
Insert Into BangDiem Values ('98TH001', 'TB01', 1, 7.5)
Insert Into BangDiem Values ('98TH002', 'TB01', 1, 8)
Insert Into BangDiem Values ('98VT001', 'VA01', 1, 4)
Insert Into BangDiem Values ('98VT001', 'VA01', 2, 5)
Insert Into BangDiem Values ('98VT002', 'VA02', 1, 7.5)
Insert Into BangDiem Values ('99TH001', 'TA01', 1, 4)
Insert Into BangDiem Values ('99TH001', 'TA01', 2, 6)
Insert Into BangDiem Values ('99TH001', 'TB01', 1, 6.5)
Insert Into BangDiem Values ('99TH002', 'TB01', 1, 10)
Insert Into BangDiem Values ('99TH002', 'TB02', 1, 9)
Insert Into BangDiem Values ('99TH003', 'TA02', 1, 7.5)
Insert Into BangDiem Values ('99TH003', 'TB01', 1, 3)
Insert Into BangDiem Values ('99TH003', 'TB01', 2, 6)
Insert Into BangDiem Values ('99TH003', 'TB02', 1, 8)
Insert Into BangDiem Values ('99TH004', 'TB02', 1, 2)
Insert Into BangDiem Values ('99TH004', 'TB02', 2, 4)
Insert Into BangDiem Values ('99TH004', 'TB02', 3, 3)
Insert Into BangDiem Values ('99QT001', 'QA01', 1, 7)
Insert Into BangDiem Values ('99QT001', 'QA02', 1, 6.5)
Insert Into BangDiem Values ('99QT002', 'QA01', 1, 8.5)
Insert Into BangDiem Values ('99QT002', 'QA02', 1, 9)
select * from BangDiem
go


----- II. TRUY VẤN DỮ LIỆU -----
-- TRUY VẤN ĐƠN GIẢN
-- 1) Liệt kê MSSV, Họ, Ten, Địa chỉ, của tất cả các sinh viên
Select *
From SinhVien

-- 2) Liệt kê MSSV, Họ, Ten, Địa chỉ, của tất cả các sinh viên. Sắp xếp kết quả theo MS tỉnh, trong cùng tỉnh sắp xếp theo họ tên sinh viên
Select * 
From SinhVien
Order by MSTinh, Ho, Ten 

-- 3) Liệt kê các sinh viên nữ của tỉnh Long An
Select *
From SinhVien
Where Phai = 'No' and MSTinh = '04'

-- 4) Liệt kê các sinh viên có sinh nhật trong tháng giêng
Select *
From SinhVien
Where MONTH(NgaySinh) = 01

-- 5) Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1
Select *
From SinhVien
Where MONTH(NgaySinh) = 01 and DAY(NgaySinh) = 01

-- 6) Liệt kê các sinh viên có số điện thoại
Select * 
From SinhVien
Where DienThoai is not null

-- 7) Liệt kê các sinh viên có số điện thoại
Select *
From SinhVien
Where DienThoai like '0%'

-- 8) Liệt kê các sinh viên có tên 'Minh' học lớp '99TH'
Select *
From SinhVien
Where Ten = 'Minh' and MSSV like '99TH%'

-- 9) Liệt kê các sinh viên có địa chỉ ở đường 'Tran Hung Dao'
Select *
From SinhVien
Where DiaChi like '%Tran Hung Dao%'

-- 10) Liệt kê các sinh viên có tên lót chữ 'Van'
Select *
From SinhVien
Where Ho like '% Van%'

-- 11) Liệt kê MSSV, Ho Ten (Ghép họ và tên thành 1 cột), Tuổi của các sinh viên ở tinh Long An
Select MSSV, Ho + ' ' + Ten as HoTen, (YEAR(GetDate()) - YEAR(NgaySinh)) as Tuoi
From SinhVien
Where MSTinh = '04'

-- 12) Liệt kê các sinh viên nam từ 23 đến 28 tuổi
Select *
From SinhVien
Where (YEAR(GetDate()) - YEAR(NgaySinh)) >= 23 and (YEAR(GetDate()) - YEAR(NgaySinh)) <= 28

-- 13) Liệt kê các sinh viên nam từ 32 tuổi trở lên và nữ từ 27 tuổi trở lên
Select * , (YEAR(GetDate()) - YEAR(NgaySinh)) as Tuoi
From SinhVien
Where ((YEAR(GetDate()) - YEAR(NgaySinh)) >= 32 and Phai = 'Yes') or ((YEAR(GetDate()) - YEAR(NgaySinh)) >= 27 and Phai = 'No')

-- 14) Liệt kê các sinh viên khi nhập học còn 18 tuổi hoặc đã trên 25 tuổi
Select * , (YEAR(GetDate()) - YEAR(NgaySinh)) as Tuoi
From SinhVien
Where (YEAR(NgayNhapHoc) - YEAR(NgaySinh) = 18) or ((YEAR(GetDate()) - YEAR(NgaySinh)) > 25)

-- 15) Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 ký tự đầu là '99')
Select * 
From SinhVien
Where MSSV like '99%'

-- 16) Liệt kê MSSV, Điểm thi lần 1 môn 'Co so su lieu' của lớp '99TH'
Select A.MSSV, A.Diem 
From BangDiem A, MonHoc B
Where A.MSMH = B.MSMH and A.MSSV like '99TH%' and A.LanThi = 1 and B.TenMH = N'Cơ sở dữ liệu'


-- 17) Liệt kê MSSV, Họ tên của các sinh viên '99TH' thi không đạt lần 1 môn 'Co so su lieu'
Select SV.MSSV, SV.Ho + ' ' + SV.Ten as HoTen, BD.Diem
From SinhVien SV, BangDiem BD
Where SV.MSSV = BD.MSSV and BD.LanThi = 1 and BD.Diem < 5

-- 18) Liệt kê tất cả các điểm thi của sinh viên có mã số '99TH001' theo mẫu sau
-- MSMH -- Tên MH -- Lần thi -- Điểm
Select BD.MSMH, MH.TenMH, BD.LanThi, BD.Diem 
From BangDiem BD, MonHoc MH
Where MH.MSMH = BD.MSMH and BD.MSSV = '99TH001'

-- 19) Liệt kê MSSV, Họ tên, MSLop của các sinh viên có điểm thi lần 1 môn 'Co so du lieu' từ 8 điểm trở lên
Select SV.MSSV, SV.Ho + ' ' + SV.Ten as HoTen, SV.MSLop, BD.Diem
From BangDiem BD, MonHoc MH, SinhVien SV
Where SV.MSSV = BD.MSSV and BD.MSMH = MH.MSMH and MH.TenMH = N'Cơ sở dữ liệu' and BD.LanThi = 1 and BD.Diem >= 8

-- 20) Liệt kê các tỉnh không có sinh viên theo học
Select *
From Tinh t
Where not exists ( 
	Select *
	From SinhVien sv
	Where sv.MSTinh = t.MSTinh
)
-- 21) Liệt kê các sinh viên hiện chưa có điểm môn thi nào
Select *
From SinhVien sv
Where not exists (
	Select *
	From BangDiem bd
	Where bd.MSSV = sv.MSSV
)

-- TRUY VẤN GOM NHÓM
-- 22) Thống kê số lượng sinh viên ở mỗi lớp theo mẫu sau: MSLop, TenLop, SoLuongSV
Select l.MSLop, l.TenLop, count(sv.MSSV) as SoLuongSV
From Lop l left join SinhVien sv
	on l.MSLop = sv.MSLop
Group by l.MSLop, l.TenLop

-- 23) Thống kê số lượng sinh viên ở mỗi tỉnh theo mẫu sau:
-- MS Tinh -- Tên Tỉnh -- Số SV Nam -- Số SV Nữ -- Tổng cộng
Select t.MSTinh, t.TenTinh,
	sum(case when sv.Phai = 'Yes' then 1 else 0 end) as SoNam,
	sum(case when sv.Phai = 'No' then 1 else 0 end) as SoNu,
	count(sv.MSSV) as Tong
From Tinh t left join SinhVien sv
	on t.MSTinh = sv.MSTinh
Group by t.MSTinh, t.TenTinh

-- 24) Thống kê kết quả thi lần 1 môn 'Co so du lieu' ở các lớp, theo mẫu sau
-- MSLop -- TenLop -- Số SV đạt -- Tỉ lệ đạt (%) -- Số SV không đạt -- Tỉ lệ không đạt
Select l.MSLop, l.TenLop,
	sum(case when bd.Diem >= 5 then 1 else 0 end) as SoDat,
	cast(100.0 * sum(case when bd.Diem >= 5 then 1 else 0 end) / count(*) as decimal(5,2)) as TiLeDat,
	sum(case when bd.Diem < 5 then 1 else 0 end) as SoRot,
	cast(100.0 * sum(case when bd.Diem < 5 then 1 else 0 end) / count(*) as decimal(5,2)) as TiLeRot
From Lop l, SinhVien sv, BangDiem bd, MonHoc mh
Where l.MSLop = sv.MSLop
and sv.MSSV = bd.MSSV
and bd.MSMH = mh.MSMH
and mh.TenMH = N'Cơ sở dữ liệu'
and bd.LanThi = 1
Group by l.MSLop, l.TenLop

-- 25) Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau (điểm in ra của mỗi môn là điểm cao nhất trong các lần thi của môn đó)
-- MSSV -- MSMH -- Tên MH -- Hệ số -- Điểm -- Điểm x Hệ số


-- 26) Lập bảng tổng kết theo mẫu sau
-- MSSV -- Họ -- Tên -- ĐTB


-- 27) Thống kê số lượng sinh viên tỉnh 'Long An' đang theo học ở các khoa, theo mẫu sau
-- Năm học -- MSKhoa -- TenKhoa -- Số lượng SV


-- HÀM, THỦ TỤC
-- 28) Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau (điểm in ra lấy điểm cao nhất trong các lần thi)


-- 29) Nhập MS Lớp, in ra bảng tổng kết của lớp đó, theo mẫu sau