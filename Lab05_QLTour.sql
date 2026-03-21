/*	HP: Cơ sở dữ liệu
	Lab05: Quản lý Tour
	SV:	Huỳnh Phúc Lâm
	Mã SV: 2411869
	Lớp: CTK48B
	Thời gian: bắt đầu - kết thúc
*/
---------I. TẠO | XÂY DỰNG CƠ SỞ DỮ LIỆU-----------
Create database Lab05_QLTour
go
Use Lab05_QLTour
go

Create table Tour
(
MaTour char(4) primary key,
TongSoNgay int
)
go

Create table ThanhPho
(
MaTP char(2) primary key,
TenTP nvarchar(50)
)
go

Create table Tour_TP
(
MaTour char(4) references Tour(MaTour),
MaTP char(2) references ThanhPho(MaTP),
SoNgay int,
Primary key (MaTour, MaTP)
)
go

Create table Lich_TourDL
(
MaTour char(4) references Tour(MaTour),
NgayKH datetime,
TenHDV nvarchar(30),
SoNguoi int,
TenKH nvarchar(30),
Primary key (MaTour, NgayKH)
)
go


---Xem các bảng
Select * from Tour
Select * from ThanhPho
Select * from Tour_TP
Select * from Lich_TourDL


------------NHẬP DỮ LIỆU---------
---Nhập bảng Tour
INSERT INTO Tour VALUES ('T001',3)
INSERT INTO Tour VALUES ('T002',4)
INSERT INTO Tour VALUES ('T003',5)
INSERT INTO Tour VALUES ('T004',7)
go

---Xem bảng Tour
Select * from Tour


---Nhập bảng ThanhPho
INSERT INTO ThanhPho VALUES ('01',N'Đà Lạt')
INSERT INTO ThanhPho VALUES ('02',N'Nha Trang')
INSERT INTO ThanhPho VALUES ('03',N'Phan Thiết')
INSERT INTO ThanhPho VALUES ('04',N'Huế')
INSERT INTO ThanhPho VALUES ('05',N'Đà Nẵng')
go

---Xem bảng Tour_TP
INSERT INTO Tour_TP VALUES ('T001','01',2)
INSERT INTO Tour_TP VALUES ('T001','03',1)

INSERT INTO Tour_TP VALUES ('T002','01',2)
INSERT INTO Tour_TP VALUES ('T002','02',2)

INSERT INTO Tour_TP VALUES ('T003','02',2)
INSERT INTO Tour_TP VALUES ('T003','01',1)
INSERT INTO Tour_TP VALUES ('T003','04',2)

INSERT INTO Tour_TP VALUES ('T004','01',1)
INSERT INTO Tour_TP VALUES ('T004','02',2)
INSERT INTO Tour_TP VALUES ('T004','05',2)
INSERT INTO Tour_TP VALUES ('T004','04',2)
go

--xem bảng Tour_TP
select * from Tour_TP


--nhap bang Lich_TourDL
SET DATEFORMAT DMY
GO

INSERT INTO Lich_TourDL VALUES ('T001','14/02/2017',N'Vân',20,N'Nguyễn Hoàng')
INSERT INTO Lich_TourDL VALUES ('T002','14/02/2017',N'Nam',30,N'Lê Ngọc')
INSERT INTO Lich_TourDL VALUES ('T002','06/03/2017',N'Hùng',20,N'Lý Dũng')
INSERT INTO Lich_TourDL VALUES ('T003','18/02/2017',N'Dũng',20,N'Lý Dũng')
INSERT INTO Lich_TourDL VALUES ('T004','18/02/2017',N'Hùng',30,N'Dũng Nam')
INSERT INTO Lich_TourDL VALUES ('T003','10/03/2017',N'Nam',45,N'Nguyễn An')
INSERT INTO Lich_TourDL VALUES ('T002','28/04/2017',N'Vân',25,N'Ngọc Dung')
INSERT INTO Lich_TourDL VALUES ('T004','29/04/2017',N'Dũng',35,N'Lê Ngọc')
INSERT INTO Lich_TourDL VALUES ('T001','30/04/2017',N'Nam',25,N'Trần Nam')
INSERT INTO Lich_TourDL VALUES ('T003','15/06/2017',N'Vân',20,N'Trịnh Bá')
go

--Xem bảng Lich_TourDL
Select * from Lich_TourDL

-----------II. TRUY VẤN DỮ LIỆU--------
--q1: Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày
Select *
From Tour
Where TongSoNgay between 3 and 5

--q2: Cho biết thông tin các tour tổ chức trong tháng 2 năm 2017
Select *
From Lich_TourDL
Where month(NgayKH) = 2 and year(NgayKH) = 2017

----q3: Cho biết các tour không đi qua thành phố Nha Trang
Select *
From Tour_TP
Where MaTP not in (
					Select MaTP
					From ThanhPho
					Where MaTP = '02'
)

--q4: Cho biết số lượng thành phố mà mỗi tour du lịch đi qua
Select MaTour, count(MaTP) as SoThanhPho
From Tour_TP
Group by MaTour

--q5: Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn
Select TenHDV, count(TenHDV) as SoLuongTour
From Lich_TourDL
Group by TenHDV

--q6: Cho biết tên thành phố có nhiều tour du lịch nhất
Select TP.TenTP
From ThanhPho TP
Join Tour_TP TT on TP.MaTP = TT.MaTP
Group by TP.TenTP
Having count(*) >= ALL
(
	Select count(*)
	From Tour_TP
	Group by MaTP
)

--q7: Cho biết thông tin tour du lịch đi qua nhiều thành phố nhất
Select *
From Lich_TourDL
Where MaTour in
(
	Select MaTour
	From Tour_TP
	Group by MaTour
	Having count(MaTP) = 
	(
		Select max(SoTP)
		From
		(	
			Select count(MaTP) as SoTP
			From Tour_TP
			Group by MaTour
		) SoTP
	)
)

--q8: Lập danh sách các tour đi qua thành phố 'Đà Lạt', thông tin hiển thị bao gồm Mã Tour, Số ngày
Select *
From Tour
Where MaTour in
(
	Select MaTour
	From Tour_TP
	Where MaTP = '01'
)

--q9: Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất
Select *
From Lich_TourDL
Where MaTour in
(
	Select max(SoLuongKhach)
	From
	(
		Select count(SoNguoi) as SoLuongKhach
		From Lich_TourDL
		Group by MaTour
	) SL
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