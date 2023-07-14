package controller;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.reservationBean;
import model.reservationDao;
import util.SendEmailUsingGMailSMTP;

/**
 * Servlet implementation class UserReservationConfirmCon
 */
public class UserReservationConfirmCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserReservationConfirmCon() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UserReservationConfirmCon:get()");

		String dateDetail = request.getParameter("reservationDetail");

		String[] dateAndTime = dateDetail.split(" ");


		request.setAttribute("dateAndTime", dateAndTime);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/userReservationConfirm.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("UserReservationConfirmCon:post()");

		reservationDao reservationDao = new reservationDao();
		String dateAndTime = request.getParameter("date")+" "+request.getParameter("time");
		String userID = request.getParameter("userID");
		int num = 0;


		if(reservationDao.getUserInfo(userID) == null) {
			request.getSession().invalidate();
			response.sendRedirect("Login.jsp");
			return;
		}else {

			num = reservationDao.reserve(dateAndTime,userID);


		reservationBean user = reservationDao.printReservationInfo(dateAndTime);
		String userEmail = user.getUserEmail();
		String userName = user.getUserName();
		int bookingNO = user.getBookingNO();

		String message = userName+"さん\n\n"
				+"いつもご利用いただきまして\r\n" +
				"誠にありがとうございます\n\n" +
				"即時予約が確定しました。\r\n" +
				"下記予約内容をご確認いただき、そのままご予約の日時にご来店ください。\r\n" +
				"※本メールは配信専用のため、ご返信いただきましても届きません。\n\n"+
				"予約番号: #" + bookingNO +"\n"+
				"来店日時: "+ dateAndTime + "時";

		SendEmailUsingGMailSMTP mailSMTP = new SendEmailUsingGMailSMTP();
		mailSMTP.sendEmail("ご予約が確定いたしました", message,userEmail,userName);
		}

		request.setAttribute("message", num);

		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/UserCalendarCon");
		dispatcher.forward(request, response);

	}

}
