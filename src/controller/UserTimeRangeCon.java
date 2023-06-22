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
 * Servlet implementation class userTimeRangeCon
 */
public class UserTimeRangeCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserTimeRangeCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UserTimeRangeCon:get()");

		reservationDao reservationDao = new reservationDao();
		String date = request.getParameter("date");
		ArrayList<String> availableTime = new ArrayList<>();

		availableTime = reservationDao.printAvailableTime(date);

    	request.setAttribute("reservationResult", availableTime);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/userTimeRange.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/userTimeRange.jsp");
		dispatcher.forward(request, response);
	}
}
