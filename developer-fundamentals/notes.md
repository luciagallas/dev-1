##  Multi-Tenant Architecture
**Links:** 
https://architect.salesforce.com/fundamentals/platform-multitenant-architecture


**What it means:**  
Salesforce runs many organizations (customers) on the same physical infrastructure.

**Key point:**  
Even though many customers share the same instance,  
➡️ **one org can NEVER query or access another org’s data.**

Salesforce automatically enforces this using:  
- **OrgID on every record**  
- **Row-level data separation**  
- **Logical isolation of data**

**Exam clarification:**  
Developers do *not* need to “ensure they query the correct org.”  
Queries automatically return data only from the current org.


# Governor Limits

**Why they exist:**  
Because Salesforce is multi-tenant, many orgs share CPU, memory, and storage.  
To prevent one org from consuming too many shared resources, Salesforce enforces strict limits.

**Examples of limits:**  
- SOQL queries per transaction  
- DML statements per transaction  
- CPU time  
- Heap size  
- Callouts  
- Concurrent async calls  

**Exam clue:**  
Governor limits ensure that performance in one org does not impact another org.

---

## Deployment Restrictions

**Important fact:**  
Code **cannot be deployed to production** unless the org meets Salesforce requirements, including:

- **Minimum 75% test coverage**  
- All tests passing  
- No test failures  
- Metadata validation  
- Proper namespace constraints

This is also a valid "Developer Fundamental" consideration.

---

## API Limits

**Clarification:**  
API calls are **NOT unlimited**.  
Each org has a **24-hour API request limit**, depending on its edition and user licenses.