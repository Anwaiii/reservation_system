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
import javax.servlet.http.HttpSession;

import model.reservationDao;

/**
 * Servlet implementation class LastMonthCon
 */
public class LastMonthCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LastMonthCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("LastMonthCon:get()");

		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		int role = (Integer) session.getAttribute("role");
		Calendar calendar = Calendar.getInstance();	 //今のカレンダーを取得
		reservationDao reservationDao = new reservationDao();

		if(request.getParameter("currentMonth") == null || request.getParameter("currentYear") == null) {
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/UserCalendarCon");
			dispatcher.forward(request, response);
		}else {

		int newMonth = Integer.parseInt(request.getParameter("currentMonth")) - 1;
		int currentYear = Integer.parseInt(request.getParameter("currentYear"));	// currentMonthは0からはじまる。

		if(newMonth < 0) {
			currentYear--;
			newMonth = 11;
		}
		// int lastMonth = newMonth - 1;

		calendar.set(currentYear,newMonth+1,1);		//	カレンダーの日付を来月の1日にセットする
		calendar.add(Calendar.DATE,-1);		//	カレンダーの日付を1日前に戻し、本月は何日があるかを求める
    	int maxDay = calendar.get(Calendar.DATE);	//	結果をmaxDayに代入する

    	ArrayList<String> reservationResult = reservationDao.printUserCalendar(currentYear, newMonth, maxDay);

    	request.setAttribute("currentYear", currentYear);
    	request.setAttribute("currentMonth", newMonth);
    	request.setAttribute("reservationResult", reservationResult);

    	if(role == 1) {
    		ServletContext app =this.getServletContext();
    		RequestDispatcher dispatcher =  app.getRequestDispatcher("/userCalendar.jsp");
    		dispatcher.forward(request, response);
    		}else {
    			ServletContext app =this.getServletContext();
    			RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminCalendar.jsp");
    			dispatcher.forward(request, response);
    		}

		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
