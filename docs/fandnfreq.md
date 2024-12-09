---
layout: default
title: "Requirements"
description: "Functional & Non-Functional"
---  


# [Home](index.md)

## Admin Portal - Bank Users Management System 
The IE Bank system will include a bank user's management system that can be accessed and controlled by a bank administrator. A bank users management portal will allow an admin user to view, create, update, and delete bank users.

| Requirements | Description |  
|-|-|
| FR 1. | The application must provide a default administrator account (user, password). The admin account must be able to access the users management portal once logged in successfully. |
| FR 2. | Once logged into the bank users management portal, a bank administrator can list, create, update, and delete bank users and passwords. |


### Administrator Login  
---
The system shall allow the administrator at the bank to log into the admin portal with the default administrator account that will be created once

- **`Admin Account Name`:** A unique identifier for the administrator account
- **`Admin Account Password`:** A unique password for the administrator account

### Administrator List Accounts
---
The system shall allow the administrator to list the account objects which allows the administrator to see their information with their following attributes.

- **`User Account ID`:**   A unique identifier for the account object.

The objects displayed to the administrator will be the following: 
1. ***User History***
2. ***User Balance***
3. ***User Account ID***
4. ***User Account Name***
5. ***User Account Number***
6. ***User Country***
7. ***User Balance***
8. ***User Currency***
9. ***User Status***
10. ***User Created At***

### Administrator Update Accounts
---
The system shall allow the administrator to update the all user account objects after listing the accounts with the following attributes.
 
- **`User Account Name`:** A unique name of the account holder
- **`User Account Password`:** A unique password for the user account
- **`User Country`:** The country where the user account is registered
- **`User Balance`:** The current balance of the user account
- **`User Currency`:** The currency used for the account
- **`User Status`:** The date and time when the user account was created

The objects can be updated to other values, but cannot be deleted or null within the database.

### Administrator Create Accounts
---
The system shall allow the administrator to create/register new user accounts by adding in new attributes through a frontend register page.

- **`User Account Name`:** The name of the account holder
- **`User Account Password`:** A unique password for the account holder 

A unique ***User Account ID*** will be added to the database upon successfully inputting the attributes outlined.   

### Administrator Delete Accounts
---
The system shall allow the administrator to delete user accounts on a separate page with the following attributes:

- **`User Account ID`:** A unique identifier for the account object
- **`User Account Name`:** The name of the account holder
- **`User Account Password`:** A unique password for the account holder


## Users Functional Requirements

### *Requirements Table*
| Requirements | Description |  
|--------------|-------------|
| FR 3. | New bank users can register on IE Bank in the bank with a register form (username, password, password confirmation). When a new user is registered, a new account will be provided by default, with a random account number. Users can also create additional accounts after registration. |
| FR 4. | Bank users can log in to the web application using their username and password. Once logged in, they can view only their owned bank accounts and transactions. |
| FR 5. | Bank users can transfer money to other existing accounts in the bank from the account management portal, by entering the recipient’s account number and the amount to be transferred. Amount to transfer cannot be more than the available amount in the account. |

---

### *FR 3: Register User Accounts and Create Additional Accounts*
The system shall allow a new bank user to register on the IE Bank system using a frontend registration page. The following attributes must be provided during registration:

- *User Account Name*: A unique username chosen by the user.
- *User Account Password*: A password created by the user and confirmed during registration.
- *User Country*: The country where the user resides.

Upon successful registration:
- A default account will be automatically created for the user.
- A *random account number* will be generated and associated with the new user account.

#### *Creating Additional Accounts for Existing Users*
The system shall also allow existing users to create additional accounts through the account management portal. The following attributes must be provided for additional account creation:

- *User ID*: The unique identifier of the user creating the new account (automatically linked).
- *Account Type*: The type of account being created (e.g., savings, checking).
- *Currency*: The currency for the new account (dropdown options include EUR, USD, GBP, and INR).
- *Initial Deposit (Optional)*: An optional amount for the initial deposit into the new account.

##### *Process for Additional Account Creation*
1. Existing users access the *Create New Account* page from their account management portal.
2. Users specify the desired *Account Type* and *Currency*.
3. The system validates the input and ensures that:
   - The user ID matches an existing user in the database.
   - The account type and currency are supported by the system.
4. A new account is created and linked to the user.

#### *Tokens Provided Upon Registration*
- *Access Token*: A JWT token for immediate access to the system.
- *Refresh Token*: A JWT token for session renewal.

#### *Validation and Error Handling*
- The system validates that the password and confirmation password match.
- Ensures that the username is not empty and is unique by querying the user database to prevent duplicate entries.
- For additional accounts, the system ensures valid input for account type and currency.

#### *Objects Created in the Database*
- *User Object*: A record is created for the user after successful validation during registration.
- *Account Object*:
  - A default account is created during user registration.
  - Additional accounts can be created and linked to the same user.

#### *Account-User Relationships*
- Each *user* can own one or more *accounts*.
- A *user ID* serves as the primary key in the *Users table* and is used as a foreign key in the *Accounts table* to link accounts to users.
- This relationship allows querying all accounts associated with a specific user and ensures that ownership is clearly defined.

---

### *FR 4: User Login and View Accounts*
The system shall allow bank users to log into the IE Bank system using the following attributes provided on a frontend login page:

- *User Account Name*: The unique username created during registration.
- *User Account Password*: The password associated with the account.

Upon successful login:
- A *JWT Access Token* is issued for session authentication.
- A *JWT Refresh Token* is provided for session renewal.

#### *User Account and Transaction Viewing*
- *Account Ownership*: Bank users can only view their own accounts and associated transaction history through authenticated routes.
- *Administrator Privileges*: Administrators have access to view all accounts and transactions within the system.

---

### *FR 5: Transfer Funds Between Accounts*
The system shall allow bank users to transfer funds to other accounts within the IE Bank system via the account management portal. The following attributes must be provided:

- *Sender Account Number*: The account number of the user initiating the transfer.
- *Recipient Account Number*: The account number of the recipient.
- *Transfer Amount*: The amount of money to be transferred.
- *Currency Dropdown*: A dropdown menu is provided for users to select the currency for the transaction. The available currency options include:
  - *Euro (€)*
  - *US Dollar ($)*
  - *British Pound (£)*
  - *Indian Rupees (₹)*

#### *Transfer Validation*
- *Amount Validation*: The transfer amount must be greater than zero.
- *Balance Verification*: The system checks that the sender's balance is sufficient to complete the transfer. Transfers exceeding the available balance are denied.

#### *Transaction Process*
1. *Account Balances Update*:
   - The sender's account balance is reduced by the transfer amount.
   - The recipient's account balance is increased by the same amount.
2. *Transaction Record*:
   - A *Transaction Object* is created to record the transaction details, including the sender, recipient, transfer amount, and selected currency.




## Non Functional Requirements
For the expected MVP, the following non-functional requirements have been defined:

| Requirements | Description |  
|-|-|
| NFR 1. | The web application should implement a basic user/admin authentication system that requires the users to enter their username and password to log in. The web application should not use any advanced or complex authentication methods, such as biometrics, token, or OAuth. The web application should also encrypt and store the user credentials securely (hashed) in the database. |
| NFR 2. | The web application should have a simple frontend user interface. The web application should not necessarily focus on the aesthetic aspects of the frontend, such as colors, fonts, or animations, or ensure that the frontend is compatible and responsive with different browsers and devices. |
