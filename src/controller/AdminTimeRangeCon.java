package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.reservationDao;

/**
 * Servlet implementation class AdminTimeRangeCon
 */
public class AdminTimeRangeCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminTimeRangeCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("AdminTimeRangeCon:get()");

		reservationDao reservationDao = new reservationDao();

		// date = YYYY/MM/DD
		String date = request.getParameter("date");

		if(date == null) {
			date = (String) request.getAttribute("date");
			System.out.println("test"+date);
			request.setAttribute("message", (Integer) request.getAttribute("message"));
		}


		ArrayList<String> availableTime = new ArrayList<>();

		// Hour値のリスト。Hourの値は10~16まで。
		availableTime = reservationDao.printAvailableTime(date);

		request.setAttribute("date", date);
    	request.setAttribute("reservationResult", availableTime);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminTimeRange.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("AdminTimeRangeCon:post()");

		reservationDao reservationDao = new reservationDao();
		String date = (String) request.getAttribute("date");
		request.setAttribute("message", (Integer) request.getAttribute("message"));

		ArrayList<String> availableTime = new ArrayList<>();

		// Hour値のリスト。Hourの値は10~16まで。
		availableTime = reservationDao.printAvailableTime(date);

		request.setAttribute("date", date);
    	request.setAttribute("reservationResult", availableTime);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminTimeRange.jsp");
		dispatcher.forward(request, response);
	}
}
