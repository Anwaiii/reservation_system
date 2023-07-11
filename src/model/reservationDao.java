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

	public int changePassword(String userID,String password,String newPassword) {

		reservationBean reservationBean = new reservationBean();
		ResultSet rs=null;
		String userID_result = "";
		String userPassword_result = "";
		int num=0;

		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql ="select user_password from user_table where user_id = ? ";

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, userID);
			rs=stmt.executeQuery();

			rs.next();

				userPassword_result = rs.getString("user_password");
				if(!userPassword_result.equals(password)) {
					return -2;
				}else {
					sql ="update user_table set user_password = ? where user_id = ? ";

					stmt = conn.prepareStatement(sql);
					stmt.setString(1, newPassword);
					stmt.setString(2, userID);
					num = stmt.executeUpdate();

				}

				stmt.close();
				rs.close();
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

	public reservationBean getUserInfo(String userID) {
		reservationBean userInfo = new reservationBean();
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

			while(rs.next()) {
					userInfo.setUserID(rs.getString("user_id"));
					userInfo.setUserName(rs.getString("user_name"));
					userInfo.setRole(rs.getInt("user_role"));
					userInfo.setUserAddress(rs.getString("user_address"));
					userInfo.setUserPhoneNumber(rs.getString("user_phonenumber"));
					userInfo.setUserEmail(rs.getString("user_email"));
					return userInfo;
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

	public int updateUser(String userID,String userName,String userAddress,String userPhoneNumber,String userEmail) {

		 // 更新失敗したとき、-1を返す
		int num = -1;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql = "update user_table set user_name = ?,"
					+ "user_address = ?,"
					+ "user_phonenumber = ?,"
					+ "user_email = ? where user_id= ?";

			stmt = conn.prepareStatement(sql);

			stmt.setString(1,userName);
			stmt.setString(2,userAddress);
			stmt.setString(3,userPhoneNumber);
			stmt.setString(4,userEmail);
			stmt.setString(5,userID);


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

	public int deleteUser(String userID) {
		int num = 0;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql = "delete from user_table where user_id = ? ";

			stmt = conn.prepareStatement(sql);

			stmt.setString(1, userID);
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

	public void deleteReservedRecord(String userID) {

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql = "delete from time_table where user_id = ? ";

			stmt = conn.prepareStatement(sql);

			stmt.setString(1, userID);
			stmt.executeUpdate();

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
	}


	public ArrayList<String> printUserCalendar(int currentYear,int currentMonth,int maxDay) {

		ResultSet rs=null;

		// currentMonthは0からはじまり、表示の際には+1が必要
		String month = String.format("%02d", currentMonth+1);
		ArrayList<String> reservationResult = new ArrayList<>();
		int num=0;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			for (int i = 1; i <= maxDay; i++) {
				String date = currentYear+"-"+month+"-"+String.format("%02d",i)+"%";


				// TO_CHAR関数を使うことで、明示的にbooking_timeを日付型から文字列に変換するので、LIKEが使える。
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

	// Hour値のリスト。Hourの値は10~16まで。
	public ArrayList<String> printAvailableTime(String date) {
		ResultSet rs=null;

		ArrayList<String> reservationResult = new ArrayList<>();

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

				// TO_CHAR関数を使うことで、明示的に日付型から文字列に変換するので、LIKEが使える。
			 	// selectのbooking_timeを好きな書式で必要な部分だけ取り出せる。ここはHourだけ取り出している。
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

	public int reserve(String dateAndTime,String userID) {
		int num = 0;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			System.out.println(dateAndTime);
			String sql = "insert into time_table(booking_no,booking_time,user_id) "
					+ "values (booking_no.nextval,TO_DATE(?, 'YYYY-MM-DD HH24'),?)";

			stmt = conn.prepareStatement(sql);

			stmt.setString(1, dateAndTime);
			stmt.setString(2, userID);

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

	public ArrayList<String> printUserAllReservation(String userID) {

		ResultSet rs=null;

		ArrayList<String> reservationResult = new ArrayList<>();

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);


				// TO_CHAR関数を使うことで、明示的にbooking_timeを日付型から文字列に変換するので、LIKEが使える。
				String sql ="select to_char(booking_time,'YYYY-MM-DD HH24') d from time_table where user_id = ? "
						+ " order by booking_time";

				stmt = conn.prepareStatement(sql);
				stmt.setString(1, userID);

				rs=stmt.executeQuery();

				while(rs.next()) {
					reservationResult.add(rs.getString("d"));
				}

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

	// 予約を更新する
	public int updateReservation(String newDate,String oldDate) {
		int num = 0;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql = "update time_table set booking_time = TO_DATE(?, 'YYYY-MM-DD HH24') "
					+ " where to_char(booking_time, 'YYYY-MM-DD HH24') like ?";

			stmt = conn.prepareStatement(sql);

			stmt.setString(1, newDate);
			stmt.setString(2, oldDate +"%");

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

	// 予約を取り消す
	public int cancelReservation(String date) {
		int num = 0;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);

			String sql = "delete time_table where to_char(booking_time, 'YYYY-MM-DD HH24') like ?";

			stmt = conn.prepareStatement(sql);

			stmt.setString(1, date +"%");

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

	// 予約の詳細とユーザーの情報を返す
	public reservationBean printReservationInfo(String date) {

		ResultSet rs=null;
		reservationBean userInfo = new reservationBean();

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","anson","123456");
			conn.setAutoCommit(false);


				// TO_CHAR関数を使うことで、明示的にbooking_timeを日付型から文字列に変換するので、LIKEが使える。
//				String sql ="select * from user_table where user_id = "
//						+ "(select user_id from time_table where to_char(booking_time, 'YYYY-MM-DD HH24') "
//						+ "like ?)";

				String sql="select * from user_table u join time_table t on u.user_id = t.user_id  "
						+ "where to_char(booking_time, 'YYYY-MM-DD HH24') like ?";

				stmt = conn.prepareStatement(sql);
				stmt.setString(1, date+"%");

				rs=stmt.executeQuery();

				while(rs.next()) {
					userInfo.setUserID(rs.getString("user_id"));
					userInfo.setUserName(rs.getString("user_name"));
					userInfo.setUserAddress(rs.getString("user_address"));
					userInfo.setUserPhoneNumber(rs.getString("user_phonenumber"));
					userInfo.setUserEmail(rs.getString("user_email"));
					userInfo.setBookingNO(rs.getInt("booking_no"));
				}

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
		return userInfo;
	}

}
