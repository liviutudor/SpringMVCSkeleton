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
<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n
	xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd\">\n
	<modelVersion>4.0.0</modelVersion>\n
	<groupId>$GROUP_ID</groupId>\n
	<artifactId>$PRJ_NAME</artifactId>\n
	<packaging>war</packaging>\n
	<version>${PRJ_VERSION}-SNAPSHOT</version>\n
	<name>$PRJ_NAME</name>\n
	<inceptionYear>$CURR_YEAR</inceptionYear>\n
	<description>$PRJ_DESC</description>\n
	<url>$PRJ_URL</url>\n
	<developers>\n
		<developer>\n
			<name>Liviu Tudor</name>\n
			<id>liviut</id>\n
			<email>me at liviutudor.com</email>\n
		</developer>\n
	</developers>\n
	<repositories>\n
		<repository>\n
			<snapshots>\n
				<enabled>false</enabled>\n
			</snapshots>\n
			<id>central</id>\n
			<name>Maven Repository Switchboard</name>\n
			<url>http://repo1.maven.org/maven2</url>\n
		</repository>\n
	</repositories>\n
	\n
	<properties>\n
		<project.build.jdkVersion>1.6</project.build.jdkVersion>\n
		<spring.version>3.0.6.RELEASE</spring.version>\n
	</properties>\n
	\n
	<dependencies>\n
		<dependency>\n
			<groupId>junit</groupId>\n
			<artifactId>junit</artifactId>\n
			<version>4.8.1</version>\n
			<scope>test</scope>\n
		</dependency>\n
		<dependency>\n
			<groupId>javax.servlet</groupId>\n
			<artifactId>servlet-api</artifactId>\n
			<version>2.5</version>\n
			<scope>provided</scope>\n
		</dependency>\n
		<dependency>\n
			<groupId>javax.servlet</groupId>\n
			<artifactId>jstl</artifactId>\n
			<version>1.2</version>\n
		</dependency>\n
		<dependency>\n
			<groupId>org.springframework</groupId>\n
			<artifactId>spring-core</artifactId>\n
			<version>\${spring.version}</version>\n
		</dependency>\n
		<dependency>\n
			<groupId>org.springframework</groupId>\n
			<artifactId>spring-jdbc</artifactId>\n
			<version>\${spring.version}</version>\n
		</dependency>\n
		<dependency>\n
			<groupId>org.springframework</groupId>\n
			<artifactId>spring-webmvc</artifactId>\n
			<version>\${spring.version}</version>\n
		</dependency>\n
		<dependency>\n
			<groupId>org.springframework</groupId>\n
			<artifactId>spring-context</artifactId>\n
			<version>\${spring.version}</version>\n
		</dependency>\n
		<dependency>\n
			<groupId>org.springframework</groupId>\n
			<artifactId>spring-test</artifactId>\n
			<version>\${spring.version}</version>\n
			<scope>test</scope>\n
		</dependency>\n
	</dependencies>\n
	\n
	<build>\n
		<finalName>$PRJ_NAME</finalName>\n
		<defaultGoal>install</defaultGoal>\n
		<plugins>\n
			<plugin>\n
				<artifactId>maven-compiler-plugin</artifactId>\n
				<configuration>\n
					<source>\${project.build.jdkVersion}</source>\n
					<target>\${project.build.jdkVersion}</target>\n
				</configuration>\n
			</plugin>\n
		</plugins>\n
	</build>\n
</project>
"

WEB_XML="
<!DOCTYPE web-app PUBLIC \"-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN\" \"http://java.sun.com/dtd/web-app_2_3.dtd\">\n
<web-app>\n
  <display-name>$PRJ_NAME</display-name>\n
     <servlet>\n
        <servlet-name>$PRJ_NAME</servlet-name>\n
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>\n
        <load-on-startup>1</load-on-startup>\n
    </servlet>\n
    \n
    <servlet-mapping>\n
        <servlet-name>$PRJ_NAME</servlet-name>\n
        <url-pattern>/</url-pattern>\n
    </servlet-mapping>\n
    \n
    <!-- allow robots.txt -->\n
    <servlet-mapping>\n
        <servlet-name>default</servlet-name>\n
        <url-pattern>*.txt</url-pattern>\n
    </servlet-mapping>\n
    \n
    <!-- allow favicon.ico -->\n
    <servlet-mapping>\n
        <servlet-name>default</servlet-name>\n
        <url-pattern>*.ico</url-pattern>\n
    </servlet-mapping>\n
    \n
    <!-- allow everything under /img/ -->\n
    <servlet-mapping>\n
        <servlet-name>default</servlet-name>\n
        <url-pattern>/img/*</url-pattern>\n
    </servlet-mapping>\n
    \n
    <!-- allow everything under css -->\n
    <servlet-mapping>\n
        <servlet-name>default</servlet-name>\n
        <url-pattern>/css/*</url-pattern>\n
    </servlet-mapping>\n
</web-app>
"

SERVLET_XML="
<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n
<beans xmlns=\"http://www.springframework.org/schema/beans\"\n
       xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n
       xmlns:p=\"http://www.springframework.org/schema/p\"\n
       xmlns:context=\"http://www.springframework.org/schema/context\"\n
       xsi:schemaLocation=\"\n
        http://www.springframework.org/schema/beans\n
        http://www.springframework.org/schema/beans/spring-beans-3.0.xsd\n
        http://www.springframework.org/schema/context\n
        http://www.springframework.org/schema/context/spring-context-3.0.xsd\">\n
\n
    <context:component-scan base-package=\"$PKG_NAME\"/>\n
\n
    <bean id=\"viewResolver\" class=\"org.springframework.web.servlet.view.UrlBasedViewResolver\">\n
        <property name=\"viewClass\" value=\"org.springframework.web.servlet.view.JstlView\"/>\n
        <property name=\"prefix\" value=\"/WEB-INF/jsp/\"/>\n
        <property name=\"suffix\" value=\".jsp\"/>\n
    </bean>\n
\n
</beans>
"

APP_CONTEXT_XML="
<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n
<beans xmlns=\"http://www.springframework.org/schema/beans\"\n
        xmlns:context=\"http://www.springframework.org/schema/context\"\n
        xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n
        xsi:schemaLocation=\"http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd \n
       http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd\">\n
\n
        <bean\n
                class=\"org.springframework.beans.factory.config.PropertyPlaceholderConfigurer\">\n
                <property name=\"locations\">\n
                        <list>\n
                                <value>classpath*:config/*.properties</value>\n
                        </list>\n
                </property>\n
                <property name=\"ignoreResourceNotFound\" value=\"true\" />\n
        </bean>\n
</beans>
"

HOME_JSP="
<%@ taglib uri=\"http://java.sun.com/jstl/core\" prefix=\"c\"%>\n
<%@page import=\"$PKG_NAME.*\"%>\n
<jsp:useBean id=\"param_name\" scope=\"request\" class=\"java.lang.String\" />\n
<html>\n
<head>\n
<title>$PRJ_NAME</title>\n
</head>\n
<body>\n
<p>Hello, <c:out value=\"\${param_name}\"/>!</p>\n
</body>\n
</html>
"

ROBOTS_TXT="
# Disallow robots to index any part of our contents\n
User-agent: *\n
Disallow: /\n
"

INDEX_JSP="
<%\n
response.sendRedirect( \"/home\");\n
%>
"

HOME_JAVA="
package $PKG_NAME;\n
\n
import java.io.IOException;\n
import java.util.List;\n
\n
import javax.servlet.http.HttpServletRequest;\n
import javax.servlet.http.HttpServletResponse;\n
import javax.servlet.http.HttpSession;\n
\n
import org.springframework.stereotype.Controller;\n
import org.springframework.web.bind.annotation.RequestMapping;\n
import org.springframework.web.bind.annotation.RequestMethod;\n
import org.springframework.web.servlet.ModelAndView;\n
\n
@Controller\n
public class HomeController {\n
    @RequestMapping(value = \"/home\", method = RequestMethod.GET)\n
    public ModelAndView home(HttpSession session, HttpServletResponse response) throws IOException {\n
        return new ModelAndView(\"home\", \"param_name\", \"world\");\n
    }\n
}
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
# src/main/java/package
mkdir $PKG_NAME
cd $PKG_NAME
echo -e $HOME_JAVA > HomeController.java
cd ..

cd ..
# src/main/resources
mkdir resources
cd resources
# src/main/resources/config
mkdir config
cd config
touch $PRJ_NAME.properties
cd ..
cd ..
# src/main/webapp
mkdir webapp
cd webapp
echo -e $ROBOTS_TXT > robots.txt
echo -e $INDEX_JSP > index.jsp
mkdir WEB-INF
cd WEB-INF
echo -e $WEB_XML > web.xml
SERVLET_FILE="$PRJ_NAME-servlet.xml"
echo -e $SERVLET_XML > $SERVLET_FILE
echo -e $APP_CONTEXT_XML > appicationContext.xml
mkdir jsp
cd jsp
echo -e $HOME_JSP > home.jsp
cd ..
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
