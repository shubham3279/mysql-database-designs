-- Dropping the database if it exists 
DROP DATABASE IF EXISTS db_food_delivery_app;

-- creating the database using character encoding of utf-8
CREATE DATABASE IF NOT EXISTS db_food_delivery_app DEFAULT CHARACTER SET utf8mb4;

-- to check if the database was created 
SHOW DATABASES;

-- activating database
USE db_food_delivery_app;

-- Table: Users
CREATE TABLE IF NOT EXISTS Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    IsActive BOOLEAN DEFAULT TRUE,
    CONSTRAINT chk_gender CHECK (Gender IN ('Male', 'Female', 'Other'))
);

-- Table: Restaurants
CREATE TABLE IF NOT EXISTS Restaurants (
    RestaurantID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    IsActive BOOLEAN DEFAULT TRUE
);

-- Table: MenuItems
CREATE TABLE IF NOT EXISTS MenuItems (
    MenuItemID INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantID INT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    IsVegetarian BOOLEAN DEFAULT FALSE,
    IsActive BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_menuitem_restaurant FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table: Orders
CREATE TABLE IF NOT EXISTS  Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    RestaurantID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    IsDelivered BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_order_user FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_order_restaurant FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);



-- Table: OrderItems
CREATE TABLE IF NOT EXISTS OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    MenuItemID INT,
    Quantity INT NOT NULL,
    CONSTRAINT fk_orderitem_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orderitem_menuitem FOREIGN KEY (MenuItemID) REFERENCES MenuItems(MenuItemID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

