-- --------------------------------------------------------
-- Host:                         10.0.6.14
-- Server version:               10.4.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for misaca_developer2
CREATE DATABASE IF NOT EXISTS `authen` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `authen`;

-- Dumping structure for table misaca_developer2.activitylog
CREATE TABLE IF NOT EXISTS `activitylog` (
  `ActivityLogId` varchar(64) NOT NULL,
  `CAUserId` varchar(64) NOT NULL,
  `CAUserName` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `PartnerId` varchar(255) DEFAULT NULL,
  `DocumentId` varchar(64) DEFAULT NULL,
  `DocumentName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `Action` int(11) NOT NULL,
  `Activity` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `TimeStamp` datetime NOT NULL,
  `Status` int(11) NOT NULL,
  `ClientIp` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  UNIQUE KEY `ActivityLogId` (`ActivityLogId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.adminhistory
CREATE TABLE IF NOT EXISTS `adminhistory` (
  `AdminHistoryId` varchar(64) NOT NULL COMMENT 'Id của bảng',
  `AdminUserCAId` varchar(64) DEFAULT NULL COMMENT 'Id của admin truy cập và sử dụng hệ thống',
  `RequestId` varchar(64) DEFAULT NULL,
  `Action` int(11) DEFAULT NULL COMMENT 'Loại hành động : 0- Đăng nhập; 1- Đăng xuất; 2- Gọi xác minh; 3- Xác nhận; 4- Từ chối; 5-Duyệt',
  `TimeStamp` datetime DEFAULT NULL,
  `Note` longtext CHARACTER SET utf8mb4 NOT NULL COMMENT 'Ghi chú',
  `ClientIp` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AdminHistoryId`),
  UNIQUE KEY `AdminHistoryId` (`AdminHistoryId`),
  KEY `FK_AdminHistory_AdminUserCA` (`AdminUserCAId`),
  CONSTRAINT `FK_AdminHistory_AdminUserCA` FOREIGN KEY (`AdminUserCAId`) REFERENCES `adminuserca` (`AdminUserCAId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Lưu thông tin lịch sử truy cập của admin';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.adminroleca
CREATE TABLE IF NOT EXISTS `adminroleca` (
  `AdminRoleCAId` varchar(64) NOT NULL COMMENT 'Id của bảng liên kết giữa tài khoản admin và quyền',
  `AdminUserCAId` varchar(64) NOT NULL COMMENT 'Admin Id',
  `RoleCAId` varchar(64) NOT NULL COMMENT 'Quyền Id',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Trạng thái',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AdminRoleCAId`),
  UNIQUE KEY `AdminRoleCAId` (`AdminRoleCAId`),
  UNIQUE KEY `AdminUserCAId` (`AdminUserCAId`),
  UNIQUE KEY `RoleCAId` (`RoleCAId`),
  CONSTRAINT `FK_AdminRoleCA_RoleCA` FOREIGN KEY (`RoleCAId`) REFERENCES `roleca` (`RoleCAId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin liên kết giữa admin và các quyền của hệ thống';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.adminuserca
CREATE TABLE IF NOT EXISTS `adminuserca` (
  `AdminUserCAId` varchar(64) NOT NULL COMMENT 'Id của bảng Admin User',
  `MISAIdKey` varchar(64) DEFAULT NULL COMMENT 'Id phía MISA ID cung cấp nếu sử dụng dịch vụ của MISA ID',
  `UserName` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT 'UserName của Admin',
  `PhoneNumber` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại',
  `Email` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Email',
  `Status` int(10) unsigned NOT NULL COMMENT 'Trạng thái (0-Mới tạo, 1-Hoạt động, 2-Khóa)',
  `FullName` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Họ tên đầy đủ của admin',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`AdminUserCAId`),
  UNIQUE KEY `AdminUserCAId` (`AdminUserCAId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin tài khoản hệ thống admin của CA';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.application
CREATE TABLE IF NOT EXISTS `application` (
  `ApplicationId` varchar(64) NOT NULL COMMENT 'Id ứng dụng tích hợp hệ thốn MISA CA',
  `ApplicationName` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Tên ứng dụng tích hợp hệ thống MISA CA',
  `ApplicationCode` varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Mã ứng dụng tích hợp hệ thống MISA CA',
  `ApplicationType` tinyint(3) unsigned NOT NULL COMMENT 'Loại ứng dụng tích hợp MISA CA',
  `Description` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mô tả về ứng dụng tích hợp hệ thống MISA CA',
  `Scop` tinyint(3) unsigned DEFAULT NULL COMMENT 'Phạm vi ứng dụng tích hợp MISA CA, ở đây có thể thấy đến vd như có phải là phần mềm MISA hay không',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Trạng thái ứng dụng tích hợp MISA CA',
  `SecKey` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Key kết nối với ứng dụng MISA CA',
  `SecPassword` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Password kết nối hệ thống MISA CA',
  `CreatedDate` datetime NOT NULL COMMENT 'Thời gian tạo',
  `UpdatedDate` datetime DEFAULT NULL COMMENT 'Thời gian cập nhật',
  PRIMARY KEY (`ApplicationId`),
  UNIQUE KEY `ApplicationId` (`ApplicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin ứng dụng tích hợp CA';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.areasaleconfig
CREATE TABLE IF NOT EXISTS `areasaleconfig` (
  `AreaSaleConfigId` varchar(45) NOT NULL,
  `LocationPostalCode` varchar(45) DEFAULT NULL,
  `Province` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `District` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `WardOrCommune` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `OrderType` int(11) DEFAULT 0,
  `EmployeeCode` varchar(45) DEFAULT NULL,
  `EmployeeName` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `CreatedBy` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `ModifiedBy` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`AreaSaleConfigId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.caextend
CREATE TABLE IF NOT EXISTS `caextend` (
  `CaExtendId` varchar(64) CHARACTER SET latin1 NOT NULL,
  `CaId` varchar(64) CHARACTER SET latin1 DEFAULT NULL,
  `MisaIdKey` varchar(64) CHARACTER SET latin1 DEFAULT NULL,
  `PhoneNumber` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `Email` varchar(64) CHARACTER SET latin1 DEFAULT NULL,
  `FullName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Position` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `Status` int(11) DEFAULT NULL COMMENT 'Trạng thái : 0: Đang ủy quyền, 1: Đã ủy quyền, 2: Hủy ủy quyền',
  `IsDefaultCert` tinyint(3) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CaExtendId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.caextendinfo
CREATE TABLE IF NOT EXISTS `caextendinfo` (
  `CAExtendInfoId` varchar(64) NOT NULL COMMENT 'Khóa chính của bảng',
  `CAUserId` varchar(64) DEFAULT NULL COMMENT 'Id của bảng user (Chỉ khi có chứng thư - Khi yêu cầu sang ESignCloud thành công mới có trường này)',
  `CAId` longtext CHARACTER SET utf8mb4 NOT NULL COMMENT 'Id của chứng thư, đẩy sang ESignCloud (Trường này cần thiết, khi người dùng thu hôi 1 chứng thư sau lại yêu cầu cấp mới một chứng thư khác thì có thể sẽ dùng trường này)',
  `ServiceCode` longtext CHARACTER SET utf8mb4 NOT NULL COMMENT 'Mã gói dịch vụ của chứng thư',
  `CAStatus` varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Trạng thái chứng thư (nhớ bao gồm cả trạng thái yêu cầu thành công sang ESignCloud)',
  `CAType` int(11) NOT NULL COMMENT 'Loại chứng thư (0-Doanh nghiệp, 1-Cá nhân, 2-Cá nhân thuộc doanh nghiệp)',
  `CertificateSN` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số serial number, để trường này có thể null vì khi yêu cầu cấp chứng thư thành công thì vẫn chưa tạo chứng thư ngay, vì vậy lúc này sẽ không có trường này',
  `CertificateID` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Id của chứng thư lưu lên TMS RA',
  `EffectiveTime` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Thời gian chứng thư có hiệu lực',
  `ExpirationTime` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Thời gian chứng thư hết hiệu lực',
  `TaxCode` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mã số thuế doanh nghiệp (Chứng thư doanh nghiệp)',
  `BudgetCode` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mã ngân sách doanh nghiệp (Chứng thư số doanh nghiệp)',
  `IdentityId` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số chứng minh thư nhân dân (Chứng thư cá nhân/cá nhân thuộc doanh nghiệp)',
  `Passport` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mã hộ chiếu (Chứng thư cá nhân hoặc cá nhận thuộc doanh nghiệp)',
  `PersonalName` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên cá nhân (Chứng thư cá nhân hoặc cá nhận thuộc doanh nghiệp)',
  `CompanyName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên doanh nghiệp (Chứng thư số doanh nghiệp)',
  `PhoneContact` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại liên hệ (Dùng cho cả 3 loại chứng thư)',
  `EmailContact` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Email liên hệ, (Dùng cho các 3 loại chứng thư)',
  `BussinessDocumentId` varchar(64) DEFAULT NULL COMMENT 'ID của ảnh giáy phép kinh doanh hoặc giấy phép đăng ký doanh nghiệp (Dùng cho chứng thư doanh nghiệp)',
  `PersonalDocumentId` varchar(64) DEFAULT NULL COMMENT 'ID của chứng minh thư nhân dân (Dùng cho cả 2 loại  cá nhân, cá nhân thuộc doanh nghiệp)',
  `Address` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Địa chỉ công ty hoặc địa chỉ của cá nhân (Dùng cho cả 3 loại chứng thư)',
  `DistrictName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên quận huyện(Dùng cho cả 3 loại chứng thư)',
  `ProviceName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên tỉnh, thành phố (Dùng cho cả 3 loại chứng thư)',
  `Country` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên quốc gia, mặc định là VN (Dùng cho cả 3 loại chứng thư)',
  `PersonalCompanyName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên công ty (Dùng cho chứng thư số cá nhân thuộc doanh nghiệp)',
  `PersonalCompanyPosition` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Vị trí của cá nhân trong doanh nghiệp (Dùng cho chứng thư số cá nhân thuộc doanh nghiệp)',
  `RepresentativeName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên người đại diện (Dùng cho chứng thư số doanh nghiệp)',
  `RepresentativePosition` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Chức vụ của người đại diện',
  `RepresentativeIdentityNumber` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số chứng minh thư nhân dân của người đại diện',
  `RepresentativePassport` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mã hộ chiếu của người đại diện',
  `RepresentativeDocumentId` varchar(64) DEFAULT NULL COMMENT 'Mã tài liệu (chứng minh thư của người đại diện)',
  `RepresentativePhoneNumber` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại người đại diện',
  `RepresentativeEmail` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Email của người đại diện',
  `AppointPositionDucumentId` varchar(255) DEFAULT NULL,
  `CreatedDate` datetime NOT NULL COMMENT 'Thời gian tạo',
  `UpdatedDate` datetime DEFAULT NULL COMMENT 'Thời gian cập nhật',
  PRIMARY KEY (`CAExtendInfoId`),
  UNIQUE KEY `CAExtendInfoId` (`CAExtendInfoId`),
  UNIQUE KEY `BussinessDocumentId` (`BussinessDocumentId`),
  UNIQUE KEY `PersonalDocumentId` (`PersonalDocumentId`),
  UNIQUE KEY `RepresentativeDocumentId` (`RepresentativeDocumentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin mở rộng của chứng thư (Dùng để lưu một số thông tin chứng thư của người dùng khi API của RA hay ESignCloud không trả về hoặc không lấy được )';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.caorder
CREATE TABLE IF NOT EXISTS `caorder` (
  `CAOrderId` varchar(64) NOT NULL,
  `RequestId` varchar(64) DEFAULT NULL COMMENT 'Bổ sung trường để đáp ứng nghiệp vụ mua nhiều hơn 3 năm, một request tương ứng nhiều Order',
  `PackCode` varchar(50) DEFAULT NULL,
  `MisaOrderId` varchar(64) DEFAULT NULL,
  `OrderDetailID` varchar(64) DEFAULT NULL,
  `OrderNo` varchar(64) NOT NULL,
  `OrderType` int(11) NOT NULL,
  `PaymentMethod` int(11) NOT NULL,
  `PaymentState` int(11) NOT NULL,
  `ServiceCode` varchar(64) NOT NULL,
  `ServiceId` varchar(64) DEFAULT NULL,
  `Amount` decimal(18,2) DEFAULT NULL,
  `Email` varchar(64) DEFAULT NULL,
  `PhoneNumber` varchar(64) DEFAULT NULL,
  `FullName` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CAOrderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.causer
CREATE TABLE IF NOT EXISTS `causer` (
  `CAUserId` varchar(64) NOT NULL COMMENT 'Id của bảng khách hàng',
  `MISAIdKey` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Id phía MISA cung cấp nếu tài khoản kết đăng ký bằng MISA Id',
  `CAId` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Id của chứng thư tương ứng với người dùng',
  `CAStatus` tinyint(3) unsigned DEFAULT NULL COMMENT 'Trạng thái CA ( 0-chưa yêu cầu cấp chứng thư, 1- đã yêu cầu cấp CA nhưng chưa thanh toán/chưa thành công, 2-yêu cầu cấp CA thành công, 3-admin xác minh yêu cầu cấp CA, 4-admin đã xác minh chờ duyệt, 5-admin cấp 2 đã duyệt, 6-admin cấp 2 từ chối yêu cầu, 7-yêu cầu cấp CA đã gửi thành công sang Esign, 8-yêu cầu gửi sang Esign thất bại, 9-chứng thư đã được xác nhận, 10-chứng thư đang hoạt động, 11-chứng thư hết hạn, 12-chứng thư đã bị thu hồi)',
  `UserName` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'UseName của người dùng',
  `PasswordHash` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Hash mật khẩu của người dùng',
  `PhoneNumber` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại',
  `Email` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Email',
  `Status` tinyint(3) unsigned DEFAULT NULL COMMENT 'Trạng thái : 0 default, 1 Đã đăng ký MisaID, 2 Đã kích hoạt MisaID, 3 MisaID từ chối do đã tồn tại',
  `FullName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên đầy đủ',
  `Avatar` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Ảnh đại diện',
  `PaymentState` int(11) DEFAULT 0,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CAUserId`),
  UNIQUE KEY `CAUserId` (`CAUserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin người dùng cuối của ứng dụng CA';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.causerhistory
CREATE TABLE IF NOT EXISTS `causerhistory` (
  `CAUserHistoryId` varchar(64) NOT NULL,
  `CAUserId` varchar(64) DEFAULT NULL COMMENT 'Id của user thực hiện',
  `Description` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mô tả yêu cầu',
  `HistoryType` tinyint(3) unsigned NOT NULL COMMENT 'Loại lịch sử (0-Yêu cầu đẩy nhanh, 1-Xác nhận thông tin chứng thư,-...)',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`CAUserHistoryId`),
  UNIQUE KEY `CAUserHistoryId` (`CAUserHistoryId`),
  KEY `FK_CAUserHistory_CAUser` (`CAUserId`),
  CONSTRAINT `FK_CAUserHistory_CAUser` FOREIGN KEY (`CAUserId`) REFERENCES `causer` (`CAUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Lịch sử hoạt động (ký, yêu cầu...) của người dùng';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.certinfo
CREATE TABLE IF NOT EXISTS `certinfo` (
  `CAId` varchar(64) NOT NULL,
  `CertSn` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `CertName` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `CertNumber` varchar(255) DEFAULT NULL,
  `UId` varchar(45) DEFAULT NULL,
  `CaStatus` int(11) DEFAULT NULL,
  `IsDefaultCert` tinyint(3) DEFAULT NULL,
  `MisaIdKey` varchar(45) DEFAULT NULL,
  `EffectiveTime` varchar(64) DEFAULT NULL,
  `ExpirationTime` varchar(64) DEFAULT NULL,
  `ContractTime` varchar(64) DEFAULT NULL,
  `CaType` int(11) DEFAULT NULL,
  `CaRemark` int(11) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `IsLock` tinyint(4) DEFAULT NULL,
  `DataKey` longtext DEFAULT NULL,
  `ActiveState` int(11) DEFAULT NULL COMMENT 'Trạng thái kích hoạt chứng thư: 0: Đã kích hoạt , Mặc định null là chưa kích hoạt',
  `CertificateId` varchar(64) DEFAULT NULL COMMENT 'Lưu thông tin Id của usb token khi call đăng ký cấp chứng thư từ RA',
  `RequestCertType` int(11) DEFAULT 0 COMMENT 'Loại yêu cầu chứng thư: \\\\\\\\\\\\\\\\n0: Remote Cert\\\\\\\\\\\\\\\\n1: USB Cert (Dùng chung cho cả CertInfo và Request để phân biệt được loại chứng thư và loại yêu cầu cấp chứng thư)',
  `IsAcceptPolicy` int(11) DEFAULT 0,
  `TokenSn` varchar(45) DEFAULT NULL,
  `ActivationCode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CAId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.contact
CREATE TABLE IF NOT EXISTS `contact` (
  `ContactId` varchar(64) NOT NULL COMMENT 'Id của bẳng liên hệ',
  `CAUserId` varchar(64) DEFAULT NULL,
  `Email` varchar(128) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Email của liên hệ',
  `PhoneNumber` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại của liên hệ',
  `Name` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Trạng thái',
  `CreatedDate` datetime DEFAULT NULL COMMENT 'Thời gian tạo',
  `CreatedBy` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Người tạo',
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ContactId`),
  UNIQUE KEY `ContactId` (`ContactId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Danh sách liên hệ yêu cầu ký, nhận yêu cầu ký';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.device
CREATE TABLE IF NOT EXISTS `device` (
  `DeviceId` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Id của thiết bị',
  `CAUserId` varchar(64) DEFAULT NULL COMMENT 'Id của khách hàng',
  `DeviceType` int(11) NOT NULL COMMENT 'Loại thiết bị: 0-IOS; 1-Android',
  `Description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`DeviceId`),
  KEY `FK_Device_CAUser1` (`CAUserId`),
  CONSTRAINT `FK_Device_CAUser1` FOREIGN KEY (`CAUserId`) REFERENCES `causer` (`CAUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin các thiết bị mobile nhận notifications từ hệ thống';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.document
CREATE TABLE IF NOT EXISTS `document` (
  `DocumentId` varchar(64) NOT NULL COMMENT 'Id của tài liệu',
  `DocumentState` int(11) NOT NULL COMMENT '0-Mới up, 1-Đang ký, 2-Đã ký',
  `DocumentType` int(11) NOT NULL COMMENT 'Loại tài liệu: 0- Tài liệu ký; 1-Lịch sử gọi xác minh;2-Tài liệu chứng minh thư, giấy  đăng ký kinh doanh; 3-Tài liệu chứng minh bằng văn bản nêu lí do yêu cầu thu hồi chứng thư; 5- Đơn yêu cầu thu hồi CTS',
  `ObjectId` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'ObjectId nếu lưu trong hệ thống MISA Storage',
  `BucketName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên bucket mà tài liệu được lưu trong MISA Storage',
  `IsDeleted` int(11) DEFAULT 0,
  `Url` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Đường dẫn Url nếu tài liệu được lưu trong thư mục',
  `DocumentName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên tài liệu',
  `Description` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mô tả tài liệu',
  `CAUserId` varchar(64) DEFAULT NULL,
  `ApplicationId` varchar(64) DEFAULT NULL,
  `FolderId` varchar(64) DEFAULT NULL COMMENT 'Id của thư mục',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`DocumentId`),
  UNIQUE KEY `DocumentId` (`DocumentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Lưu trữ thông tin tài liệu mà người dùng ứng dụng upload lên để ký, tài liệu được yêu cầu ký từ các ứng dụng, hay là các thông tin về các video call lịch sử';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.documentcontact
CREATE TABLE IF NOT EXISTS `documentcontact` (
  `DocumentContactId` varchar(64) NOT NULL COMMENT 'Id của bảng, vì có thể có trường hợp tài liệu không yêu cầu cai ký nên không thể để hai khóa của 2 vảng liên quan là khóa chính',
  `ContactId` varchar(64) NOT NULL COMMENT 'Id của người ký lên tài liệu, có thể null vì có thể tài liệu không yêu cầu ai ký',
  `DocumentId` varchar(64) NOT NULL COMMENT 'Id của tài liệu được ký',
  `SignPosition` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Vị trí ký của người được assign (có thể có nhiều vị trí). Data được lưu dạng mảng các object đã được convert sang string',
  `IsDeleted` int(11) DEFAULT 0,
  `Note` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Ghi chú về yêu cầu ký',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Trạng thái thể hiện người liên hệ đã ký tài liệu chưa : -1 nháp ; 0-Mới tạo; 1- Đang xử lú, 2-Đã ký\r\n',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`DocumentContactId`),
  UNIQUE KEY `DocumentContactId` (`DocumentContactId`),
  KEY `FK_DocumentContact_Contact` (`ContactId`),
  KEY `FK_DocumentContact_Document` (`DocumentId`),
  CONSTRAINT `FK_DocumentContact_Contact` FOREIGN KEY (`ContactId`) REFERENCES `contact` (`ContactId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DocumentContact_Document` FOREIGN KEY (`DocumentId`) REFERENCES `document` (`DocumentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin những người được yêu cầu ký trong tài liệu';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.documentusersignature
CREATE TABLE IF NOT EXISTS `documentusersignature` (
  `DocumentUserSignatureId` char(10) CHARACTER SET utf8mb4 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.enterpriesinfo
CREATE TABLE IF NOT EXISTS `enterpriesinfo` (
  `EnterpriseInfoId` varchar(64) NOT NULL COMMENT 'Id của bảng thông tin doanh nghiệp đăng ký chứng thư',
  `EnterpriseInfoStatus` int(11) DEFAULT NULL COMMENT 'Trạng thái thông tin đăng ký doanh nghiệp đã được xác minh chư (0-Chưa xác minh, 1-Đang xác minh, 2-Đã xác minh)',
  `DocumentType` int(11) NOT NULL COMMENT 'Loại giấy phép (0-Đăng ký kinh doanh, 1-Chứng nhận đầu tư, 2- Quyết định thành lập)',
  `ObjectId` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Object id lưu thông tin giấy phép đăng ký trên MISA Storage',
  `BucketName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'BucketName lưu thông tin giấy phép đăng ký trên MISA Storage',
  `Url` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Url lưu giấy phép trong trường hợp lưu tài liệu trên thư mục của server',
  `TaxNo` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mã số thuế',
  `BudgetCode` varchar(45) DEFAULT NULL,
  `CompanyName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên công ty/tổ chức',
  `DistrictName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên quận huyện',
  `ProviceName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên tỉnh thành phố',
  `Country` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên quốc gia',
  `Mobile` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại',
  `Email` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Địa chỉ email',
  `CompanyAddress` longtext DEFAULT NULL,
  `RepresentativeName` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên người đại diện',
  `RepresentativeStatus` int(11) DEFAULT NULL COMMENT 'Trạng thái thông tin người đại diện đã được xác minh chứa (0-Chưa xác minh, 1-Đang xác minh, 2-Đã xác minh)',
  `RepresentativePosition` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Chức vụ của người đại diện',
  `RepresentativeDocuType` int(11) DEFAULT NULL COMMENT 'Loại giấy tờ của người đại diện (0-CMT, 1-Hộ chiếu)',
  `RepresentativeNumber` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số giấy tờ của người đại điện ứng với loại giấy tờ',
  `RepresentativeObjectId` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'ObjectId lưu giấy tờ của người đại diện trên MISA Storage',
  `RepresentativeBucketName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'BucketName lưu giấy từ của người đại diện trên MISA Storage',
  `RepresentativeUrl` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Url lưu giấy tờ của người đại diện trên thư mục của Server',
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `ServiceId` varchar(64) DEFAULT NULL COMMENT 'Thông tin đăng ký ứng với gói dịch vụ nào',
  `RepresentativePhoneNumber` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại của người đại diện',
  `RepresentativeEmail` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Email của người đại diện',
  `AppointPositionObjectId` varchar(255) DEFAULT NULL COMMENT 'ObjectId lưu giấy tờ bổ nhiệm (đối với cá nhân thuộc doanh nghiệp)',
  `AppointPositionBucketName` varchar(255) DEFAULT NULL COMMENT 'BucketNam lưu giấy bổ nhiệm (đối với cá nhân thuộc doanh nghiệp)',
  `AppointPositionUrl` varchar(255) DEFAULT NULL,
  `RepresentativeDistrictName` varchar(255) DEFAULT NULL,
  `RepresentativeProviceName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`EnterpriseInfoId`),
  UNIQUE KEY `EnterpriseInfoId` (`EnterpriseInfoId`),
  KEY `FK_EnterpriesInfo_Service` (`ServiceId`),
  CONSTRAINT `FK_EnterpriesInfo_Service` FOREIGN KEY (`ServiceId`) REFERENCES `service` (`ServiceId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Thông tin doanh nghiệp yêu cầu đăng ký CA';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.folder
CREATE TABLE IF NOT EXISTS `folder` (
  `FolderId` varchar(64) NOT NULL,
  `FolderName` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `FolderUrl` longtext CHARACTER SET utf8mb4 NOT NULL COMMENT 'Đường dẫn của folder trên ứng dụng',
  `CAUserId` varchar(64) DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`FolderId`),
  UNIQUE KEY `FolderId` (`FolderId`),
  KEY `FK_Folder_CAUser` (`CAUserId`),
  CONSTRAINT `FK_Folder_CAUser` FOREIGN KEY (`CAUserId`) REFERENCES `causer` (`CAUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng sử dụng để gom nhóm tài liệu trên ứng dụng mobile';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.hardprofile
CREATE TABLE IF NOT EXISTS `hardprofile` (
  `HardProfileId` varchar(64) NOT NULL,
  `RequestId` varchar(64) NOT NULL,
  `IsReceivedProfile` bit(1) NOT NULL DEFAULT b'0',
  `CreatedBy` varchar(64) DEFAULT NULL,
  `ModifiedBy` varchar(64) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`HardProfileId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.historycallvideo
CREATE TABLE IF NOT EXISTS `historycallvideo` (
  `HistoryCallVideoId` varchar(64) NOT NULL COMMENT 'Id của bảng',
  `CAUserId` varchar(64) DEFAULT NULL COMMENT 'Id của tài khoản khách hàng được gọi video call',
  `AdminUserCAId` varchar(64) DEFAULT NULL COMMENT 'Id của admin gọi video call cho khách hàng',
  `AdminUserName` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL,
  `DocumentId` varchar(64) DEFAULT NULL COMMENT 'Dùng để lưu lịch sử video call',
  `RequestId` varchar(64) DEFAULT NULL COMMENT 'Id của yêu cầu, nơi mà cần admin gọi video xác nhận cho khách hàng',
  `VideoName` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên của video',
  `Description` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mô tả video',
  `CreatedDate` datetime NOT NULL COMMENT 'Thời gian tạo',
  `UpdatedDate` datetime DEFAULT NULL COMMENT 'Thời gian cập nhật',
  PRIMARY KEY (`HistoryCallVideoId`),
  UNIQUE KEY `HistoryCallVideoId` (`HistoryCallVideoId`),
  KEY `FK_HistoryCallVideo_CAUser` (`CAUserId`),
  CONSTRAINT `FK_HistoryCallVideo_CAUser` FOREIGN KEY (`CAUserId`) REFERENCES `causer` (`CAUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu lại lịch gửi gọi video';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.integrationapplication
CREATE TABLE IF NOT EXISTS `integrationapplication` (
  `IntegrationApplicationId` varchar(64) NOT NULL COMMENT 'Id của bảng',
  `CertId` varchar(64) NOT NULL COMMENT 'Id của tài khoản kết nối',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Mô tả trạng thái tài khoản ứng dụng mobile kết nối với các hệ thống (0. Default kết nối nhận thông báo, 1. Kết nối tắt thông báo, 2. Ngắt kết nối)',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `AuthorizeType` int(11) DEFAULT NULL,
  `ApplicationCode` varchar(64) NOT NULL,
  PRIMARY KEY (`IntegrationApplicationId`),
  UNIQUE KEY `IntegrationApplicationId` (`IntegrationApplicationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin mà ứng dụng của người dùng tích hợp với hệ thống nào';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.notification
CREATE TABLE IF NOT EXISTS `notification` (
  `NotificationId` varchar(64) NOT NULL COMMENT 'Id của thông báo',
  `RequestId` varchar(64) DEFAULT NULL,
  `DocumentId` varchar(64) DEFAULT NULL COMMENT 'Id của tài liệu cần ký, dùng cho các thông báo yêu cầu ký tài liệu',
  `CAUserId` varchar(64) DEFAULT NULL COMMENT 'Tài khoản nhận thông báo',
  `NotificationType` tinyint(3) unsigned NOT NULL COMMENT 'Loại thông báo (0-Thông báo chung của ứng dụng, 1-Thông báo yêu cầu ký tài liệu, 2- Thông báo liên quan đến các nghiệp vụ của ứng dụng như sắp hết hạn CA, thu hồi CA)',
  `Description` longtext CHARACTER SET utf8mb4 NOT NULL COMMENT 'Mô tả chi tiết về thông báo',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Trạng thái của thông báo (0-Mới tạo,1-Đã xem, 2-Đánh dấu là quan trọng, 3-Hết hạn xử lý, 4. Đã xóa)',
  `ExpTime` varbinary(8) DEFAULT NULL COMMENT 'Thời hạn hết hạn của thông báo',
  `CreatedDate` datetime NOT NULL,
  `UpdatetedDate` datetime DEFAULT NULL,
  `RefId` varchar(255) DEFAULT NULL COMMENT 'Id của bảng liên kết để xem chi tiết Notification có đủ các thông tin ứng với từng loại Notification khách nhau',
  PRIMARY KEY (`NotificationId`),
  UNIQUE KEY `NotificationId` (`NotificationId`),
  KEY `FK_Notification_CAUser` (`CAUserId`),
  CONSTRAINT `FK_Notification_CAUser` FOREIGN KEY (`CAUserId`) REFERENCES `causer` (`CAUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin thông báo yêu cầu ký tài liệu từ các hệ thống mà ứng dụng mobile kết nối';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.personalinfo
CREATE TABLE IF NOT EXISTS `personalinfo` (
  `PersonalInfoId` varchar(64) NOT NULL COMMENT 'Id của bảng thông tin tài khoản cá nhân đăng ký chứng thư',
  `PersonalInfoStatus` int(11) DEFAULT NULL COMMENT 'Trạng thái thông tin cá nhân đăng ký chứng thư đã được xác minh chưa (0-Chưa xác minh, 1-Đang xác minh, 2-Đã xác minh)',
  `DocumentType` int(11) NOT NULL COMMENT 'Loại giấy phép (0-CMTND, 2-hộ chiếu, 1- thẻ căn cước)',
  `ObjectId` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Id của object nếu lưu giấy tờ trên MISA Storage',
  `BucketName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên của bucket nếu lưu giấy tờ trên MISA Storage',
  `Url` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Đường dẫn lưu giấy tờ nếu lưu trên thư mục của server',
  `DocumentNumber` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số chứng minh thư nhân dân 0, hoặc số hộ chiếu 1',
  `PersonalName` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Tên người đăng ký',
  `CompanyName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Tên công ty',
  `CompanyEmployee` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Vị trí công việc',
  `DistrictName` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Tên quận huyện',
  `ProviceName` varchar(255) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Tên tỉnh, thành phố',
  `Mobile` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Số điện thoại',
  `Email` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Email',
  `Country` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Tên quốc gia',
  `CreatedDate` datetime NOT NULL,
  `UpdateDate` datetime DEFAULT NULL,
  `ServiceId` varchar(64) DEFAULT NULL COMMENT 'Tông tin đăng ký ứng với gói dịch vụ nào',
  PRIMARY KEY (`PersonalInfoId`),
  UNIQUE KEY `PersonalInfoId` (`PersonalInfoId`),
  KEY `FK_PersonalInfo_Service` (`ServiceId`),
  CONSTRAINT `FK_PersonalInfo_Service` FOREIGN KEY (`ServiceId`) REFERENCES `service` (`ServiceId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Thông tin cá nhân yêu cầu đăng ký CA';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.request
CREATE TABLE IF NOT EXISTS `request` (
  `RequestId` varchar(64) NOT NULL COMMENT 'Id của bảng yêu cầu',
  `CAUserId` varchar(64) DEFAULT NULL COMMENT 'Dùng khi người dùng yêu cầu cấp mới chứng thư',
  `AdminUserCAId` varchar(64) DEFAULT NULL COMMENT 'Dùng khi admin tạo yêu cầu thu hồi chứng thư',
  `RequestType` tinyint(3) unsigned NOT NULL COMMENT 'Loại yêu cầu(0-Yêu cầu cấp mới chứng thư, 1-Yêu cầu thu hồi chứng thư, 2-Yêu cầu thay đổi thông tin chứng thư, 3-Yêu cầu gia hạn chứng thư)',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Trạng thái của yêu cầu (0-Mới tạo, 1-Đang xử lý, 2-Chờ duyệt, 3-Duyệt yêu cầu, 4-Từ chối yêu cầu,5-Xác nhận từ khách hàng, 6-Cấp chứng thư thành công, 7-Cấp chứng thư thất bại, 8-Đã thu hồi chứng thư)',
  `Description` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mô tả về yêu cầu',
  `PersonalInfoId` varchar(64) DEFAULT NULL COMMENT 'Id của thông tin cá nhân yêu cầu cấp mới chứng thư',
  `EnterpriseInfoId` varchar(64) DEFAULT NULL COMMENT 'Id của thông tin doanh nghiệp yêu cầu cấp mới chứng thư',
  `ServiceId` varchar(64) DEFAULT NULL COMMENT 'Id của gói dịch vụ',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `PaymentMethod` int(11) DEFAULT NULL COMMENT 'Phương thức thanh toán ( 0- ATM, 1-bằng thẻ quốc tế, 2-chuyển khoản)',
  `PaymentState` int(11) DEFAULT NULL COMMENT 'Trạng thái thanh toán (0 - Mới tạo, 1 - chờ xử lý, 2 - Đã thanh toán)',
  `MisaOrderId` varchar(64) DEFAULT NULL,
  `OrderDetailID` varchar(64) DEFAULT NULL,
  `OrderNo` varchar(64) DEFAULT NULL,
  `IsReceivedProfile` int(11) DEFAULT NULL COMMENT 'Trạng thái hồ sơ đã nộp hồ sơ bản cứng hay chưa',
  `MISAIdKey` varchar(45) DEFAULT NULL,
  `PackCode` varchar(45) DEFAULT NULL,
  `ContractTerm` varchar(45) DEFAULT NULL,
  `CAId` varchar(45) DEFAULT NULL,
  `RequestStatus` int(11) DEFAULT NULL,
  `TaxCode` varchar(50) DEFAULT NULL,
  `PromotionCode` varchar(50) DEFAULT NULL,
  `EsignCerName` varchar(255) DEFAULT NULL,
  `PromotionMonth` int(11) DEFAULT NULL,
  `SaleAreaCode` varchar(45) DEFAULT NULL,
  `StaffCode` varchar(45) DEFAULT NULL,
  `StaffName` varchar(255) DEFAULT NULL,
  `StaffPhone` varchar(45) DEFAULT NULL,
  `StaffContact` varchar(255) DEFAULT NULL,
  `BuyerName` varchar(255) DEFAULT NULL,
  `BuyerPhone` varchar(45) DEFAULT NULL,
  `BuyerEmail` varchar(255) DEFAULT NULL,
  `IsAcceptPolicy` int(11) DEFAULT 0,
  `TimeAdjournSubmitHardProfile` datetime DEFAULT NULL COMMENT 'Thời gian khách hàng gia hạn để nộp hồ sơ bản cứng',
  `DataKey` longtext DEFAULT NULL,
  `MethodApprove` int(11) DEFAULT NULL COMMENT 'Phương thức duyệt: 0: Tổng quan, 1: Chi tiết',
  `StorageStatus` int(11) DEFAULT NULL,
  `BuyerAddress` varchar(255) DEFAULT NULL,
  `USBQuantity` int(11) DEFAULT 0,
  `RequestCertType` int(11) DEFAULT 0 COMMENT 'Loại yêu cầu chứng thư: \\\\\\\\n0: Remote Cert\\\\\\\\n1: USB Cert (Dùng chung cho cả CertInfo và Request để phân biệt được loại chứng thư và loại yêu cầu cấp chứng thư)',
  `TimeSentUSB` datetime DEFAULT NULL,
  `TimeReceivedUSB` datetime DEFAULT NULL,
  `CertQuantity` int(11) DEFAULT 0,
  `TotalPaidAmount` decimal(18,2) DEFAULT NULL,
  `DeclineReasons` longtext DEFAULT NULL,
  `ActiveProfile` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`RequestId`),
  UNIQUE KEY `RequestId` (`RequestId`),
  KEY `FK_Request_CAUser` (`CAUserId`),
  CONSTRAINT `FK_Request_CAUser` FOREIGN KEY (`CAUserId`) REFERENCES `causer` (`CAUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu danh sách yêu cầu admin ca cần xử lý';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.requestcertificatedocument
CREATE TABLE IF NOT EXISTS `requestcertificatedocument` (
  `RequestCeriticateDocumentId` varchar(64) COLLATE utf8_bin NOT NULL,
  `RequestId` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Id của request yêu cầu cấp chứng thư',
  `FileName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ObjectId` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BucketName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `Type` int(11) NOT NULL COMMENT 'Loại tài liệu: 0- Hồ sơ bản cứng , 1- Hồ sơ bản mềm, 2- Đơn yêu cầu',
  `Status` int(11) NOT NULL COMMENT 'Trạng thái hồ sơ: 0-Chưa ký số/Chưa nộp, 1-Đã ký số/Đã nộp',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `TimeConfirmRegister` datetime DEFAULT NULL,
  PRIMARY KEY (`RequestCeriticateDocumentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.requestcertinfo
CREATE TABLE IF NOT EXISTS `requestcertinfo` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RequestId` varchar(64) COLLATE utf8_bin NOT NULL,
  `CertInfoId` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=996 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.roleca
CREATE TABLE IF NOT EXISTS `roleca` (
  `RoleCAId` varchar(64) NOT NULL COMMENT 'Id của bảng quyền hạn',
  `RoleCode` varchar(50) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Mã quyền (VD: ADMIN/USER)',
  `RoleName` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT 'Tên quyền',
  `Status` tinyint(3) unsigned NOT NULL COMMENT 'Trạng thái',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`RoleCAId`),
  UNIQUE KEY `RoleCAId` (`RoleCAId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.salesinfo
CREATE TABLE IF NOT EXISTS `salesinfo` (
  `SalesInfoId` varchar(64) NOT NULL COMMENT 'Id của bảng khuyến mãi',
  `ServiceId` varchar(64) NOT NULL COMMENT 'Id gói dịch vụ được khuyến mãi',
  `SalesPercent` decimal(4,2) DEFAULT NULL COMMENT 'Tỉ lệ khuyến mãi (VD: 10, 15% ~ 0,1 or 0,15)',
  `SalesAmount` decimal(8,2) DEFAULT NULL COMMENT 'Số tiền khuyến mãi',
  `BonusInfo` longtext CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Thông tin khuyến mãi thêm',
  `Description` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`SalesInfoId`),
  UNIQUE KEY `SalesInfoId` (`SalesInfoId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.service
CREATE TABLE IF NOT EXISTS `service` (
  `ServiceId` varchar(64) NOT NULL COMMENT 'Id của bảng gói dịch vụ',
  `PackCode` varchar(64) DEFAULT NULL,
  `ServiceCode` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mã gói dịch vụ',
  `Entity` int(11) NOT NULL COMMENT 'Loại chứng thư (0-Doanh nghiệp, 1-Cá nhân, 2-Cá nhân thuộc doanh nghiệp)',
  `Remark` int(11) NOT NULL COMMENT 'Thời hạn (1 năm, 2 năm, 3 năm), theo quy định thì chứng thư sẽ cấp theo năm và tối đa là 3 năm',
  `Amount` decimal(18,2) NOT NULL COMMENT 'Giá của gói dịch vụ',
  `UpdatedDate` datetime DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  PRIMARY KEY (`ServiceId`),
  UNIQUE KEY `ServiceId` (`ServiceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Bảng lưu thông tin về các gói dịch vụ mà CA cung cấp';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.signtransaction
CREATE TABLE IF NOT EXISTS `signtransaction` (
  `id` varchar(64) CHARACTER SET latin1 NOT NULL,
  `BillCode` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `Status` int(11) DEFAULT NULL COMMENT '0-Chờ xử lý\n1-Ký thành công\n2-Ký thất bại\n3-Không được duyệt để ký (Hết hạn)',
  `SignatureValue` longtext DEFAULT NULL,
  `X509SubjectName` longtext DEFAULT NULL,
  `X509Certificate` longtext DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  `CertId` varchar(64) NOT NULL,
  `DataHash` longtext NOT NULL,
  `TransactionCode` varchar(255) NOT NULL,
  `Application` varchar(255) DEFAULT NULL,
  `AuthReq` longtext DEFAULT NULL COMMENT 'Authorization Request trả về từ eSignCloud để Mobile sử dụng KAK tính toán để truyền SAD lên xác nhận ký',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.tokeninfo
CREATE TABLE IF NOT EXISTS `tokeninfo` (
  `TokenId` int(11) NOT NULL AUTO_INCREMENT,
  `TokenSn` varchar(45) COLLATE utf8_bin NOT NULL,
  `Status` int(10) unsigned DEFAULT 0,
  `CreatedDate` datetime DEFAULT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`TokenId`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bảng lưu thông tin Token';

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.transactionlog
CREATE TABLE IF NOT EXISTS `transactionlog` (
  `TransactionId` varchar(64) NOT NULL,
  `BankRefId` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'Mã đối chiếu giao dịch với bên ngân hàng',
  `CAuserId` varchar(64) DEFAULT NULL,
  `RequestId` varchar(64) DEFAULT NULL,
  `Action` int(11) NOT NULL COMMENT 'Thao tác: 0- Tiến hành thanh toán; 1- Chờ phản hồi; 2-Thanh toán thành công; 3-Thanh toán thất bại',
  `ServiceId` varchar(64) DEFAULT NULL COMMENT 'Gói dịch vụ mà người dùng đăng ký',
  `Amount` decimal(19,4) NOT NULL COMMENT 'Số tiền mà người dùng đã thanh toán',
  `PaymentMethod` int(11) NOT NULL COMMENT 'Phương thức thanh toán',
  `PaymentState` int(11) NOT NULL COMMENT 'Trạng thái thanh toán (0-Mới tạo, 1-Đang xử lý, 2-Thành công, 3-Thất bại)',
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`TransactionId`),
  UNIQUE KEY `TransactionId` (`TransactionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table misaca_developer2.usersignature
CREATE TABLE IF NOT EXISTS `usersignature` (
  `UserSignatureId` varchar(64) NOT NULL COMMENT 'Id của bảng',
  `CAUserId` varchar(64) NOT NULL COMMENT 'Id của tài khoản sở hữu chữ ký',
  `ObjectId` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `BucketName` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `Url` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `UserSignatureType` int(11) NOT NULL COMMENT 'Loại nhãn chữ ký (1-Nhãn đầy đủ theo tên, 2-Nhãn với tên viết tắt, 3-Nhãn chụp từ chữ ký thật, 4-Nhãn vẽ từ mobile)',
  `Description` longtext CHARACTER SET utf8mb4 DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `UpdatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`UserSignatureId`),
  UNIQUE KEY `UserSignatureId` (`UserSignatureId`),
  KEY `FK_UserSignature_CAUser` (`CAUserId`),
  CONSTRAINT `FK_UserSignature_CAUser` FOREIGN KEY (`CAUserId`) REFERENCES `causer` (`CAUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Nhãn chữ ký của người dùng';

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
