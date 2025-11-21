## Approval Process
**What it is:**  
A structured multi-step review process used when a record must be approved by one or more people.

**What it can do:**  
- Send email alerts  
- Update fields  
- Lock/unlock records  
- Create tasks  

**What it CANNOT do:**  
- Send custom in-app notifications  

**When it appears in exam questions:**  

## Assignment Rule
**What it is:**  
Logic that automatically assigns ownership of **Leads** or **Cases**.

**What it can do:**  
- Assign a Lead to the correct salesperson  
- Assign a Case to the correct queue  

**What it CANNOT do:**  
- Trigger notifications  
- Perform updates  
- Automate logic beyond routing ownership 

-- 

## Flow Builder
**What it is:**  
The primary Salesforce automation tool for declarative logic (no code).  
Replaces Workflow Rules and Process Builder.

**What it can do:**  
- Send **custom in-app notifications**  
- Update/create/delete records  
- Call Apex  
- Make decisions/branches  
- Run on record-triggered events  

**Exam clue:**  
If the question mentions:
- “custom notification”
- “in-app notification”
- “complex automation”
- “replace workflow/process builder”


## Failed Flow Interviews

When a flow fails, Salesforce may save the **failed flow interview**, which allows you to open the exact run in Flow Builder, see the executed path, and debug the issue.  
If the interview *is saved*, the flow error email includes a **link** to debug it.  
If it’s *not saved*, the email contains **no link**.

### When Failed Flow Interviews ARE Saved
(Fails are saved only for flows built with the **Free-Form** layout)

- Screen Flows  
- Record-Triggered Flows  
- Schedule-Triggered Flows  
- Autolaunched Flows (not triggered)

Saved interviews are available for **up to 14 days**.

---

### When Failed Flow Interviews Are NOT Saved
If the interview isn’t saved, **no debug link** appears in the email.

A failed interview is *not saved* when:

- The flow comes from a **managed package** and isn’t a template  
- The interview was **paused and then resumed**, and the failure happens after the resume  
- The error is **handled** (the element has a fault connector)  
- The failure happens during an **Apex test method**  
- The flow is a **standard Salesforce flow**  
- The flow’s metadata field **Status = Draft or InvalidDraft**  
- The flow is a **Platform Event–Triggered Flow** (very common exam correct answer)

---

### Storage & System Limits (When Interviews Are Saved)
- Max **100** failed interviews per flow per 24 hours  
- For a batch ≤200 failed runs in one transaction → only **one** interview saved  
- Max **3,000** failed interviews per org per 24 hours  
- Interviews **larger than 1 MB** aren’t saved  
- If the org already has **>1 GB** of saved failed interviews → new ones aren’t saved  
- These interviews **don’t count** toward data, file, or paused-flow storage limits

---

## Flow Screen Component Visibility

**What it is:**  
Flow Screen Components allow **conditional visibility**, meaning a field or section appears only when certain criteria are met.

**How it works:**  
You can define visibility rules on each component, such as:
- Show a field only if a checkbox is selected  
- Show a section only if a picklist has a specific value  
- Hide inputs until a previous field is completed  

**Key points:**  
- Conditional visibility **is supported directly on screen components**  
- Lightning Record Page visibility filters do **not** control Flow Screens  
- Page Layouts cannot determine visibility inside a Flow  
- Works for standard, custom, and AppExchange screen components  

**Use case:**  
To display fields only when they’re relevant (example: during a student registration flow),  
✔️ **Define visibility criteria on the screen components.**


