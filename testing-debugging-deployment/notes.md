
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

## Scratch Orgs — Quick Summary

Scratch orgs are **temporary, configurable, disposable DX environments** used for isolated development and automated testing.

### Use Scratch Orgs For:
- **Automated testing / CI pipelines**
- **Working on a single feature or update**
- **Reproducible, source-driven development**
- **Short-lived development and quick validation**

### Do NOT Use Scratch Orgs For:
- Shared environments (one-per-dev only)
- Replacing sandboxes (UAT, staging, full testing → sandboxes)
- Long-term or data-heavy testing
- Performance or integration testing

### Key Traits:
- Short lifespan  
- Created from a config file  
- Disposable (create → test → delete)  
- Perfect for Git-based development  


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

----

## 🧪 Apex Unit Tests — Summary & Best Practices
https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_best_practices.htm


### ✅ Test Data Behavior
- Test data **never commits**, so you don’t need to delete anything afterward.
- Always create **all necessary test data** inside the test class.
- Prepare test data **before** calling `Test.startTest()`.
- Tests must not rely on existing org data.
---

### 📏 Code Coverage Rules
- **75% Apex code coverage** is required to deploy to production.
- Every **trigger must have some coverage**.
- Lines of code inside **test classes or test methods are NOT counted** toward coverage.
- `System.debug()` lines are not counted.
- Focus on covering **all use cases**, not just hitting 75%.
---

### 🔀 Conditional Logic Coverage
- If your code contains branches (`if/else`, ternary operators, loops),  
  → **each branch must be tested separately**.
- Provide both **valid and invalid inputs** to exercise all paths.
---

### 🧩 Assertions & Validation
- Use `System.assert()`, `System.assertEquals()`, or the Assert class  
  to verify that logic behaves as expected.
- Catch exceptions when appropriate and **assert** that they occur.
---

### 👤 Testing with User Contexts
- Use `System.runAs()` to execute code under a specific user’s permissions.
- This is required when testing behavior affected by FLS, sharing, or profiles.
---

### 🚀 Bulk Testing Requirements
- Test bulk behavior using **at least 20 records**.
- Ensure triggers handle:
  - Single record operations  
  - Bulk operations  
  - Mixed DML scenarios
---

### 🔄 Record Behavior Notes
- Do NOT assume record IDs are sequential.
- Use `ORDER BY` in your SOQL queries when testing expected result ordering.
---

### 🧵 Parallel Test Execution
- Tests run in parallel when executed from the Salesforce UI.
- Parallel tests can cause:
  - `UNABLE_TO_LOCK_ROW` errors  
  - deadlocks when inserting duplicate indexed fields  
- To disable parallel execution:
  **Setup → Apex Test Execution → Options → Disable Parallel Apex Testing**

- You can explicitly allow parallel tests using:  
  ```apex
  @IsTest(IsParallel=true)

---

## Custom Exceptions in Apex

### What Are Custom Exceptions?
Custom exceptions are Apex classes that extend Salesforce’s built-in `Exception` class.  
They allow developers to define specific, meaningful error types instead of using generic system exceptions.

Custom exceptions:
- Must extend `Exception`
- Should end with the word **Exception**
- Can include custom constructors, variables, and methods
- Are thrown manually using the `throw` keyword

---

### How to Create a Custom Exception

#### A basic custom exception looks like this:

```apex
public class MyException extends Exception {}
```
***Valid Ways to Instantiate (and Throw) a Custom Exception***

**You can create a custom exception using these four valid constructor patterns:**

✔ 1. No arguments
```apex
throw new MyException();
```
✔ 2. With an error message
```apex
throw new MyException('Something went wrong');
```
✔ 3. With an inner exception (cause)
```apex
throw new MyException(e);
```
✔ 4. With message + inner exception
```apex
throw new MyException('Something went wrong', e);
```
## Salesforce Extension Pack – What It Enables in VS Code

The Salesforce Extension Pack adds a full development toolkit inside Visual Studio Code.  
It allows developers to interact directly with their Salesforce orgs, run code, deploy components, and execute tests.

### ✅ Capabilities Enabled by the Extension Pack

- **Execute SOQL queries**  
  You can run SOQL directly from VS Code using the Command Palette (Ctrl+Shift+P → SFDX: Execute SOQL Query).

- **Deploy metadata components**  
  Allows pushing/pulling Apex classes, triggers, LWC, Visualforce pages, objects, permissions, etc., between your local project and the Salesforce org.

- **Run Apex tests**  
  You can run individual test classes, specific methods, or entire test suites directly from VS Code.

### Additional Features Included

- Run anonymous Apex  
- Debug Apex classes and triggers  
- Synchronize local project files with the server  
- Create and run Apex test suites  
- Use the integrated Salesforce CLI  
- Auto-generate code (Apex, LWC, triggers, etc.)

