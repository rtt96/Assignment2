<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.DecimalFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 
    Document   : calculate.jsp
    Created on : Mar 11, 2021
    Author     : Raja Talha Tariq 
--%>
<%
DecimalFormat df = new DecimalFormat("#0.00"); //is used latter in code to roundoff to decimal values to 2 places
String la = request.getParameter("lamt"); //fetching loan amount
double loanamount = Double.parseDouble(la.trim());
//out.println(loanamount);
String air = request.getParameter("air"); //fetching annual interest rate
double interestrate = Double.parseDouble(air.trim());
//out.println(interestrate);
interestrate = interestrate / 1200; //converting annual interest rate into decimal value of monthly interest rate
//out.println(interestrate);
String lp = request.getParameter("lp"); //fetching loan period
int loanperiod = Integer.parseInt(lp.trim());
//out.println(loanperiod);
String lpt = request.getParameter("lptype");//fecthing loan period type
int loanperiodtype = Integer.parseInt(lpt.trim());
//checking if loan period is in years or not
if (loanperiodtype == 1) {
	loanperiod = loanperiod * 12;//if it is in years converting it into months
	//out.println(loanperiod);
}
double paymentamount = 0;
double principalamount = 0;
double interestamount = 0;
double outstandingloand = 0;
%>
<head>
<title>Amortization Schedule</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<!--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->

</head>
<body>
	<div class="container">
		<div class="row col-md-8 col-md-offset-1">
			<div class="panel-primary">
				<div class="panel panel-heading text-center">
					<h1>Amortization Schedule</h1>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tr>
							<th class="text-center">Payment<br>No
							</th>
							<th class="text-center">Payment Amount</th>
							<th class="text-center">Principal<br>Amount Paid
							</th>
							<th class="text-center">Interest<br>Amount Paid
							</th>
							<th class="text-center">Loan<br>Outstanding<br>Balance
							</th>

						</tr>
						<%
						for (int i = 1; i <= loanperiod; i++) {
							paymentamount = ((interestrate * loanamount) / (1.0 - (1 / Math.pow(1.0 + interestrate, loanperiod))));//calculating installement
							principalamount = paymentamount / ((Math.pow(1.0 + interestrate, 1.0 + loanperiod - i)));// calculating the principal amount in each installment
							interestamount = paymentamount - principalamount; //calculating the interest amount in each installment
							outstandingloand = (interestamount / interestrate) - principalamount; //calculating outstanding loan after each installment is paid
						%>
						<tr>
							<td class="text-center"><%=i%></td>
							<td class="text-center"><%=df.format(paymentamount)%></td>
							<td class="text-center"><%=df.format(principalamount)%></td>
							<td class="text-center"><%=df.format(interestamount)%></td>
							<td class="text-center"><%=df.format(outstandingloand)%></td>
						</tr>
						<%
						}
						%>
					</table>
				</div>
			</div>
			<div class="panel panel-footer text-center">
				<small>&copy; Amortization Scheduler</small>
			</div>
		</div>
	</div>
</body>
<html></html>