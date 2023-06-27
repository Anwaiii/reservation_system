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
 * Servlet implementation class AdminUpdateUserCon
 */
public class AdminUpdateUserCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminUpdateUserCon() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("AdminUpdateUserCon:get()");

		reservationDao reservationDao = new reservationDao();

		String userID= request.getParameter("userID");
		request.setAttribute("userID", userID);

		 // userIDが既に存在している
		if(reservationDao.checkUserID(userID).equals("")) {
			request.setAttribute("message", 0);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminUpdateUser.jsp");
			dispatcher.forward(request, response);
		}else {

			//	新規登録ができた
			reservationBean userInfo = reservationDao.getUserInfo(userID);
			request.setAttribute("userInfo",userInfo);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminUpdateUser.jsp");
			dispatcher.forward(request, response);
		}



	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("AdminUpdateUserCon:post()");

		reservationDao reservationDao = new reservationDao();
		String userID= request.getParameter("userID");
		String userName = request.getParameter("userName");
		String userAddress = request.getParameter("userAddress");
		String userPhoneNumber = request.getParameter("userPhoneNumber");
		String userEmail = request.getParameter("userEmail");

		request.setAttribute("userID", userID);
		int num = reservationDao.updateUser(userID, userName, userAddress, userPhoneNumber, userEmail);

		if(num == 0) {
			// num = 0の場合は更新失敗、更新失敗のメッセージを-1にする
			request.setAttribute("message",-1);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminUpdateUser.jsp");
			dispatcher.forward(request, response);
		}else {
			// numは0でない場合は更新成功、更新成功のメッセージを2にする
		request.setAttribute("message",2);
		ServletContext app =this.getServletContext();
		RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminUpdateUser.jsp");
		dispatcher.forward(request, response);
		}
	}

}
