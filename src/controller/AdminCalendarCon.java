package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.reservationDao;

/**
 * Servlet implementation class AdminCalendarCon
 */
public class AdminCalendarCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCalendarCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("AdminCalendarCon:get()");

		reservationDao reservationDao = new reservationDao();

		Calendar calendar = Calendar.getInstance();	 //今のカレンダーを取得
		int currentYear = calendar.get(Calendar.YEAR);	// currentMonthは0からはじまる。
		int currentMonth = calendar.get(Calendar.MONTH);
		int nextMonth = currentMonth + 1;
		calendar.set(currentYear,currentMonth,1);      //カレンダーを当月の1日にセットする
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);  //	当月の1日は何曜日かを取得する

		calendar.set(currentYear,nextMonth,1);		//	カレンダーの日付を来月の1日にセットする
		calendar.add(Calendar.DATE,-1);		//	カレンダーの日付を1日前に戻し、本月は何日があるかを求める
    	int maxDay = calendar.get(Calendar.DATE);	//	結果をmaxDayに代入する

    	ArrayList<String> reservationResult = reservationDao.printUserCalendar(currentYear, currentMonth, maxDay);

    	request.setAttribute("reservationResult", reservationResult);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminCalendar.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
