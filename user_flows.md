# User Flow Architecture

This document outlines the core user flows for the Ezo POS system, visualized using Mermaid diagrams.

## 1. Authentication Flow
Handles user login, session validation, and logout.

```mermaid
graph TD
    Start([App Start]) --> CheckSession{Has Active Session?}
    CheckSession -- Yes --> Dashboard[Dashboard]
    CheckSession -- No --> Login[Login Screen]
    
    Login --> InputCreds[/Enter Credentials/]
    InputCreds --> Validate{Validate User}
    Validate -- Success --> SetSession[Create Session]
    SetSession --> Dashboard
    Validate -- Failure --> ShowError[Show Error Message]
    ShowError --> Login
    
    Dashboard --> Logout{Logout?}
    Logout -- Yes --> ClearSession[Clear Session]
    ClearSession --> Login
```

## 2. Dashboard Navigation
High-level navigation between main modules.

```mermaid
stateDiagram-v2
    [*] --> Dashboard
    
    state Dashboard {
        [*] --> Overview
        Overview --> POS: Click POS
        Overview --> Report: Click Reports
        Overview --> Settings: Click Settings
    }

    POS --> Dashboard: Back
    Report --> Dashboard: Back
    Settings --> Dashboard: Back
```

## 3. POS Transaction Flow
The primary workflow for Cashiers processing a sale.

```mermaid
sequenceDiagram
    participant User as Cashier
    participant UI as POS Screen
    participant Cart as Cart Service
    participant DB as Database

    User->>UI: Select Product
    UI->>Cart: Add Item
    Cart-->>UI: Update Total

    User->>UI: Click Checkout
    UI->>UI: Show Payment Modal

    User->>UI: Select Payment Method (Cash/Card)
    User->>UI: Confirm Payment
    
    UI->>Cart: Process Sale
    Cart->>DB: Save Transaction
    DB-->>Cart: Transaction ID
    
    Cart-->>UI: Sale Complete
    UI-->>User: Show Receipt / Success
    UI->>Cart: Clear Cart
```

## 4. Product Management (Admin)
Flow for adding or editing inventory items.

```mermaid
graph LR
    List[Product List] -->|Click Add| Form[Product Form]
    List -->|Click Item| Details[Product Details]
    Details -->|Click Edit| Form
    
    Form -->|Enter Data| Validate{Valid Input?}
    Validate -- No --> Error[Show Errors]
    Error --> Form
    
    Validate -- Yes --> Save{Save to DB}
    Save -- Success --> Toast[Show Success Message]
    Toast --> List
    Save -- Fail --> DbError[Show Database Error]
    DbError --> Form
```

## 5. Inventory Adjustment
Flow for manually updating stock levels.

```mermaid
graph TD
    Start([Inventory Screen]) --> Search[/Search Product/]
    Search --> Select[Select Product]
    Select --> Action{Action Type}
    
    Action -- Restock --> AddStock[Increase Quantity]
    Action -- Audit --> SetStock[Set Correct Quantity]
    Action -- Waste --> RemoveStock[Decrease Quantity]
    
    AddStock --> Reason[/Enter Reason/]
    SetStock --> Reason
    RemoveStock --> Reason
    
    Reason --> Confirm[Confirm Adjustment]
    Confirm --> UpdateDB[(Update Database)]
    UpdateDB --> Log[Log Movement History]
    Log --> Finish([Update UI])
```
