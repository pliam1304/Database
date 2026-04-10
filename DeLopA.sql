/*	Học phần: Cơ sở dữ liệu
	Bài: Quản lý thư viện
	SV:	Huỳnh Phúc Lâm
	MSSV: 2411869
	Lớp: CTK48B
*/

----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database QLThuVien
go
use QLThuVien
go

create table NhaXuatBan
(
	MANXB char(4) primary key,
	TenNXB nvarchar(50)
)
go

create table TheLoai
(
	MaTL char(2) primary key,
	TenTL nvarchar(50)
)
go

create table Sach
(
	MaSach char(6) primary key,
	TuaDe nvarchar(100),
	MANXB char(4) references NhaXuatBan(MANXB),
	TacGia nvarchar(50),
	SoLuong int,
	NgayNhap datetime,
	MaTL char(2) references TheLoai(MaTL)
)
go

create table BanDoc
(
	MaThe char(6) primary key,
	TenBanDoc nvarchar(50),
	DiaChi nvarchar(100),
	SoDT varchar(15)
)
go

create table MuonSach
(
	MaThe char(6),
	MaSach char(6),
	NgayMuon datetime,
	NgayTra datetime,
	primary key(MaThe, MaSach, NgayMuon),
	foreign key(MaThe) references BanDoc(MaThe),
	foreign key(MaSach) references Sach(MaSach)
)
go

------------------THỦ TỤC THÊM DỮ LIỆU------------------

go
create proc usp_ThemNXB
@manxb char(4), @ten nvarchar(50)
as
if exists(select * from NhaXuatBan where MANXB=@manxb)
	print N'Đã có NXB ' + @manxb
else
begin
	insert into NhaXuatBan values(@manxb,@ten)
	print N'Thêm NXB thành công'
end
go

go
create proc usp_ThemTheLoai
@matl char(2), @tentl nvarchar(50)
as
if exists(select * from TheLoai where MaTL=@matl)
	print N'Đã có thể loại ' + @matl
else
	insert into TheLoai values(@matl,@tentl)
go

go
create proc usp_ThemSach
@masach char(6), @tua nvarchar(100),
@manxb char(4), @tg nvarchar(50),
@sl int, @ngay datetime, @matl char(2)
as
if exists(select * from Sach where MaSach=@masach)
	print N'Trùng mã sách'
else
begin
	if exists(select * from NhaXuatBan where MANXB=@manxb)
	and exists(select * from TheLoai where MaTL=@matl)
	begin
		insert into Sach values(@masach,@tua,@manxb,@tg,@sl,@ngay,@matl)
		print N'Thêm sách thành công'
	end
	else
		print N'Lỗi khóa ngoại'
end
go

go
create proc usp_ThemBanDoc
@mathe char(6), @ten nvarchar(50), @dc nvarchar(100), @sdt varchar(15)
as
if exists(select * from BanDoc where MaThe=@mathe)
	print N'Trùng mã thẻ'
else
	insert into BanDoc values(@mathe,@ten,@dc,@sdt)
go

go
create proc usp_ThemMuonSach
@mathe char(6), @masach char(6),
@ngaymuon datetime, @ngaytra datetime
as
if exists(select * from BanDoc where MaThe=@mathe)
and exists(select * from Sach where MaSach=@masach)
begin
	insert into MuonSach values(@mathe,@masach,@ngaymuon,@ngaytra)
	print N'Thêm mượn sách thành công'
end
else
	print N'Lỗi dữ liệu'
go

------------------TRUY VẤN------------------

-- Thể loại chưa có sách
select TenTL
from TheLoai
where MaTL not in (select MaTL from Sach)

-- Sách được mượn nhiều nhất
select s.MaSach, TuaDe, TacGia, TenNXB,
count(ms.MaThe) as SoNguoiMuon
from Sach s
join MuonSach ms on s.MaSach = ms.MaSach
join NhaXuatBan n on s.MANXB = n.MANXB
group by s.MaSach, TuaDe, TacGia, TenNXB
having count(ms.MaThe) = 
(
	select max(SL)
	from (
		select count(*) as SL
		from MuonSach
		group by MaSach
	) t
)

-- Sách chưa ai mượn
select TuaDe
from Sach
where MaSach not in (select MaSach from MuonSach)

------------------HÀM------------------

go
create function fn_SoLuotMuon(@bd datetime, @kt datetime)
returns int
as
begin
	declare @tong int
	select @tong = count(*)
	from MuonSach
	where NgayMuon between @bd and @kt
	return @tong
end
go

------------------TRIGGER------------------

go
create trigger trg_NgayTra
on MuonSach
for insert, update
as
if exists(select * from inserted where NgayTra < NgayMuon)
begin
	raiserror(N'Ngày trả không hợp lệ!',16,1)
	rollback tran
end
go
