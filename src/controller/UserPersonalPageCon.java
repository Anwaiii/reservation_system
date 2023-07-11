package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.reservationBean;
import model.reservationDao;

/**
 * Servlet implementation class UserPersonalPageCon
 */
public class UserPersonalPageCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPersonalPageCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("UserPersonalPageCon:post()");

		reservationDao reservationDao = new reservationDao();
		String userID= request.getParameter("userID");
		String userName = request.getParameter("userName");
		String userAddress = request.getParameter("userAddress");
		String userPhoneNumber = request.getParameter("userPhoneNumber");
		String userEmail = request.getParameter("userEmail");


		int num = reservationDao.updateUser(userID, userName, userAddress, userPhoneNumber, userEmail);

		if(num == 0) {
			// num = 0の場合は更新失敗、更新失敗のメッセージを-1にする
			request.setAttribute("message",-1);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/userPersonalPage.jsp");
			dispatcher.forward(request, response);
		}else {

			reservationBean user = reservationDao.getUserInfo(userID);

			HttpSession session = request.getSession(false);
			session.setAttribute("user", user);
			// numは0でない場合は更新成功、更新成功のメッセージを1にする
		request.setAttribute("message",1);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/userPersonalPage.jsp");
		dispatcher.forward(request, response);
		}
	}

}