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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
