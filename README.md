# Product Order Management System - ASP.NET MVC

## Project Overview
This repository contains a robust web-based Order Management System developed using **ASP.NET MVC** and **Entity Framework (Database First approach)**. The application is designed to handle complex relational data, specifically focusing on seamless **Master-Details CRUD operations** for managing customers, products, categories, and multiple order items within a single transaction.

## Project Architecture
The project follows a strict MVC pattern with a clear separation of concerns, utilizing Data Transfer Objects (ViewModels) to pass data safely between the controllers and views.

![Solution Explorer](Solution_Structure.png)

## Application Interfaces
Here are some key snapshots of the application demonstrating the user interface and core functionalities:

### Order Management (Master-Details)
* **Order List Dashboard:** Displays a comprehensive view of all placed orders with their respective total amounts.
  ![Order List](Order_List.png)
* **Dynamic Order Placement:** A complex form handling the 'Master' record (Customer Info) and allowing the dynamic addition of multiple 'Details' records (Products) using jQuery and AJAX before form submission.
  ![Place Order Form](Place_Order.png)
  ![Order Items Grid](Order_Details_Grid.png)

### Inventory Management
* **Product Category List:** Interface for managing product categories.
  ![Category List](Category_List.jpg)
* **Create Category:** Form for adding new product categories.
  ![Create Category](Create_Category.jpg)

## Technical Highlights & Core Implementations
* **Database First Architecture:** Leveraged Entity Framework (`.edmx`) to generate domain models directly from a normalized MS SQL Server database.
* **Complex Master-Details Handling:** Engineered the `OrderController` to handle complex view models containing both customer data and a list of order items simultaneously.
* **Transaction Management:** Implemented `System.Transactions.TransactionScope` to ensure ACID properties during order placement. If a product goes out of stock or an error occurs during the save process, the entire transaction (Customer, Order, OrderDetails, and Inventory updates) is safely rolled back.
* **Client-Side Dynamics:** Extensively used **jQuery and JavaScript** in the `Create.cshtml` and `Edit.cshtml` views to manipulate the DOM, allowing users to add, edit, and remove order items from an HTML table without reloading the page.
* **Real-time Inventory Tracking:** Built-in logic within the controllers to automatically deduct available stock when an order is placed and restore stock if an order is deleted or modified.
* **ViewModels Implementation:** Used ViewModels (e.g., `OrderMasterViewModel`, `ProductViewModel`) to encapsulate presentation logic and prevent over-posting attacks.

## Technology Stack
* **Framework:** ASP.NET MVC 5
* **Language:** C#
* **ORM:** Entity Framework 6 (Database First)
* **Database:** MS SQL Server
* **Frontend:** HTML5, Bootstrap, Razor View Engine (`.cshtml`)
* **Client-Side Scripting:** JavaScript, jQuery, AJAX
