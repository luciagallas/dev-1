**Links:**
https://developer.salesforce.com/docs/atlas.en-us.pages.meta/pages/pages_controller_methods.htm

https://trailhead.salesforce.com/content/learn/modules/visualforce_fundamentals/visualforce_custom_controllers

## Lightning App Builder

**What it is:**  
A point-and-click tool used to build and customize the Lightning Experience UI.

**What you can do with it:**
- Create and customize Lightning Record Pages  
- Build Home Pages  
- Build App Pages  
- Add Lightning components (standard or custom)  
- Configure component visibility (filters)  
- Arrange UI regions (header, tabs, related lists, etc.)

**What it CANNOT do:**
- Run automation  
- Update records  
- Send notifications  
- Execute logic  

**Exam Clues:**  
Select Lightning App Builder when the requirement mentions:
- “Customize a Lightning page”
- “Add components to a page”
- “Change the layout without code”
- “Dynamic visibility on a record page”

This tool is **UI-only**, not an automation feature.


## SOQL Injection & escapeSingleQuotes

**What is SOQL injection?**  
SOQL injection happens when user input is concatenated directly into a dynamic SOQL string.  
A malicious user can inject additional SOQL to change the query and access data they shouldn't.

**Example of vulnerable code (DO NOT DO THIS):**

```apex
String userInput = searchText; // value coming from UI
String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + userInput + '%\'';
List<Account> results = Database.query(query);

```

## Visualforce Getters (Custom Controller)

In Visualforce, data displayed in the page markup must come from:
- A variable (public property), or
- A **getter method** in the controller

Visualforce uses a naming convention:
- If the page references `{!variableName}`,  
  the controller must have a method named **getVariableName()**.

### Rules:
- Getter name must start with **get**
- Followed by the variable name in **exact casing**
- No parameters
- Must return the correct data type

Example:
If markup uses `{!productList}`, Visualforce will automatically call:

```apex
public List<Product__c> getProductList()
```
---
## Custom Buttons — Key Facts

### Where can Custom Buttons be added?
- ✅ **Standard Page Layouts**
- ✅ **Custom Page Layouts**
- (They appear in the “Buttons, Links, and Actions” section of the layout editor.)

### On which objects do they work?
- ✅ **Standard Objects** (Account, Contact, Opportunity, etc.)
- ✅ **Custom Objects**

Custom Buttons are not limited to custom objects — they work on both.

---
## Static Resources in Salesforce

Static Resources allow you to upload external files to Salesforce so they can be used in Visualforce pages, Lightning components, and other platform features.

### What **can** be uploaded as a Static Resource?
The following file types are valid static resources:

- **ZIP / archive files**  
- **Images** (PNG, JPG, GIF, SVG, etc.)
- **Stylesheets** (CSS)
- **JavaScript files**
- **Other static assets** (fonts, icons, JSON files, etc.)

These resources can be referenced in Visualforce using the **$Resource** global variable:

```html
<apex:includeScript value="{!$Resource.myJsFile}"/>
<apex:stylesheet value="{!$Resource.myCssFile}"/>
<img src="{!$Resource.myImage}"/>
```