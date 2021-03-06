#!/bin/bash

# =========================================================================
# = Creates a skeleton file structure for maven / Spring MVC 3.0 Java app =
# =========================================================================

CURR_YEAR=`date +%Y`

# Name of the project (directory will be created with same name)
PRJ_NAME="livmvc"
if [ ! -z "$1" ] ; then
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
TMPDIR=$(mktemp -d /tmp/$PRJ_NAME.XXXXXXX)
BUCKET_NAME="liviutudor.repository"

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

	<organization>
		<name>Liviu Tudor</name>
		<url>http://liviutudor.com</url>
	</organization>

	<developers>
		<developer>
			<name>Liviu Tudor</name>
			<id>liviut</id>
			<email>me at liviutudor.com</email>
		</developer>
	</developers>

 	<scm>
	    <connection>scm:git:git@github.com:liviutudor/${PRJ_NAME}.git</connection>
    	<developerConnection>scm:git:git@github.com:liviutudor/${PRJ_NAME}.git</developerConnection>
    	<url>http://github.com/liviutudor/$PRJ_NAME</url>
		<tag>HEAD</tag>
	</scm>

	<!-- This enables using an S3-based repo -->
	<distributionManagement>
		<repository>
			<id>aws-release</id>
			<name>AWS Release Repository</name>
			<url>s3://$BUCKET_NAME/release</url>
		</repository>
		<snapshotRepository>
			<id>aws-snapshot</id>
			<name>AWS Snapshot Repository</name>
			<url>s3://$BUCKET_NAME/snapshot</url>
		</snapshotRepository>
    </distributionManagement>

	<repositories>
		<!-- S3-based repo -->
		<repository>
			<id>aws-release</id>
			<name>AWS Release Repository</name>
			<url>s3://$BUCKET_NAME/release</url>
		</repository>
		<repository>
			<id>aws-snapshot</id>
			<name>AWS Snapshot Repository</name>
			<url>s3://$BUCKET_NAME/snapshot</url>
		</repository>
POM_XMLEXPAND

cat >>${TMPDIR}/pom.xml<<'POM_XML'
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
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>

		<maven.aws-maven.version>4.8.0.RELEASE</maven.aws-maven.version>
		<maven.compiler.version>3.1</maven.compiler.version>
		<maven.release.version>2.5</maven.release.version>
		<maven.resources.version>2.6</maven.resources.version>
		<maven.surefire.version>2.17</maven.surefire.version>
		<maven.war.version>2.4</maven.war.version>

		<jstl.version>1.2</jstl.version>
		<servlet-api.version>2.5</servlet-api.version>
		<spring.version>4.0.5.RELEASE</spring.version>
		<junit.version>4.11</junit.version>
	</properties>

	<dependencies>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>servlet-api</artifactId>
			<version>${servlet-api.version}</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>${jstl.version}</version>
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
		<!-- Test deps -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>${spring.version}</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>${junit.version}</version>
			<scope>test</scope>
		</dependency>
	</dependencies>

	<build>
		<resources>
			<resource>
				<directory>src/main/resources</directory>
			</resource>
		</resources>
POM_XML

cat>>${TMPDIR}/pom.xml<<POM_XMLEXPAND
		<finalName>$PRJ_NAME</finalName>
POM_XMLEXPAND

cat>>${TMPDIR}/pom.xml<<'POM_XML'
		<defaultGoal>install</defaultGoal>
        <extensions>
            <extension>
                <groupId>org.springframework.build</groupId>
                <artifactId>aws-maven</artifactId>
                <version>${maven.aws-maven.version}</version>
            </extension>
        </extensions>
		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>${maven.compiler.version}</version>
				<configuration>
					<source>${project.build.jdkVersion}</source>
					<target>${project.build.jdkVersion}</target>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-surefire-plugin</artifactId>
				<version>${maven.surefire.version}</version>
<!--				<configuration>
					<excludes>
						<exclude>**/SomeTest</exclude>
					</excludes>
				</configuration> -->
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-war-plugin</artifactId>
				<version>${maven.war.version}</version>
			</plugin>

			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-resources-plugin</artifactId>
				<version>2.6</version>
				<configuration>
					<encoding>${project.build.sourceEncoding}</encoding>
				</configuration>
			</plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-release-plugin</artifactId>
                <version>${maven.release.version}</version>
                <configuration>
                    <allowTimestampedSnapshots>true</allowTimestampedSnapshots>
                    <preparationGoals>clean verify package install</preparationGoals>
                    <autoVersionSubmodules>true</autoVersionSubmodules>
                </configuration>
            </plugin>
		</plugins>
	</build>
</project>
POM_XML

cat > $TMPDIR/src/main/webapp/WEB-INF/web.xml <<WEB_XML
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://java.sun.com/xml/ns/javaee" xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
	id="$PRJ_NAME" version="2.5">
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
    xmlns:aop="http://www.springframework.org/schema/aop" xmlns:context="http://www.springframework.org/schema/context"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:task="http://www.springframework.org/schema/task"
    xmlns:p="http://www.springframework.org/schema/p"
    xmlns:mvc="http://www.springframework.org/schema/mvc"
    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.2.xsd
       http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-3.2.xsd
       http://www.springframework.org/schema/task http://www.springframework.org/schema/task/spring-task-3.2.xsd
       http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-3.2.xsd">

    <!-- **** BEGIN: Config files **** -->
    <bean
        class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
        <property name="locations">
            <list>
                <value>classpath*:config/*.properties</value>
            </list>
        </property>
        <property name="ignoreResourceNotFound" value="true" />
    </bean>
    <!-- **** END: Config files **** -->

    <mvc:annotation-driven />
    <context:component-scan base-package="liv" />

    <bean id="viewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver" p:order="1">
        <property name="viewClass" value="org.springframework.web.servlet.view.JstlView" />
        <property name="prefix" value="/WEB-INF/jsp/" />
        <property name="suffix" value=".jsp" />
    </bean>
</beans>
SERVLET_XML

cat > $TMPDIR/src/main/webapp/WEB-INF/jsp/home.jsp << HOME_JSP
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="$PKG_NAME.*"%>
<jsp:useBean id="param_name" scope="request" class="java.lang.String" />
<html>
<head>
<title>$PRJ_NAME</title>
</head>
<body>
HOME_JSP

cat >>$TMPDIR/src/main/webapp/WEB-INF/jsp/home.jsp<<'HOME_JSP'
<p>Hello, <c:out value="${param_name}"/>!</p>
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
