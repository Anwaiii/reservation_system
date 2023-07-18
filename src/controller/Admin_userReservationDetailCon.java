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
 * Servlet implementation class Admin_userReservationDetailCon
 */
public class Admin_userReservationDetailCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_userReservationDetailCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("Admin_userReservationDetailCon:get()");

		// dateDetail書式 = 'YYYY-MM-DD HH24',例:2023-06-01 11
		String dateDetail = request.getParameter("reservationDetail");
		if(dateDetail == null) {
			dateDetail = (String) request.getAttribute("reservationDetail");
			request.setAttribute("message", -1);
		}

		reservationDao reservationDao = new reservationDao();
		reservationBean userInfo = new reservationBean();

		String[] dateAndTime = dateDetail.split(" ");
		userInfo = reservationDao.printReservationInfo(dateDetail);

		request.setAttribute("userInfo", userInfo);
		request.setAttribute("dateAndTime", dateAndTime);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/admin_userReservationDetail.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("Admin_userReservationDetailCon:post()");

		reservationDao reservationDao = new reservationDao();
		int num = 0;
		int diff = 0;

		// date = YYYY/MM/DD HH24
		String beforeDateTime = request.getParameter("beforeDateTime");
		String date = request.getParameter("date");
		String newTimeRange = request.getParameter("timeRange");
		String afterDateTime = date + " " + newTimeRange;
		System.out.println("before:"+beforeDateTime);
		System.out.println("new:"+afterDateTime);

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH");
		Calendar afterDateCalendar = Calendar.getInstance();
		Calendar now = Calendar.getInstance();
		Calendar is3Months = Calendar.getInstance();
		is3Months.add(Calendar.DATE,60);

		is3Months.set(is3Months.get(Calendar.YEAR), is3Months.get(Calendar.MONTH)+1,1,23,59,59);
		is3Months.add(Calendar.DATE,-1);



		if(reservationDao.checkdateTimeIfExisted(beforeDateTime) == -99) {
			num = -99;
		}else {


		try {
			afterDateCalendar.setTime(formatter.parse(afterDateTime));
			diff = afterDateCalendar.compareTo(is3Months);
		} catch (ParseException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}

		if(afterDateCalendar.after(now) && diff <= 0) {
			 num = reservationDao.updateReservation(afterDateTime, beforeDateTime);
			if(num == 1) {
				num = 2;   // 更新成功、1は既に使われているので、2に変える
			}
		}else {
			request.setAttribute("reservationDetail", beforeDateTime);
			doGet(request, response);
			}
		}


		request.setAttribute("date", beforeDateTime.split(" ")[0]);
		request.setAttribute("message", num);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/AdminTimeRangeCon");
		dispatcher.forward(request, response);

	}

}
