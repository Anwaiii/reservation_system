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
 * Servlet implementation class UserAllReservationCon
 */
public class UserAllReservationCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserAllReservationCon() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UserAllReservationCon:get()");

		reservationDao reservationDao = new reservationDao();
		String userID = request.getParameter("userID");
		ArrayList<String> allReservation = new ArrayList<>();

		allReservation = reservationDao.printUserAllReservation(userID);

		request.setAttribute("reservationResult", allReservation);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/userAllReservation.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UserAllReservationCon:post()");

		reservationDao reservationDao = new reservationDao();
		String userID = request.getParameter("userID");
		String date = request.getParameter("reservationDate");
		ArrayList<String> allReservation = new ArrayList<>();

		System.out.println(userID);
		System.out.println(date);
		if(date == null) {
			request.setAttribute("message", (Integer) request.getAttribute("message"));
			allReservation = reservationDao.printUserAllReservation(userID);
			request.setAttribute("reservationResult", allReservation);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/userAllReservation.jsp");
			dispatcher.forward(request, response);
		}





		int num = reservationDao.cancelReservation(date);

		if(num == 1) {
			request.setAttribute("message", num);
			doGet(request, response);
		}else {
			allReservation = reservationDao.printUserAllReservation(userID);
			request.setAttribute("message", num);
			request.setAttribute("reservationResult", allReservation);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/userAllReservation.jsp");
			dispatcher.forward(request, response);
		}
	}


}
