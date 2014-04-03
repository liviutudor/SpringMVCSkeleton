#!/bin/bash

# =========================================================================
# = Creates a skeleton file structure for maven / Spring MVC 3.0 Java app =
# =========================================================================

CURR_YEAR=`date +%Y`

# Name of the project (directory will be created with same name)
PRJ_NAME="livmvc"
if [ "$1" != "" ] ; then
	PRJ_NAME="$1"
	echo "Using project name $PRJ_NAME"
fi

PRJ_DESC="This is a skeleton generated automatically by https://github.com/liviutudor/SpringMVCSkeleton"
PRJ_URL="http://liviutudor.com"
# version will be set to $PRJ_VERSION-SNAPSHOT
PRJ_VERSION="0.0.1"
# for the pom
GROUP_ID="liviutudor"
# java package for sources
PKG_NAME="liv"
TMPDIR="/tmp/$PRJ_NAME.$$"

# Top level dir
mkdir -p $TMPDIR/src/main/{resources/config,webapp/WEB-INF/jsp,java/$PKG_NAME} $TMPDIR/src/test/java/$PKG_NAME $TMPDIR/target
touch $TMPDIR/src/main/resources/config/$PRJ_NAME.properties

cat >${TMPDIR}/pom.xml<<POM_XMLEXPAND
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>$GROUP_ID</groupId>
	<artifactId>$PRJ_NAME</artifactId>
	<packaging>war</packaging>
	<version>${PRJ_VERSION}-SNAPSHOT</version>
	<name>$PRJ_NAME</name>
	<inceptionYear>$CURR_YEAR</inceptionYear>
	<description>$PRJ_DESC</description>
	<url>$PRJ_URL</url>
POM_XMLEXPAND

cat >>${TMPDIR}/pom.xml<<'POM_XML'
	<developers>
		<developer>
			<name>Liviu Tudor</name>
			<id>liviut</id>
			<email>me at liviutudor.com</email>
		</developer>
	</developers>
	<repositories>
		<repository>
			<snapshots>
				<enabled>false</enabled>
			</snapshots>
			<id>central</id>
			<name>Maven Repository Switchboard</name>
			<url>http://repo1.maven.org/maven2</url>
		</repository>
	</repositories>

	<properties>
		<project.build.jdkVersion>1.6</project.build.jdkVersion>
		<spring.version>4.0.3.RELEASE</spring.version>
	</properties>

	<dependencies>
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.8.1</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>servlet-api</artifactId>
			<version>2.5</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-core</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>${spring.version}</version>
			<scope>test</scope>
		</dependency>
	</dependencies>

	<build>
POM_XML

cat>>${TMPDIR}/pom.xml<<POM_XMLEXPAND
		<finalName>$PRJ_NAME</finalName>
POM_XMLEXPAND
cat>>${TMPDIR}/pom.xml<<'POM_XML'
		<defaultGoal>install</defaultGoal>
		<plugins>
			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<configuration>
					<source>${project.build.jdkVersion}</source>
					<target>${project.build.jdkVersion}</target>
				</configuration>
			</plugin>
		</plugins>
	</build>
</project>
POM_XML

cat > $TMPDIR/src/main/webapp/WEB-INF/web.xml <<WEB_XML
<!DOCTYPE web-app PUBLIC "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN" "http://java.sun.com/dtd/web-app_2_3.dtd">
<web-app>
  <display-name>$PRJ_NAME</display-name>
     <servlet>
        <servlet-name>$PRJ_NAME</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <load-on-startup>1</load-on-startup>
    </servlet>

    <servlet-mapping>
        <servlet-name>$PRJ_NAME</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <!-- allow robots.txt -->
    <servlet-mapping>
        <servlet-name>default</servlet-name>
        <url-pattern>*.txt</url-pattern>
    </servlet-mapping>

    <!-- allow favicon.ico -->
    <servlet-mapping>
        <servlet-name>default</servlet-name>
        <url-pattern>*.ico</url-pattern>
    </servlet-mapping>

    <!-- allow everything under /img/ -->
    <servlet-mapping>
        <servlet-name>default</servlet-name>
        <url-pattern>/img/*</url-pattern>
    </servlet-mapping>

    <!-- allow everything under css -->
    <servlet-mapping>
        <servlet-name>default</servlet-name>
        <url-pattern>/css/*</url-pattern>
    </servlet-mapping>
</web-app>
WEB_XML

cat >$TMPDIR/src/main/webapp/WEB-INF/$PRJ_NAME-servlet.xml <<SERVLET_XML
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context-3.0.xsd">

    <context:component-scan base-package="$PKG_NAME"/>

    <bean id="viewResolver" class="org.springframework.web.servlet.view.UrlBasedViewResolver">
        <property name="viewClass" value="org.springframework.web.servlet.view.JstlView"/>
        <property name="prefix" value="/WEB-INF/jsp/"/>
        <property name="suffix" value=".jsp"/>
    </bean>

</beans>
SERVLET_XML

cat >$TMPDIR/src/main/webapp/WEB-INF/applicationContext.xml <<APP_CONTEXT_XML
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:context="http://www.springframework.org/schema/context"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd">

        <bean
                class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
                <property name="locations">
                        <list>
                                <value>classpath*:config/*.properties</value>
                        </list>
                </property>
                <property name="ignoreResourceNotFound" value="true" />
        </bean>
</beans>
APP_CONTEXT_XML

cat > $TMPDIR/src/main/webapp/WEB-INF/jsp/home.jsp << HOME_JSP
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@page import="$PKG_NAME.*"%>
<jsp:useBean id="param_name" scope="request" class="java.lang.String" />
<html>
<head>
<title>$PRJ_NAME</title>
</head>
<body>
<p>Hello, <c:out value="\${param_name}"/>!</p>
</body>
</html>
HOME_JSP

cat > $TMPDIR/src/main/webapp/robots.txt <<ROBOTS_TXT
# Disallow robots to index any part of our contents
User-agent: *
Disallow: /
ROBOTS_TXT


cat >$TMPDIR/src/main/webapp/index.jsp <<INDEX_JSP
<%
response.sendRedirect( "/home");
%>
INDEX_JSP

cat >$TMPDIR/src/main/java/$PKG_NAME/HomeController.java <<HOME_JAVA
package $PKG_NAME;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView home(HttpSession session, HttpServletResponse response) throws IOException {
        return new ModelAndView("home", "param_name", "world");
    }
}
HOME_JAVA

cat >$TMPDIR/src/test/java/$PKG_NAME/HomeControllerTest.java <<HOME_TEST_JAVA
package $PKG_NAME;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class HomeControllerTest {
	@Test
	public void testSimpleStuff() {
		assertEquals( "1", "1" );
	}
}
HOME_TEST_JAVA

mv $TMPDIR ./$PRJ_NAME
