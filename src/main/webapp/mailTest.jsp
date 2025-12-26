<%@page import="javax.activation.DataHandler"%>
<%@page import="javax.mail.util.ByteArrayDataSource"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="java.util.*"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 
 
 
 <%
 String subject = "로컬-제목";
 String content = "로컬-내용";
 
 try{
 Properties props = new Properties();
 
 props.put("mail.smtp.host", "211.232.26.122");
 props.put("mail.smtp.port", "25");

 Session sess= Session.getDefaultInstance(props, null);
 sess.setDebug(true);
 Message msg = new MimeMessage(sess);
 

 msg.setFrom(new InternetAddress("no-reply@wizi.co.kr"));//보내는 사람 설정
 InternetAddress address = new InternetAddress("suno99@wizi.co.kr"); 

 msg.setRecipient(Message.RecipientType.TO, address);//받는 사람설정
 msg.setSubject(subject);//제목 설정

 msg.setSentDate(new java.util.Date());//보내는 날짜 설정
 //msg.setContent("학사) 내용","text/html;charset=euc-kr"); // 내용 설정 (HTML 형식)
 msg.setDataHandler(new DataHandler(new ByteArrayDataSource(content, "text/html;charset=euc-kr")));
 Transport.send(msg);//메일 보내기

 } catch(Exception e){

    e.printStackTrace();

    return;

}


 %>
 
 


 
 
