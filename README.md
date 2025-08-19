


# Hospital Management – Task 8 (Stored Procedures & Functions)

## Overview
This task introduces **Stored Procedures** and **Stored Functions** in SQL using the Hospital Database.  
They help modularize SQL logic, reduce code repetition, and improve performance.

---

## Key Concepts

## Stored Procedure
- A compiled block of SQL code that can take **IN** and **OUT** parameters.
- Does not necessarily return a value but can output via OUT variables.
- Can contain loops, IF/ELSE, and complex business logic.

**Example Usage:**
```sql
CALL GetPatientBills(3);
