-- Refine the presented model by adding the following points:
--        * Customers can create an individual or business account, but this account cannot have both information.
--        * The customer can register more than one payment method.
--        * Delivery has status and tracking code.

-- Creating E-commerce Database
CREATE DATABASE ecommerce;
USE ecommerce;

-- Creating table - Clients OK DATA INSERTED
CREATE TABLE Clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ClientName VARCHAR(100) NOT NULL, 
    AddressCEP CHAR(8) NOT NULL,
    AddressNumber CHAR(3) NOT NULL,
    isNaturalPerson BOOL NOT NULL,
    CPF CHAR(11) UNIQUE, 
    CNPJ CHAR(14) UNIQUE, 
    CONSTRAINT chk_CPF_CNPJ CHECK (
        (isNaturalPerson = TRUE AND CPF IS NOT NULL AND CNPJ IS NULL) OR
        (isNaturalPerson = FALSE AND CNPJ IS NOT NULL AND CPF IS NULL)
    )
);

-- Creating table - Product OK  DATA INSERTED
CREATE TABLE Product(
	idProduct int auto_increment primary key not null, 
    ProductName varchar(50) not null,
    Price float not null,
    Category enum('Electronics', 'Toys', 'Clothes', 'Food', 'Furniture') not null default 'Electronics',
    ProductDescription varchar(100) not null
);

-- Creating table - Order Request (Order) OK  DATA INSERTED
CREATE TABLE OrderRequest(
	idOrderRequest int auto_increment primary key not null,
    idClient int not null, 
    orderStatus enum('Canceled', 'In progress', 'Processing', 'Shipped', 'Delivered') not null default 'In progress',
    orderDescription varchar(100) not null,
    shippingPrice float not null, 
    constraint fk_OR_client foreign key (idClient) references Clients(idClient)
);

-- Creating table - Order_Has_Products OK  DATA INSERTED
CREATE TABLE Order_has_Products (
    idOrder INT,
    idProduct INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (idOrder, idProduct),
    CONSTRAINT fk_OHP_order FOREIGN KEY (idOrder) REFERENCES OrderRequest(idOrderRequest),
    CONSTRAINT fk_OHP_product FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);

-- Creating table - Stock OK  DATA INSERTED
CREATE TABLE Stock(
	idStock int auto_increment primary key,
    stockLocation varchar(45) not null
);

-- Creating table - Supplier OK  DATA INSERTED
CREATE TABLE Supplier(
	idSupplier int auto_increment primary key,
    BusinessName varchar(50) not null, -- Nome fantasia
    CNPJ char(14) not null,
    ContactInfo char(11) not null,
    constraint unique_supplier unique(CNPJ)
);

-- Creating table - Other Sellers (ThirdPartySeller) OK  DATA INSERTED
CREATE TABLE OtherSeller(
	idTPSeller int auto_increment primary key,
    Location varchar(45) not null,
    TradeName varchar(45) not null, -- Nome fantasia
    LegalName varchar(45) not null, -- Razão social
    CNPJ char(14) not null,
    constraint unique_TP_seller unique (TradeName, CNPJ)
);

-- Creating table - In Stock OK  DATA INSERTED
CREATE TABLE InStock (
    idProduct INT,
    idStock INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (idProduct, idStock),
    CONSTRAINT fk_InStock_product FOREIGN KEY (idProduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_InStock_stock FOREIGN KEY (idStock) REFERENCES Stock(idStock)
);

-- Creating table - Supplier_has_Products OK  DATA INSERTED
CREATE TABLE Supplier_has_Products (
    idSupplier INT,
    idProduct INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (idSupplier, idProduct),
    CONSTRAINT fk_SHP_supplier FOREIGN KEY (idSupplier) REFERENCES Supplier(idSupplier),
    CONSTRAINT fk_SHP_product FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);

-- Creating table - ThirdPartySeller_has_Products OK  DATA INSERTED
CREATE TABLE TPSeller_Has_Products (
    idThirdPartySeller INT,
    idProduct INT,
    Quantity INT NOT NULL,
    PRIMARY KEY (idThirdPartySeller, idProduct),
    CONSTRAINT fk_THP_TPseller FOREIGN KEY (idThirdPartySeller) REFERENCES OtherSeller(idTPSeller),
    CONSTRAINT fk_THP_product FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);

-- Creating table - Card OK  DATA INSERTED
CREATE TABLE Card (
    idCard INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    idClient INT NOT NULL,
    CardNumber CHAR(16) NOT NULL unique,
    ExpirationDate DATE NOT NULL,
    CVV INT NOT NULL,
    CONSTRAINT fk_Card_client FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

-- Creating table - Delivery OK DATA INSERTED
CREATE TABLE Delivery (
    idDelivery INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idOrder INT NOT NULL,
    DeliveryStatus ENUM('In transport', 'Delivered', 'Canceled') DEFAULT 'In transport' NOT NULL,
    TrackingCode CHAR(16) NOT NULL unique,
    CONSTRAINT fk_Delivery_order FOREIGN KEY (idOrder) REFERENCES OrderRequest(idOrderRequest)
);

-- Creating table - PIX OK DATA INSERTED
CREATE TABLE PIX (
    idPix INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    idOrder INT NOT NULL,
    PixCode VARCHAR(77) NOT NULL,
    CONSTRAINT fk_PIX_order FOREIGN KEY (idOrder) REFERENCES OrderRequest(idOrderRequest)
);

-- Inserting data into Clients
INSERT INTO Clients (ClientName, AddressCEP, AddressNumber, isNaturalPerson, CPF, CNPJ)
VALUES 
    ('Carlos Silva', '79002000', '123', TRUE, '12345678901', NULL),
    ('Ana Pereira', '79002500', '456', TRUE, '98765432100', NULL),
    ('Mariana Souza', '79003000', '789', TRUE, '65432198700', NULL),
    ('Tech Solutions Ltda.', '79003500', '321', FALSE, NULL, '12345678000199'),
    ('Construtora Alpha', '79004000', '654', FALSE, NULL, '98765432000188'),
    ('Supermercado Ideal', '79004500', '987', FALSE, NULL, '11223344000177');

-- Inserting data into Products
INSERT INTO Product (ProductName, Price, Category, ProductDescription)
VALUES 
    ('Smartphone X', 2500.00, 'Electronics', 'Smartphone com câmera de 108MP e 128GB de armazenamento.'),
    ('Notebook Gamer', 5500.00, 'Electronics', 'Notebook com processador i7 e placa RTX 3060.'),
    ('Boneca de Pano', 50.00, 'Toys', 'Boneca artesanal feita de algodão.'),
    ('Carrinho de Controle', 120.00, 'Toys', 'Carrinho de controle remoto com bateria recarregável.'),
    ('Camiseta Preta', 80.00, 'Clothes', 'Camiseta de algodão 100% com estampa minimalista.'),
    ('Tênis Esportivo', 200.00, 'Clothes', 'Tênis leve e confortável para corrida.'),
    ('Chocolate Belga', 35.00, 'Food', 'Chocolate importado com 70% cacau.'),
    ('Cadeira de Escritório', 750.00, 'Furniture', 'Cadeira ergonômica com ajuste de altura e apoio lombar.'),
    ('Sofá Retrátil', 3500.00, 'Furniture', 'Sofá de 3 lugares retrátil e reclinável.');

-- Inserting data into OrderRequest
INSERT INTO OrderRequest (idClient, orderStatus, orderDescription, shippingPrice)
VALUES 
    (1, 'In progress', 'Pedido de 2 Smartphones X e uma boneca de pano.', 30.00),
    (2, 'Shipped', 'Pedido de Notebook Gamer e Camiseta Preta.', 20.00);

-- Inserting data into Stock
INSERT INTO Stock (stockLocation)
VALUES 
    ('Campo Grande'),
    ('Dourados'),
    ('Três Lagoas');

-- Inserting data into Supplier
INSERT INTO Supplier (BusinessName, CNPJ, ContactInfo)
VALUES 
    ('TechGiz', '12345678000195', '11987654321'),
    ('FashionHouse', '98765432000123', '11912345678'),
    ('ToysWorld', '55555555000188', '11933445566'),
    ('FoodieSupplies', '11122334000122', '11944332211'),
    ('HomeFurniture', '22233445000155', '11955667788');

-- Inserting data into OtherSellers
INSERT INTO OtherSeller (Location, TradeName, LegalName, CNPJ)
VALUES 
    ('São Paulo - SP', 'TechStore', 'TechStore Comércio de Eletrônicos Ltda', '12345678000190'),
    ('Rio de Janeiro - RJ', 'FashionTrend', 'FashionTrend Indústria e Comércio Ltda', '98765432000125'),
    ('Belo Horizonte - MG', 'PlayToys', 'PlayToys Comércio de Brinquedos Ltda', '55555555000185'),
    ('Curitiba - PR', 'GourmetFoods', 'GourmetFoods Comércio de Alimentos Ltda', '11122334000130'),
    ('Porto Alegre - RS', 'HomeStyle', 'HomeStyle Móveis Ltda', '22233445000150');

-- Inserting data into Card
INSERT INTO Card (idClient, CardNumber, ExpirationDate, CVV)
VALUES 
    (1, '1234567812345678', '2025-12-01', 123),
    (1, '2345678923456789', '2026-05-01', 456),
    (2, '3456789034567890', '2024-08-01', 789),
    (3, '4567890145678901', '2025-11-01', 321),
    (4, '5678901256789012', '2027-02-01', 654);

-- Inserting data into Order_has_Products
INSERT INTO Order_has_Products (idOrder, idProduct, Quantity)
VALUES 
    (1, 1, 2), 
    (1, 3, 1),
    (2, 2, 1),
    (2, 5, 1);

-- Inserting data into InStock
INSERT INTO InStock (idProduct, idStock, Quantity)
VALUES 
    (1, 1, 50),  
    (1, 2, 30),   
    (2, 1, 100),  
    (2, 3, 60),  
    (3, 2, 40); 

-- Inserting data into Supplier_has_Products
INSERT INTO Supplier_has_Products (idSupplier, idProduct, Quantity)
VALUES 
    (1, 2, 100), 
    (1, 1, 50),
    (2, 5, 150),  
    (3, 3, 200),  
    (1, 4, 50); 

-- Inserting data into TPSeller_Has_Products
INSERT INTO TPSeller_Has_Products (idThirdPartySeller, idProduct, Quantity)
VALUES 
    (1, 2, 100),  
    (2, 5, 150),  
    (2, 6, 200),  
    (1, 1, 50);   

-- Inserting data into Delivery
INSERT INTO Delivery (idOrder, DeliveryStatus, TrackingCode)
VALUES
    (1, 'In transport', 'TRK1234567890123'),
    (2, 'Delivered', 'TRK9876543210987');

-- Using SELECT Statement
-- This query retrieves all orders placed by each customer, showing the customer ID, customer name, and order status
SELECT 
    c.idClient, 
    c.ClientName, 
    o.idOrderRequest, 
    o.orderStatus
FROM 
    OrderRequest o
JOIN 
    Clients c ON o.idClient = c.idClient;
    
-- Using WHERE Statement
-- This query returns orders for a specific customer, where the customer is named "John" and the order status is "In progress"
SELECT 
    o.idOrderRequest, 
    o.orderStatus, 
    o.orderDescription
FROM 
    OrderRequest o
JOIN 
    Clients c ON o.idClient = c.idClient
WHERE 
    c.ClientName = 'Carlos Silva' AND 
    o.orderStatus = 'In progress';

-- Creating expressions to generate derived attributes
-- This query calculates the total order value by multiplying the quantity of each product by the product price. 
-- The query also displays the total order value for each customer.
SELECT 
    o.idOrderRequest, 
    c.ClientName,
    SUM(op.Quantity * p.Price) AS TotalOrderValue
FROM 
    Order_has_Products op
JOIN 
    OrderRequest o ON op.idOrder = o.idOrderRequest
JOIN 
    Clients c ON o.idClient = c.idClient
JOIN 
    Product p ON op.idProduct = p.idProduct
GROUP BY 
    o.idOrderRequest, c.ClientName;

-- Using ORDER BY
-- This query returns all products, sorting them by price in ascending order (from cheapest to most expensive)
SELECT 
    ProductName, 
    Price
FROM 
    Product
ORDER BY 
    Price ASC;

-- Using HAVING Statement
-- This query returns suppliers that have more than 2 products available in stock. 
-- The query filters the results after aggregation
SELECT 
    s.BusinessName, 
    COUNT(sp.idProduct) AS ProductCount
FROM 
    Supplier_has_Products sp
JOIN 
    Supplier s ON sp.idSupplier = s.idSupplier
GROUP BY 
    s.BusinessName
HAVING 
    COUNT(sp.idProduct) > 2;
    
-- Creating joins between tables to provide a more complex perspective of the data
-- This query returns the relationship between products, suppliers and stocks. 
-- It shows the product name, the supplier name and the quantity available in each stock.
SELECT 
    p.ProductName, 
    s.BusinessName AS SupplierName, 
    st.stockLocation, 
    instk.Quantity
FROM 
    Product p
JOIN 
    Supplier_has_Products shp ON p.idProduct = shp.idProduct
JOIN 
    Supplier s ON shp.idSupplier = s.idSupplier
JOIN 
    InStock instk ON p.idProduct = instk.idProduct
JOIN 
    Stock st ON instk.idStock = st.idStock;

-- How many orders each client placed?
SELECT 
    c.ClientName, 
    COUNT(o.idOrderRequest) AS TotalOrders
FROM 
    OrderRequest o
JOIN 
    Clients c ON o.idClient = c.idClient
GROUP BY 
    c.ClientName;
    
-- Are any sellers also suppliers?
SELECT 
    ts.TradeName AS SellerName, 
    s.BusinessName AS SupplierName
FROM 
    OtherSeller ts
JOIN 
    Supplier s ON ts.CNPJ = s.CNPJ;

-- This query returns the products, suppliers and stocks where the products are available.
SELECT 
    p.ProductName, 
    s.BusinessName AS SupplierName, 
    st.stockLocation, 
    instk.Quantity
FROM 
    Product p
JOIN 
    Supplier_has_Products shp ON p.idProduct = shp.idProduct
JOIN 
    Supplier s ON shp.idSupplier = s.idSupplier
JOIN 
    InStock instk ON p.idProduct = instk.idProduct
JOIN 
    Stock st ON instk.idStock = st.idStock;

-- This query returns the name of the suppliers and the products they provide.
SELECT 
    s.BusinessName AS SupplierName, 
    p.ProductName
FROM 
    Supplier_has_Products shp
JOIN 
    Supplier s ON shp.idSupplier = s.idSupplier
JOIN 
    Product p ON shp.idProduct = p.idProduct;
