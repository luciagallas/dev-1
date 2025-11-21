
**Links:** 
https://architect.salesforce.com/fundamentals/platform-multitenant-architecture

https://developer.salesforce.com/docs/atlas.en-us.salesforce_app_limits_cheatsheet.meta/salesforce_app_limits_cheatsheet/salesforce_app_limits_platform_api.htm

https://help.salesforce.com/s/articleView?id=platform.schema_builder.htm&type=5

# Object Relationship Considerations (Quick Reference)

**Salesforce supports two main relationship types: Lookup and Master-Detail, plus many-to-many through junction objects. Each behaves differently in terms of data ownership, deletion, reporting, and conversion.**

⚠️ https://help.salesforce.com/s/articleView?id=platform.relationships_considerations.htm&type=5


## 🔶 Relationship Limits
| Topic | Key Point |
|------|-----------|
| Max master-detail per custom object | **2** |
| Lookup relationships per object | Many (count as fields) |

---

## 🔶 Converting Relationships
| Conversion | Requirement |
|-----------|-------------|
| **Master-Detail → Lookup** | No roll-up summary fields exist on the master |
| After converting MD → Lookup | OWD becomes **Public Read/Write** |
| **Lookup → Master-Detail** | All child records must have a parent (no nulls) |
| Lookup → MD not possible when | OWD of child = **Controlled by Parent** |

---

## 🔶 Self-Relationships
| Rule | Explanation |
|------|-------------|
| Self-relationship allowed? | **Yes, but only Lookup** |
| Many-to-many self-relationship allowed? | ❌ No (junction object cannot have same master twice) |

---

## 🔶 Master-Detail Rules
| Rule | Explanation |
|------|-------------|
| Standard object as detail? | ❌ No (standard cannot be detail to custom) |
| Reparenting | ❌ Off by default; allowed only for **custom detail objects** |
| Max multilevel MD levels | **3** |
| Detail record owner | Inherits owner from master → cannot have queues |
| Delete master | Deletes detail + subdetail |
| Delete detail | Moves to Recycle Bin (master stays) |
| Restore master | Restores detail too |
| Restore detail (if master deleted after) | ❌ Cannot be restored (no parent) |
| Create MD relationship | Only if no data exists; otherwise create lookup first |

- Detail inherits owner, sharing, and permissions from the master.
- Deleting the master deletes all detail records (cascade delete).
- Detail records cannot have queues (no Owner field).
- Reparenting is off by default but allowed for custom detail objects.
- Standard objects cannot be detail of custom master objects.
- Cannot create MD if detail object contains data.
---

## 🔶 Junction Object (Many-to-Many)
| Rule | Explanation |
|------|-------------|
| Junction object delete behavior | Deleted if **either parent** is deleted |
| Junction object ownership | Inherits **Owner** from primary master |
| Primary master | First MD created |
| Secondary master | Second MD created |
| Impact on reports | 2 standard report types (primary and secondary) |

- Junction uses two master-detail fields.
- First MD is the primary master (controls Owner, color, division).
- Deleting either master deletes junction record
---

## 🔶 Lookup Relationships
| Option | Meaning |
|--------|---------|
| Clear the lookup field | Default |
| Prevent parent deletion | Stops deletion if children exist |
| Delete child when parent deleted | Only custom lookup → custom object; requires support from Salesforce (cascade delete) |

- More loosely coupled relationship.
- You can configure what happens when the parent is deleted: clear field, restrict delete, or cascade (custom only).
- Converts to MD only when all detail records have a parent.
---

## 🔶 External Object Relationships
| Type | Supported? |
|------|------------|
| Lookup | ✔ |
| External Lookup | ✔ |
| Indirect Lookup | ✔ |
| Master-Detail | ❌ Not supported |
| Cascade delete | ❌ Not supported |

---

## 🔶 Reporting Impact
| Relationship Type | Join Capabilities |
|------------------|-------------------|
| Lookup | Parent + child only |
| Master-Detail | Master + detail + ONE extra lookup |
| Many-to-Many | Two report types: primary–junction–secondary and vice versa |

----

##  Multi-Tenant Architecture

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


## Schema Builder — Performance & Navigation Features

Schema Builder can become slow when many objects and relationships are displayed.  
These features help improve performance and usability:

### ✔ Object Map
- Use the mini-map to quickly navigate around the canvas.
- Helps locate objects without scrolling.

### ✔ Hide Relationships
- Hides relationship lines between objects.
- Reduces rendering workload → improves performance.

### ✔ Object Filter
- Allows displaying only selected objects.
- Useful to focus on objects of interest and reduce clutter.

### What Schema Builder CAN do
- Create **custom objects**  
- Create **lookup** relationships  
- Create **master-detail** relationships  
- Create **custom fields** (except Geolocation)  
- View all fields, required flags, and relationship types  
- View both **standard** and **custom** objects  
- Drag-and-drop fields to create or modify structure  
- Automatically saves layout positions on the canvas  

### When to Use Schema Builder
- Designing a new data model visually  
- Quickly creating fields/relationships without clicking through Setup pages  
- Understanding complex relationships at a glance  


## Cross-Object Formulas
https://help.salesforce.com/s/articleView?id=platform.customize_cross_object.htm&type=5

### What Is a Cross-Object Formula?
A cross-object formula is a formula that references fields on a **related parent object**.  
It allows a record to *pull data* from its parent (master-detail or lookup) relationship without storing it directly.

Example:
- A formula on **Contact** that displays the parent Account’s Industry:
Account.Industry

### What Cross-Object Formulas CAN Do
- Pull field values from **parent** objects (master-detail or lookup).
- Reach **up to 10 relationships** deep. --> `Case.Account.Owner.Manager.Department` (4 relationships away)
- Display parent-field values **even if the user does not have access** to the parent record.
- Work in:
- Formula fields  
- Validation rules  
- Workflow / Process Builder  
- Approval rules  
- Some Flow contexts

### What Cross-Object Formulas CANNOT Do
- **Cannot reference child records**.  
- Example: An Account formula cannot pull values from a Contact.
- **Cannot be used inside Roll-Up Summary fields.**
- **Cannot reference an object directly**, only its fields.
- Valid: `Account.Owner.Name`
- Invalid: `Account.Owner`

### Security Note
If a cross-object formula is displayed in a page layout, the user will see the referenced parent-field value **even without permission** to view that parent record.

### Summary
Cross-object formulas:
- Move **upward** through parent relationships  
- Are read-only  
- Are extremely useful for exposing related data on child records  
- Cannot move downward to children  

