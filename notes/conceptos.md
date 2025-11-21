# New Concepts for the Salesforce Developer Exam

This file collects concepts that appears while practicing exam questions.  
Each section explains **what it is**, **where it is configured**, and **how it appears in the exam**.

## Custom Notifications
**What it is:**  
Custom in-app or push notifications that appear in Salesforce (bell icon) or on mobile.

**Where it is configured:**  
- Setup → Notification Builder → Custom Notifications  
- Sent from **Flow Builder** or **Process Builder**

**When it appears in exam questions:**  
If the question mentions:  
- “in-app notification”  
- “custom notification”  
- “alert a manager inside Salesforce without email”  


## Flow Builder

**What it is:**  
The main declarative automation tool in Salesforce (clicks, not code).  
Handles multi-step logic, branching, decisions, scheduled automation, and more.

**Used for:**  
- Updating records  
- Creating related records  
- Sending custom notifications  
- Complex logic that replaces Workflows and Process Builder  
- Screen flows for UI interactions

**When it appears in exam questions:**  
Look for key phrases like:  
- “automate a multi-step process”  
- “send a custom notification”  
- “record-triggered automation”  
- “replace a workflow rule or process builder”


## Assignment Rule

**What it is:**  
Automation that determines **who becomes the owner** of a record.  
Only applies to **Leads** and **Cases**.

**Used for:**  
- Assigning new leads to the correct salesperson or queue  
- Routing cases to a support queue based on criteria

**When it appears in exam questions:**  
If the question says:  
- “assign to correct owner”  
- “route leads based on region”  
- “automatically assign new cases”

## Approval Process

**What it is:**  
A structured, multi-step review and approval mechanism.

**Used for:**  
- Requiring manager approval  
- Locking/unlocking records  
- Sending email alerts  
- Updating fields upon approval or rejection

**When it appears in exam questions:**  
Look for wording like:  
- “record must be approved before…”  
- “multi-step approval”  
- “manager review required”

⚠️ **Important:** Approval Processes do *not* send custom notifications.  
Only emails and field updates.


## Lightning App Builder

**What it is:**  
A UI configuration tool to build pages (Record Pages, Home Pages, App Pages).

**Used for:**  
- Adding Lightning components  
- Designing page layouts  
- Building custom app pages

**When it appears in exam questions:**  
If the question is only about **UI changes** and not business logic, the answer may be Lightning App Builder.

## Multi-Tenant Architecture (Very Important)

**What it is:**  
Salesforce runs multiple customers on the same physical infrastructure.  
Each org shares CPU, memory, storage, and compute resources.

**Key concepts for the exam:**

- **Governor Limits** are required to prevent one org from consuming too many shared resources.  
- **CPU time, SOQL limits, DML limits, heap size** → enforced per transaction.
- **Organization Id** isolates each customer’s data.
- **API calls are NOT unlimited** — every org has daily API call limits.
- **Multi-tenancy = many customers share one instance**.

**Common exam pattern:**  
If you see anything about *shared resources*, *performance fairness*, *governor limits*, or *CPU time*, the correct answer is almost always related to **Gov Limits or multi-tenant design**.
