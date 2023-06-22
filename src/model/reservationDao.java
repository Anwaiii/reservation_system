package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class reservationDao {
	Connection conn = null;
	PreparedStatement stmt = null;

	//	新規ユーザー登録のメソッド
	public int newUserRegister(String userID,String password,String userName,String userAddress,
			String userPhoneNumber,String userEmail) {
		int num = 0;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql = "insert into user_table (USER_ID,USER_PASSWORD,USER_NAME,USER_ROLE,USER_ADDRESS,"
					+ "USER_PHONENUMBER,USER_EMAIL)"
					+ " VALUES(?,?,?,1,?,?,?)";

			stmt = conn.prepareStatement(sql);

			stmt.setString(1, userID);
			stmt.setString(2, password);
			stmt.setString(3, userName);
			stmt.setString(4, userAddress);
			stmt.setString(5, userPhoneNumber);
			stmt.setString(6, userEmail);


			//	item_tableが更新できたとき、numは1になる。そして、stock_tableの更新が行われる
			num = stmt.executeUpdate();

			stmt.close();

			conn.commit();

		}catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}finally {

			try {
				if(stmt != null) {
					stmt.close();
				}

				if(conn != null) {
					conn.rollback();
					conn.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return num;
	}


	//	新規登録の時にuserIDが既に存在しているかをチェックするメソッド
	public String checkUserID(String userID) {

		ResultSet rs=null;
		String id="";
		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql ="select user_id from user_table where user_id=? ";


			stmt = conn.prepareStatement(sql);
			stmt.setString(1, userID);

			rs=stmt.executeQuery();

			//	ItemBeanクラスのobjectを作り、返された結果をこのobjectのフィールドに代入する
			while(rs.next()) {
				id = rs.getString("user_id");
			}

			rs.close();
		}catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}finally {

			try {
				if(stmt != null) {
					stmt.close();
				}

				if(conn != null) {
					conn.rollback();
					conn.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return id;
	}

	public reservationBean login(String userID,String password) {

		reservationBean reservationBean = new reservationBean();
		ResultSet rs=null;
		String userID_result = "";
		String userPassword_result = "";

		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql ="select * from user_table where user_id = ? ";

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, userID);

			rs=stmt.executeQuery();

			//
			while(rs.next()) {
				userID_result = rs.getString("user_id");
				userPassword_result = rs.getString("user_password");
				if(userID_result.equals(userID) && userPassword_result.equals(password)) {
					reservationBean.setUserID(rs.getString("user_id"));
					reservationBean.setUserName(rs.getString("user_name"));
					reservationBean.setRole(rs.getInt("user_role"));
					reservationBean.setUserAddress(rs.getString("user_address"));
					reservationBean.setUserPhoneNumber(rs.getString("user_phonenumber"));
					reservationBean.setUserEmail(rs.getString("user_email"));

					return reservationBean;
				}
			}



			rs.close();
		}catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}finally {

			try {
				if(stmt != null) {
					stmt.close();
				}

				if(conn != null) {
					conn.rollback();
					conn.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public ArrayList<String> printUserCalendar(int currentYear,int currentMonth,int maxDay) {

		ResultSet rs=null;
		String month = String.format("%02d", currentMonth+1); // currentMonth = 5, month = 6
		ArrayList<String> reservationResult = new ArrayList<>();
		int num=0;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			for (int i = 1; i <= maxDay; i++) {
				String date = currentYear+"-"+month+"-"+String.format("%02d",i)+"%";
				String sql ="select count(booking_time) count from time_table where TO_CHAR(booking_time, 'YYYY-MM-DD') LIKE ?";

				stmt = conn.prepareStatement(sql);
				stmt.setString(1, date);

				rs=stmt.executeQuery();

				while(rs.next()) {
				 num = rs.getInt("count");
				if(num < 7) {
					reservationResult.add("予約");
				}else {
					reservationResult.add("満席");
				}

				}

			}

			//String sql ="select count(BOOKING_TIME) count from time_table where TO_CHAR(booking_time, 'YYYY-MM-DD') LIKE ?";
				rs.close();

		}catch(SQLException | ClassNotFoundException e) {
			System.out.println("error");
			e.printStackTrace();
		}finally {

			try {
				if(stmt != null) {
					stmt.close();
				}

				if(conn != null) {
					conn.rollback();
					conn.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return reservationResult;
	}

	public ArrayList<String> printAvailableTime(String date) {
		ResultSet rs=null;

		ArrayList<String> reservationResult = new ArrayList<>();

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);


				String sql ="select TO_CHAR(booking_time, 'HH24') unvailableTime"
						+ " from time_table where TO_CHAR(booking_time, 'YYYY-MM-DD') LIKE ?";

				stmt = conn.prepareStatement(sql);
				stmt.setString(1, date + "%");

				rs=stmt.executeQuery();

				while(rs.next()) {
				reservationResult.add(rs.getString("unvailableTime"));
			}

			//String sql ="select count(BOOKING_TIME) count from time_table where TO_CHAR(booking_time, 'YYYY-MM-DD') LIKE ?";
				rs.close();

		}catch(SQLException | ClassNotFoundException e) {
			System.out.println("error");
			e.printStackTrace();
		}finally {

			try {
				if(stmt != null) {
					stmt.close();
				}

				if(conn != null) {
					conn.rollback();
					conn.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return reservationResult;
	}
}
