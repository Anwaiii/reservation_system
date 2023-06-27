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
 * Servlet implementation class AdminCreateUserCon
 */
public class AdminCreateUserCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminCreateUserCon() {
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

		String userID = request.getParameter("userID");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");
		String userName = request.getParameter("userName");
		String userAddress = request.getParameter("userAddress");
		String userPhoneNumber = request.getParameter("userPhoneNumber");
		String userEmail = request.getParameter("userEmail");

		reservationDao reservationDao = new reservationDao();

		String isExistedID = "";
		int num = 0;

		//	パスワードが一致しているかを確認し、一致したらuserIDが既に存在しているを確認する
		if(!password.equals(passwordConfirm)) {
			//	パスワードが一致していない
			num=-1;
		}else {
			isExistedID = reservationDao.checkUserID(userID);
			if(isExistedID.equals(userID)) {
				//	userIDが既に存在している
				num=-2;
			}
		}


		if(num == 0) {
			num = reservationDao.newUserRegister(userID,password,userName,userAddress,userPhoneNumber,userEmail);
		}

		if(num <= 0) {

			reservationBean newUser = new reservationBean();
			newUser.setUserID(userID);
			newUser.setUserName(userName);
			newUser.setUserAddress(userAddress);
			newUser.setUserPhoneNumber(userPhoneNumber);
			newUser.setUserEmail(userEmail);

			//	num<=0の場合はSignUp.jspに戻り、エラーメッセージが表示される
			request.setAttribute("newUser", newUser);
			request.setAttribute("signUpResult",num);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminCreateUser.jsp");
			dispatcher.forward(request, response);
		}else {
			//	新規登録が成功、Loginページに戻る
			request.setAttribute("signUpResult",num);
			ServletContext app =this.getServletContext();
			RequestDispatcher dispatcher =  app.getRequestDispatcher("/adminCreateUser.jsp");
			dispatcher.forward(request, response);
//			response.sendRedirect("Login.jsp");
		}

	}

}
