<%@page import="javax.activation.DataHandler"%>
<%@page import="javax.mail.util.ByteArrayDataSource"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="java.util.*"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 
 
 
 <%
 String subject = "코리아텍-제목";
 String content = "코리아텍-내용";
 
try{

Authenticator authenticator = new MyAuthenticator("heej", "ktech8756!");

Properties props = new Properties();
 
 props.put("mail.smtp.host", "email.koreatech.ac.kr");
 props.put("mail.smtp.port", "25");
 props.put("mail.smtp.auth", "true");
 /* 
  props.put("mail.smtp.starttls.enable", "true");
 props.put("mail.smtp.protocol", "smtp");
 props.put("mail.smtp.secureYn", "N");

 props.put("mail.smtp.debug", "true"); 
 
 
 */

 Session sess= Session.getDefaultInstance(props, authenticator);
 sess.setDebug(true);
 
 
 Message msg = new MimeMessage(sess);
 

 msg.setFrom(new InternetAddress("hoon_0188@koreatech.ac.kr"));//보내는 사람 설정
 InternetAddress address = new InternetAddress("suno99@wizi.co.kr"); 

 msg.setRecipient(Message.RecipientType.TO, address);//받는 사람설정
 msg.setSubject(subject);//제목 설정

 msg.setSentDate(new java.util.Date());//보내는 날짜 설정
 msg.setContent("학사) 내용","text/html;charset=euc-kr"); // 내용 설정 (HTML 형식)
 //msg.setDataHandler(new DataHandler(new ByteArrayDataSource(content, "text/html;charset=euc-kr")));
 Transport.send(msg);//메일 보내기

 } catch(Exception e){

    e.printStackTrace();

    return;

}


 %>
 
 <%!
//SMTP 접속 인증 클래스 추가

public class MyAuthenticator extends Authenticator{
   private String id;
   private String pw;

   public MyAuthenticator(String id, String pw){
       this.id = id;
       this.pw = pw; 
   }
   protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
       return new javax.mail.PasswordAuthentication(id, pw);
   }
}


 %>


 
 
