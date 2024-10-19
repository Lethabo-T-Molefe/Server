
CREATE TABLE IF NOT EXISTS `Facility` (
    FacilityID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255),
    Description TEXT,
    ContactInfo VARCHAR(255),
    FacilityType VARCHAR(50) -- e.g., Museum, Park, Recreation Center
);


CREATE TABLE IF NOT EXISTS `Merchandise` (
    MerchandiseID INT PRIMARY KEY AUTO_INCREMENT,
    FacilityID INT,
    Name VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2),
    Description TEXT,
    StockQuantity INT,
    Category VARCHAR(50), -- e.g., Souvenirs, Apparel, Accessories
    FOREIGN KEY (FacilityID) REFERENCES Facility(FacilityID) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS `Event` (
    EventID INT PRIMARY KEY AUTO_INCREMENT,
    FacilityID INT,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Date DATE,
    Time TIME,
    TicketPrice DECIMAL(10, 2),
    Capacity INT,
    EventType VARCHAR(50), -- e.g., Festival, Concert, Exhibition
    FOREIGN KEY (FacilityID) REFERENCES Facility(FacilityID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `User` (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255),
    DateOfBirth DATE,
    MembershipStatus VARCHAR(20), -- e.g., Regular, VIP
    LoyaltyPoints INT DEFAULT 0
);



CREATE TABLE IF NOT EXISTS `Booking` (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    FacilityID INT,
    UserID INT,
    EventID INT NULL,
    BookingDate DATE,
    TimeSlot VARCHAR(50) NULL, -- if applicable
    NumberOfAttendees INT,
    BookingStatus VARCHAR(20) DEFAULT 'Pending', -- e.g., Pending, Confirmed, Canceled
    FOREIGN KEY (FacilityID) REFERENCES Facility(FacilityID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (EventID) REFERENCES Event(EventID) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS `Payment` (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT,
    UserID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50), -- e.g., Credit Card, PayPal, Bank Transfer
    PaymentStatus VARCHAR(20) DEFAULT 'Pending', -- e.g., Completed, Pending, Failed
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Loyalty` (
    LoyaltyID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    PointsEarned INT,
    PointsRedeemed INT,
    DateEarned DATE,
    ExpirationDate DATE,
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Price` (
    PriceID INT PRIMARY KEY AUTO_INCREMENT,
    FacilityID INT,
    ServiceName VARCHAR(255), -- e.g., Facility Usage, Event Entry
    PriceAmount DECIMAL(10, 2),
    EffectiveDate DATE,
    PricingType VARCHAR(50), -- e.g., Standard, Discounted, Premium
    FOREIGN KEY (FacilityID) REFERENCES Facility(FacilityID) ON DELETE CASCADE
);
