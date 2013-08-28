#!/bin/bash

# =========================================================================
# = Creates a skeleton file structure for maven / Spring MVC 3.0 Java app =
# =========================================================================

CURR_YEAR=`date +%Y`

# Name of the project (directory will be created with same name)
PRJ_NAME="livmvc"
PRJ_DESC="This is a skeleton generated automatically by https://github.com/liviutudor/SpringMVCSkeleton"
PRJ_URL="http://liviutudor.com"
# version will be set to $PRJ_VERSION-SNAPSHOT
PRJ_VERSION="0.0.1"
# for the pom
GROUP_ID="liviutudor"
# java package for sources
PKG_NAME="liv"

POM_XML="
<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
	xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd\">
	<modelVersion>4.0.0</modelVersion>
	<groupId>$GROUP_ID</groupId>
	<artifactId>$PRJ_NAME</artifactId>
	<packaging>war</packaging>
	<version>${PRJ_VERSION}-SNAPSHOT</version>
	<name>$PRJ_NAME</name>
	<inceptionYear>$CURR_YEAR</inceptionYear>
	<description>$PRJ_DESC</description>
	<url>$PRJ_URL</url>
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
		<spring.version>3.0.6.RELEASE</spring.version>
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
			<version>\${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>\${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>\${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context</artifactId>
			<version>\${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>\${spring.version}</version>
			<scope>test</scope>
		</dependency>
	</dependencies>

	<build>
		<finalName>$PRJ_NAME</finalName>
		<defaultGoal>install</defaultGoal>
		<plugins>
			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<configuration>
					<source>\${project.build.jdkVersion}</source>
					<target>\${project.build.jdkVersion}</target>
				</configuration>
			</plugin>
		</plugins>
	</build>
</project>
"

WEB_XML="
<!DOCTYPE web-app PUBLIC \"-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN\" \"http://java.sun.com/dtd/web-app_2_3.dtd\">
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
"

# Top level dir
mkdir $PRJ_NAME
cd $PRJ_NAME

echo -e $POM_XML > pom.xml
mkdir src
mkdir target

# source
cd src
# src/main
mkdir main
cd main
# src/main/java
mkdir java
cd java 

cd ..
# src/main/resources
mkdir resources
# src/main/webapp
mkdir webapp
cd webapp
mkdir WEB-INF
cd WEB-INF
echo $WEB_XML > web.xml
cd ..
cd ..
cd ..
# source/test
mkdir test
cd test
mkdir java
cd ..

cd ..

# Finally back the f.. out to where we started
cd ..
