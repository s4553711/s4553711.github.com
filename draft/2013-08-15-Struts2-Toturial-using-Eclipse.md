---
layout: post
title: Struts2 Toturial using Eclipse
date: 2013-08-15 14:14:30
categories:
    - Java
    - Struts2
---
Tutorial
===
Tree View of this tutorial
---

![Struts2 Tree View](http://i.imgur.com/Sv3NUbQ.png)

Let Start
---
- Download [Struts2](http://ftp.mirror.tw/pub/apache//struts/binaries/struts-2.3.15.1-all.zip) and extract it.
- Create Dynamic Web Project in eclipse
- Copy lib in Struts2 lib folder to ***WebContent/WEB-INF/lib***
    - commons-fileupload-1.3.jar
    - commons-io-2.0.1.jar
    - commons-lang-2.4.jar
    - commons-lang3-3.1.jar
    - commons-logging-1.1.3.jar
    - commons-logging-api-1.1.jar
    - freemarker-2.3.19.jar
    - javassist-3.11.0.GA.jar
    - ognl-3.0.6.jar
    - struts2-core-2.3.15.1.jar
    - xwork-core-2.3.15.1.jar
    
- Create web.xml under folder WEB_INF

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" id="WebApp_ID" version="2.5">
   <display-name>Struts 2</display-name>
   <filter>
      <filter-name>struts2</filter-name>
      <filter-class>
         org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter
      </filter-class>
   </filter>
   
   <filter-mapping>
      <filter-name>struts2</filter-name>
      <url-pattern>/*</url-pattern>
   </filter-mapping>
   <welcome-file-list>
      <welcome-file>index</welcome-file>
   </welcome-file-list>   
</web-app>
```

- Create Action

The actions below are used to get parameter submitted from form through browser and output to the result page.

**VcfAction.java**

``` java
package com.bioit;

public class VcfAction {
    
    private String name;
    
    public VcfAction() {    
    }
    
    public String execute() throws Exception {
        return "success";
    }
    
    public void setName (String s) {
        name = s;
    }
    
    public String getName () {
        return name;
    }
}
```

**InitPage.java**

``` java
package com.bioit;

public class InitPage {
    public InitPage () {    
    }

    public String execute () throws Exception {
        return "success";
    }
}
```

- Create JSP under WebContent

**index.jsp**

``` html
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
    <title>Index Page</title>
</head>
<body>
    <s:form action="hello">
        <s:textfield name="name"  label="Your Name"/>
        <s:submit/>
    </s:form>
</body>
</html>
```

**report.jsp**

``` html
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
    <title>Index Page</title>
</head>
<body>
<p>
    Hi your name is <s:property value="name"/>
</p>
</body>
</html>
```

- Create Struts2.xml under **WEB-INF/classes**

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE struts PUBLIC
   "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
   "http://struts.apache.org/dtds/struts-2.0.dtd">
<struts>
    <constant name="struts.devMode" value="true" />
    
    <package name="helloworld" extends="struts-default">
        <action name="index" class="com.bioit.InitPage" method="execute">
            <result name="success">/index.jsp</result>
        </action> 
                
      <action name="hello" class="com.bioit.VcfAction"  method="execute">          
            <result name="success">/report.jsp</result>
      </action>
    </package>
</struts>
```
Reference
---
[Link1](http://viralpatel.net/blogs/tutorial-create-struts-2-application-eclipse-example/comment-page-4/)
