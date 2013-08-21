---
layout: post
title: Tutorial of the Struts2 ModelDriven
date: 2013-08-19 09:11:44
categories:
    - Java
    - Struts2
---
Content
===
Step 1
---
create a class to store form data 

``` java
/*
 * This is Customer object used to store data from form
 */
package com.tut;

public class Customer {
    private String name;
    private String[] hobby;

    public void setHobby(String[] s) {
        hobby = s;
    }

    public String getHobby() {
        return hobby;
    }

    public void setName(String s) {
        name = s;
    }

    public String getName() {
        return name;
    }
}
```
Step 2
---
In the action class, implements the ModelDriven with customer class and a getModel function.

``` java
package com.tut;

import com.tut.Customer;

public class HelloAction extends ActionSupport implements ModelDriven<Customer> {

    // Declare the Customer object
    private Customer model = new Customer();

    public String execute() {
        return "success";
    }

    // get model
    public Customer getModel() {
        return model;
    }
}
```
Step 3
---
In your index page, create a form with textfield and checkboxlist.

``` html
<s:form action="doit">
    <s:textfield name="name" />
    <s:checkboxlist name="hobby" />
    <s:submit/>
</s:form>
```
Step 4
---
In the result page.

``` html
<s:property value="name"/>
<s:property value="hobby"/>
```
Reference
===
[Link1](http://www.dzone.com/tutorials/java/struts-2/struts-2-example/struts-2-model-driven-action-example-1.html)  
[Link2](http://www.mkyong.com/struts2/struts-2-modeldriven-example/)  
[Link3](http://blog.yam.com/wsc0918/article/19944613)  
