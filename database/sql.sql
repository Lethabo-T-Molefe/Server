
CREATE TABLE IF NOT EXISTS `Facility` (
    `FacilityID` NUMBER(10) PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(255) NOT NULL,
    `Location` VARCHAR(255),
    `Description` VARCHAR(250)
    `ContactInfo` VARCHAR(255),
    `FacilityType` VARCHAR(50) -- e.g., Museum, Park, Recreation Center
);


CREATE TABLE IF NOT EXISTS `Merchandise` (
    `MerchandiseID` NUMBER(10) PRIMARY KEY AUTO_INCREMENT,
    `FacilityID` NUMBER(10),
    `Name` VARCHAR(255) NOT NULL,
    `Price` DECIMAL(10, 2),
    `Description` VARCHAR(250),
    `StockQuantity` NUMBER(1000),
    `Category` VARCHAR(50), -- e.g., Souvenirs, Apparel, Accessories
    FOREIGN KEY (FacilityID) REFERENCES Facility(FacilityID) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS `Event` (
    `EventID` NUMBER(10) PRIMARY KEY AUTO_INCREMENT,
    `FacilityID` NUMBER(10),
    `Name` VARCHAR(255) NOT NULL,
    `Description` VARCHAR(250),
    `Date` DATE,
    `Time` TIME,
    `TicketPrice` DECIMAL(10, 2),
    `Capacity` NUMBER(100),
    `EventType` VARCHAR(50), -- e.g., Festival, Concert, Exhibition
    FOREIGN KEY (FacilityID) REFERENCES Facility(FacilityID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `User` (
    `UserID`  PRIMARY KEY AUTO_INCREMENT,
    `Name` VARCHAR(255) NOT NULL,
    `Email` VARCHAR(255) NOT NULL UNIQUE,
    `PhoneNumber` VARCHAR(20),
    `Address` VARCHAR(255),
    `DateOfBirth` DATE,
    `Password` varchar(100) NOT NULL, 
    `MembershipStatus` VARCHAR(20), -- e.g., Regular, VIP
    `LoyaltyPoints` NUMBER(10) DEFAULT 0
);

LOCK TABLES `User` WRITE;
INSERT INTO `User` (`Name`, `Email`, `PhoneNumber`, `Address`, `DateOfBirth`, `Password`, `MembershipStatus`, `LoyaltyPoints`)
VALUES ('John Doe', 'john.doe@example.com', '1234567890', '123 Main St, Pretoria', '1990-05-15', MD5('password123'), 'Regular', 100);

-- User 2
INSERT INTO `User` (`Name`, `Email`, `PhoneNumber`, `Address`, `DateOfBirth`, `Password`, `MembershipStatus`, `LoyaltyPoints`)
VALUES ('Jane Smith', 'jane.smith@example.com', '0987654321', '456 Elm St, Pretoria', '1985-09-23', MD5('secret456'), 'VIP', 200);

-- User 3
INSERT INTO `User` (`Name`, `Email`, `PhoneNumber`, `Address`, `DateOfBirth`, `Password`, `MembershipStatus`, `LoyaltyPoints`)
VALUES ('Mark Johnson', 'mark.johnson@example.com', '1122334455', '789 Pine St, Pretoria', '1992-12-07', MD5('pass789'), 'Regular', 150);

-- User 4
INSERT INTO `User` (`Name`, `Email`, `PhoneNumber`, `Address`, `DateOfBirth`, `Password`, `MembershipStatus`, `LoyaltyPoints`)
VALUES ('Emily Davis', 'emily.davis@example.com', '5566778899', '321 Oak St, Pretoria', '1998-04-10', MD5('emilysecure'), 'VIP', 250);
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS `Booking` (
    `BookingID` NUMBER(10) PRIMARY KEY AUTO_INCREMENT,
    `FacilityID` NUMBER(10),
    `UserID` NUMBER(10),
    `EventID` NUMBER(10) NULL,
    `BookingDate` DATE,
    `TimeSlot` VARCHAR(50) NULL, -- if applicable
    `NumberOfAttendees` NUMBER(100),
    `BookingStatus` VARCHAR(20) DEFAULT 'Pending', -- e.g., Pending, Confirmed, Canceled
    FOREIGN KEY (`FacilityID`) REFERENCES Facility(`FacilityID`) ON DELETE CASCADE,
    FOREIGN KEY (`UserID`) REFERENCES User(`UserID`) ON DELETE CASCADE,
    FOREIGN KEY (`EventID`) REFERENCES Event(`EventID`) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `Payment` (
    `PaymentID` NUMBER(10) PRIMARY KEY AUTO_INCREMENT,
    `BookingID` NUMBER(10),
    `UserID` NUMBER(10),
    `PaymentDate` DATE,
    `Amount` DECIMAL(10, 2),
    `PaymentMethod` VARCHAR(50), -- e.g., Credit Card, PayPal, Bank Transfer
    `PaymentStatus` VARCHAR(20) DEFAULT 'Pending', -- e.g., Completed, Pending, Failed
    FOREIGN KEY (`BookingID`) REFERENCES `Booking`(`BookingID`) ON DELETE CASCADE,
    FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Loyalty` (
    `LoyaltyID` NUMBER(10) PRIMARY KEY AUTO_INCREMENT,
    `UserID` NUMBER(10),
    `PointsEarned` NUMBER(10),
    `PointsRedeemed` NUMBER(10),
    `DateEarned` DATE,
    `ExpirationDate` DATE,
    FOREIGN KEY (`UserID`) REFERENCES `User`(`UserID`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Price` (
    `PriceID` NUMBER(10) PRIMARY KEY AUTO_INCREMENT,
    `FacilityID` NUMBER(10),
    `ServiceName` VARCHAR(255), -- e.g., Facility Usage, Event Entry
    `PriceAmount` DECIMAL(10, 2),
    `EffectiveDate` DATE,
    `PricingType` VARCHAR(50), -- e.g., Standard, Discounted, Premium
    FOREIGN KEY (`FacilityID`) REFERENCES `Facility`(`FacilityID`) ON DELETE CASCADE
);
