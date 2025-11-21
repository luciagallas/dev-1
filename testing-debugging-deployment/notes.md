
**Links:**  
https://help.salesforce.com/s/articleView?id=platform.create_test_instance.htm&type=5ç

https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_anonymous_block.htm

## Staging Environment (Full Sandbox)

**What is a Staging environment?**  
A Staging environment is the final environment before Production in the development lifecycle.  
In Salesforce, Staging is typically implemented using a **Full Sandbox**, which is a complete copy of Production, including all data and metadata.

**What it is used for:**
- Final regression testing  
- Test deployment (dry-run of the production deployment)  
- Stress and performance testing  
- Data-dependent testing  
- Ensuring the entire deployment works end-to-end  
- Catching issues that only appear with real production-size data  

**Why Staging?**  
Because it is the *closest possible replica of Production*, making it ideal for validating that everything works exactly as it will after go-live.

---

## Why not the other environments?

### Development Environment
- Used by individual developers  
- Contains limited or mocked data  
- Not suitable for regression or performance tests  

### Quality Assurance (QA)
- Typically uses a **Partial Copy** or **Developer Pro** sandbox  
- Great for functional testing  
- Not enough data for performance or stress testing  

### Production Support Environment
- Intended for troubleshooting production issues  
- Not used for regression or stress testing  

---

## Anonymous Apex — Key Facts

### What it is
Anonymous Apex is Apex code that is **not stored in metadata** and can be compiled and executed on demand.

### Where you can run it
- Developer Console  
- Salesforce Extensions for VS Code  
- Code Builder  
- Tooling API → executeAnonymous()  
- SOAP/REST API tools (Workbench, Postman, etc.)

### Required Permissions
- “API Enabled” (always)
- “Author Apex” (to run ANY Apex in Developer Console)
- Via API: users **without** “Author Apex” can run only:
  - Code written directly in the anonymous block  
  - Web service methods (`webservice`) in the org  
  - Built-in Apex methods  

They **cannot** call Apex classes saved in the org.

### Execution & Context
- Runs as **current user**, NOT full system context  
- Sharing rules apply like normal Apex (unless calling a class marked `without sharing`)  
- CRUD/FLS are NOT automatically enforced  
- Compiled **every time you run it**

### DML Behavior
- DML changes are **committed** if no errors occur  
- If any error occurs (including inside triggers), the **entire transaction rolls back**  
- Triggers *do* fire

### Allowed Inside Anonymous Apex
- Local user-defined methods (no `static`)  
- Local exceptions  
- Variables must be declared before use  
- Classes/interfaces can be defined but:
  - They are **not saved**  
  - They are implicitly **virtual**  
  - Should NOT be used for real work

### Not Allowed
- Persisting classes or triggers  
- Referencing custom Apex classes if user lacks “Author Apex” (via API execution)

### When to Use Anonymous Apex
- Quick testing  
- Running scripts  
- Calling methods  
- Fixing or updating data  
- Lightweight execution without creating metadata

### Returned Results (executeAnonymous response)
- Compile status  
- Execute status  
- Error info  
- Stack trace  
- Debug log output


### Extra Rules About Anonymous Apex

- Local methods are allowed but **cannot be static**.
- Variables must be declared before use.
- Any class/interface defined inside an anonymous block is:
  - Not saved
  - Treated as `virtual`
- If a trigger fails, **the entire anonymous block rolls back**.
- Named Credential callouts require **Customize Application**.
- Anonymous Apex is great for:
  - Testing SOQL/SOSL quickly
  - Running migration scripts
  - Calling methods manually
  - Generating sample data

## Anonymous Apex vs Apex Class — Comparison Table

| Feature | Anonymous Apex | Apex Class (Saved in Org) |
|--------|----------------|----------------------------|
| **Stored in Metadata** | ❌ No | ✅ Yes |
| **Compilation** | Compiled **every time** it runs | Compiled once and reused |
| **Execution Context** | Runs as **current user** | Depends on class: `with sharing` / `without sharing` |
| **CRUD/FLS Enforcement** | Can **fail to compile** if user lacks access | Enforced only if code checks it manually |
| **Sharing Rules** | Applied (because it runs as current user) | Depends on class keywords |
| **Can Define Methods** | ✅ Yes (local methods only, no `static`) | ✅ Yes (full methods) |
| **Can Define Classes/Interfaces** | ⚠️ Allowed but **not saved** and treated as `virtual` | ✅ Fully supported and saved |
| **Can Call Other Apex Classes** | Only if user has **Author Apex** (API) | Always allowed |
| **DML Behavior** | Commits on success, rolls back on error (like normal transaction) | Same behavior |
| **Triggers Fire?** | ✅ Yes | ✅ Yes |
| **Scope** | Local to the anonymous block | Global within org |
| **Use Cases** | Quick tests, scripts, debugging | Actual application logic |
| **Where You Run It** | Dev Console, VS Code, Code Builder, Tooling API | Anywhere code is invoked (UI, triggers, REST, flows, etc.) |
| **Permissions Needed** | "API Enabled", and usually "Author Apex" | Depends: to run class you need CRUD/FLS access to objects it touches |
| **API Anonymous Execution Exception** | Users **without** “Author Apex” can run: built-in methods, webservice methods, and code they write directly | N/A |
