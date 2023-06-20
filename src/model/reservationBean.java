package model;

import java.util.Date;

public class reservationBean {
	private static final long serialVersionUID = 1L;

	private String userID;
	private String userPassword;
	private String userName;
	private int role;
	private String userAddress;
	private String userPhoneNumber;
	private String userEmail;
	private int bookingNO;
	private Date bookingTime;
	/**
	 * @return userID
	 */
	public String getUserID() {
		return userID;
	}
	/**
	 * @param userID セットする userID
	 */
	public void setUserID(String userID) {
		this.userID = userID;
	}
	/**
	 * @return userPassword
	 */
	public String getUserPassword() {
		return userPassword;
	}
	/**
	 * @param userPassword セットする userPassword
	 */
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	/**
	 * @return userName
	 */
	public String getUserName() {
		return userName;
	}
	/**
	 * @param userName セットする userName
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	/**
	 * @return role
	 */
	public int getRole() {
		return role;
	}
	/**
	 * @param role セットする role
	 */
	public void setRole(int role) {
		this.role = role;
	}
	/**
	 * @return userAddress
	 */
	public String getUserAddress() {
		return userAddress;
	}
	/**
	 * @param userAddress セットする userAddress
	 */
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	/**
	 * @return userPhoneNumber
	 */
	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}
	/**
	 * @param userPhoneNumber セットする userPhoneNumber
	 */
	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}
	/**
	 * @return userEmail
	 */
	public String getUserEmail() {
		return userEmail;
	}
	/**
	 * @param userEmail セットする userEmail
	 */
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	/**
	 * @return bookingNO
	 */
	public int getBookingNO() {
		return bookingNO;
	}
	/**
	 * @param bookingNO セットする bookingNO
	 */
	public void setBookingNO(int bookingNO) {
		this.bookingNO = bookingNO;
	}
	/**
	 * @return bookingTime
	 */
	public Date getBookingTime() {
		return bookingTime;
	}
	/**
	 * @param bookingTime セットする bookingTime
	 */
	public void setBookingTime(Date bookingTime) {
		this.bookingTime = bookingTime;
	}
	/**
	 * @return serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


}
