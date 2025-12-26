package kr.co.gocle.oklms.commbiz.util;
import javax.mail.Authenticator;


public class Myauthenticator extends Authenticator{
		
	private String id;
	private String pw;
	 
	public Myauthenticator(String id, String pw){
		this.id = id;
		this.pw = pw; 
	}
	protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
		return new javax.mail.PasswordAuthentication(id, pw);
	} 
}
