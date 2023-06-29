package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.reservationBean;
import model.reservationDao;

/**
 * Servlet implementation class UserReservationUpdateCon
 */
public class UserReservationUpdateCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserReservationUpdateCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UserReservationUpdateCon:get()");

		// dateDetail書式 = 'YYYY-MM-DD HH24',例:2023-06-01 11
		String reservationDate = request.getParameter("reservationDate");
		if(reservationDate == null) {
			reservationDate = (String) request.getAttribute("reservationDate");
			request.setAttribute("message", -1);
		}

		reservationDao reservationDao = new reservationDao();
		reservationBean userInfo = new reservationBean();

		String[] dateAndTime = reservationDate.split(" ");
		userInfo = reservationDao.printReservationInfo(reservationDate);

		request.setAttribute("userInfo", userInfo);
		request.setAttribute("dateAndTime", dateAndTime);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/userReservationUpdate.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UserReservationUpdateCon:post()");

		String userID = request.getParameter("userID");
		reservationDao reservationDao = new reservationDao();
		int num = 0;
		// date = YYYY/MM/DD HH24
		String beforeDateTime = request.getParameter("beforeDateTime");
		String date = request.getParameter("date");
		String newTimeRange = request.getParameter("timeRange");
		String afterDateTime = date + " " + newTimeRange;

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH");
		Calendar afterDateCalendar = Calendar.getInstance();
		Calendar now = Calendar.getInstance();
		try {
			afterDateCalendar.setTime(formatter.parse(afterDateTime));
		} catch (ParseException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

		if(afterDateCalendar.after(now)) {
			 num = reservationDao.updateReservation(afterDateTime, beforeDateTime);
			if(num == 1) {
				num = 2;   // 更新成功、1は既に使われているので、2に変える
			}else {
				num = -1; // 更新失敗
			}
		}else {
			request.setAttribute("reservationDate", beforeDateTime);
			doGet(request, response);
		}

		System.out.println("UserReservationUpdateCon-num:"+num);
		request.setAttribute("userID", userID);
		request.setAttribute("message", num);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/UserAllReservationCon");
		dispatcher.forward(request, response);
	}

}
