# Building Your First Logical Database Design

Project challenge of [DIO](https://www.dio.me/) "SQL Database Specialist" course.

## 💵 E-commerce 

- **Entities:** Client, Product, OrderRequest, Supplier, Third-Party Seller, Stock, Delivery, Card, PIX 

## 📖 Story

- **CPF:** CPF (Cadastro de Pessoas Físicas) is a Brazilian taxpayer identification number issued by the Federal Revenue Service of Brazil. It is an 11-digit number used to identify individuals for tax, financial, and legal purposes.
- **CNPJ:** CNPJ (Cadastro Nacional da Pessoa Jurídica) is a Brazilian business identification number issued by the Federal Revenue Service of Brazil. It is used to identify legal entities (companies, organizations, and other business entities) for tax, financial, and regulatory purposes.
- **PIX:** "PIX" is a fast and free payment system created by the Central Bank of Brazil. It allows people to make instant payments, transfers, and even purchases directly between bank accounts, 24/7. Unlike traditional bank transfers, which can take hours or even days to process, Pix transactions are almost immediate. Users can make payments using a QR code, phone number, or email, making it very convenient. 

**1. Product**

- Products are sold through a single online platform. However, they may have different sellers (third parties).
- Each product has a supplier.
- A order can have one or more products.

**2. Client**

- The customer can register on the website with their CPF or CNPJ. 
- The customer's address will determine the shipping cost.
- A customer can purchase more than one order. This has a grace period for returning the product.

**3. Order**

- Orders are created by customers and have purchase information, address and delivery status.
- The order can be cancelled.
- A order can have one or more products. 

## 💻 Challenge description 

Replicate the logical database design modeling for the e-commerce scenario. Pay attention to the primary and foreign key definitions, as well as the constraints present in the modeled scenario. Note that within this modeling there will be relationships present in the EER model. Therefore, check how to proceed in these cases. In addition, apply the model mapping to the refinements proposed in the conceptual modeling module.

As demonstrated during the challenge, create the SQL Script to create the database schema. Later, persist the data to perform tests. Specify more complex queries than those presented during the challenge explanation. Therefore, create SQL queries with the clauses below:

- Simple recoveries with `SELECT` Statement
- Filters with `WHERE` Statement
- Create expressions to generate derived attributes
- Define data ordering with `ORDER BY`
- Filter conditions for groups – `HAVING` Statement
- Create joins between tables to provide a more complex perspective of the data

Also, refine the presented model by adding the following points:

- Customers can create an individual or business account, but this account cannot have both information.
- The customer can register more than one payment method.
- Delivery has status and tracking code.

## ✅ Solution

<img align="center" src="https://github.com/pedrobinelo/Database-modeling-Ecommerce/blob/main/ecommerce.png" width=""/> 

## 💻 Technologies 

![MySQL Workbench](https://img.shields.io/badge/MySQL%20Workbench-ffffff?style=for-the-badge&logo=mysql&logoColor=black)

