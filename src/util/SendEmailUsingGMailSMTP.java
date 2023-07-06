package util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmailUsingGMailSMTP {

   public void sendEmail(String title,String message,String email,String name) {
	   try {
			Properties property = new Properties();
			property.put("mail.smtp.auth", "true");
			property.put("mail.smtp.starttls.enable", "true");
			property.put("mail.smtp.host", "smtp.gmail.com");
			property.put("mail.smtp.port", "587");
			property.put("mail.smtp.debug", "true");

			Session session = Session.getInstance(property, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("reservesystem123@gmail.com", "bnoshhvddcosvlvz");
				}
			});

			MimeMessage mimeMessage = new MimeMessage(session);
			InternetAddress toAddress = new InternetAddress(email, name);
			mimeMessage.setRecipient(Message.RecipientType.TO, toAddress);
			InternetAddress fromAddress = new InternetAddress("reservesystem123@gmail.com", "no-reply");
			mimeMessage.setFrom(fromAddress);
			mimeMessage.setSubject(title, "ISO-2022-JP");
			mimeMessage.setText(message, "ISO-2022-JP");
			Transport.send(mimeMessage);
			System.out.println("メール送信が完了しました。");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}