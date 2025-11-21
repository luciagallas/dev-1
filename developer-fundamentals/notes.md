##  Multi-Tenant Architecture
**Links:** 
https://architect.salesforce.com/fundamentals/platform-multitenant-architecture
https://developer.salesforce.com/docs/atlas.en-us.salesforce_app_limits_cheatsheet.meta/salesforce_app_limits_cheatsheet/salesforce_app_limits_platform_api.htm



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


## API Request Limits and Allocations

Salesforce enforces API limits to protect performance in its multi-tenant architecture.  
There are **three types of API limits** every developer must understand:

---

### 1. Concurrent API Request Limits

These limits apply only to requests that run for **20 seconds or longer**.

| Org Type | Concurrent Long-Running Requests |
|----------|----------------------------------|
| Developer Edition / Trial | 5 |
| Production / Sandbox | 25 |

If the limit is exceeded:
- Error: **REQUEST_LIMIT_EXCEEDED**
- New long-running requests are blocked until the number drops below the limit.

There is **no concurrent limit** for requests shorter than 20 seconds.

---

### 2. API Timeout Limits

Maximum allowed execution time for:
- **REST API calls → 10 minutes**
- **SOAP API calls → 10 minutes**
- **SOQL queries → limited by SOQL CPU time limits**
- Composite REST requests → the timeout applies to the entire composite, not each sub-call

Errors returned:
- SOAP: **REQUEST_RUNNING_TOO_LONG**
- REST: **QUERY_TIMEOUT**

---

### 3. Total API Request Allocations (24-hour limit)

Every org has a **daily limit** for total API calls, based on:
- Org edition  
- Number of user licenses  
- Additional purchased API capacity  

If the org exceeds this daily allocation, API calls fail.

---

### Summary

| Type of Limit | Description | Error |
|---------------|-------------|--------|
| Concurrent API Limit | Max long-running requests (≥20 sec) | REQUEST_LIMIT_EXCEEDED |
| Timeout Limit | Max execution time (10 minutes) | REQUEST_RUNNING_TOO_LONG / QUERY_TIMEOUT |
| Daily API Allocation | Max total requests per 24 hours | REQUEST_LIMIT_EXCEEDED |

These limits ensure one customer cannot degrade performance for others.
