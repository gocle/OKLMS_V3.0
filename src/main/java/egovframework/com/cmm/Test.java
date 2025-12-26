package egovframework.com.cmm;

import java.util.regex.Pattern;

import kr.co.gocle.oklms.commbiz.util.SecurityUtil;


public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String pw = "gocleadmin";
		System.out.println(SecurityUtil.encryptSha256(pw));
		
		//ZjY3YjZiYzMyOTBlZjc3N2ZjYTIwZTNlMzVmZmE3OGJlNmE2MjUzOGFiNTM5ZDNlMzk1YTNlYzkyNGMyNjcwMQ==
	}

}
