<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title></title>

<style type="text/css">
#fonts, #fontss, #fontss2, #fontss3 {
	font-size: 1.5em;
	color: black;
}
.sel{
width: 100px;
height: 30px;
float: left;
margin-right: 20px;
}
.sel2{
width: 70px;
height: 30px;
float: left;
margin-right: 20px;
}
</style>
 <script type="text/javascript">
	$(function() {
		$(document).on("change", "#carname", function() {

			var writer2 = "";
			writer2 = $(this).val();
			/* alert(writer2);	 */
			$("#tex2").html(writer2);
		});
	});
	$(function() {
		$(document).on("change", ".sel", function() {

			var writer2 = "";
			writer2 += $("#date").val();
			writer2 += $("#date2").val();
			writer2 += $("#date3").val();
			/* alert(writer2);	 */
			$("#tex1").html(writer2);
		});
	});
	
	$(function() {
		$(document).on("change", ".sel2", function() {

			var timeee= "";
			var a = "0";
			var b = ":"
			timeee += $("#time").val();
//			timeee += a;
			timeee += $("#time1").val();
			timeee += b;
			timeee += $("#time2").val();
			/* alert(writer2);	 */
			$("#tex3").html(timeee);
		});
	});
	

</script>
</head>
<%
String email = (String) session.getAttribute("myid");
LoginDao dao = new LoginDao();
LoginDto dto = dao.getUserInfo(2, email);
System.out.println(dto.getEmail());

ProductDao pdao = new ProductDao();
/* 	String writer = request.getParameter("writer"); */

List<ProductDto> list = pdao.getAllDatas();
%>
<body>


	<!-- <section class="ftco-section"> -->
		<div class="container">
			<div class="row justify-content-center">
	<form action="reservation/reservationaction.jsp" method="post" class="billing-form"
		 onsubmit="return confirm('예약하시겠습니까?');">
				<div class="col-xl-10 ftco-animate">
					<h3 class="mb-4 billing-heading">Reservation</h3>
					<div class="row align-items-end">
						<div class="col-md-6">
							<div class="form-group">
								<label for="firstname">Name</label> 
								<input type="text"
									class="form-control" name="name" required="required"
									placeholder="이름을 입력하세요" value="<%=dto.getName()%>">
							</div>
						</div>
						<div class="w-100"></div>
						<div class="col-md-12">
							<div class="form-group">
								<label for="country">Car Name</label>
								<div class="select-wrap">
									<div class="icon">
										<span class="ion-ios-arrow-down"></span>
									</div>
									<select name="carname" id="carname" required="required"
									 class="form-control" >
										<%
										for (ProductDto pdto : list) {
										%>
										<option value="<%=pdto.getSubject()%>"><%=pdto.getSubject()%></option>
										<%
										}
										%>
									</select>
								</div>
							</div>
						</div>

						<div class="w-100"></div>
						<div class="col-md-12">
							<div class="form-group">
								<label for="country">Date</label>
								<div class="select-wrap">
									<div class="icon">
										<span class="ion-ios-arrow-down"></span>
									</div>
									<select name="date" id="date" required="required"
									 class="form-control sel">
										<option value="2021년">2021년</option>
									</select>
									<select name="date2" id="date2" required="required"
									 class="form-control sel">
										<%
										int no=10;
										for (int i=9;i<=10;i++) {
											no++;
										%>
										<option value="<%=no %>월"><%=no %>월</option>
										<%
										}
										%>
									</select>
									<select name="date3" id="date3" required="required"
									 class="form-control sel">
										<%
										for (int j=1;j<=30;j++) {
										%>
										<option value="<%=j %>일"><%=j %>일</option>
										<%
										}
										%>
									</select>
 									<select name="time" id="time" required="required"
									 class="form-control sel2">
										
										<option value="PM">PM</option>
										<option value="AM">AM</option>
										
									</select> 
									<select name="time1" id="time1" required="required"
									 class="form-control sel2">
										<%
										int n = 0;
										for (int j=0;j<=11;j++) {
											n++;
										%>
										<option value="<%=n %>"><%=n %>시</option>
										<%
										}
										%>
									</select>
									<select name="time2" id="time2" required="required"
									 class="form-control sel2">
										<option value="30">30분</option>
										<option value="00">00분</option>
									</select>
								</div>
							</div>
						</div>

						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="streetaddress">Street Address</label> 
								<input
									type="text" class="form-control" value="<%=dto.getAddr1()%>"
									placeholder="House number and street name" name="addr1"
									required style="color: black;">
							</div>
						</div>
						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="towncity">Town / City</label> 
								<input type="text"
									class="form-control" value="<%=dto.getAddr2()%>"
									placeholder="" name="addr2" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="postcodezip">Postcode / ZIP *</label> 
								<input
									type="text" class="form-control"
									value="<%=dto.getPostcode()%>" placeholder="" name="postcode"
									required="required">
							</div>
						</div>
						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="phone">Phone</label> 
								<input type="text"
									class="form-control"
									value="<%=dto.getMobile1()%>-<%=dto.getMobile2()%>-<%=dto.getMobile3()%>"
									placeholder="" name="phone" required="required">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="emailaddress">Email Address</label> 
								<input
									type="text" class="form-control" value="<%=dto.getEmail()%>"
									placeholder="" name="email" required="required">
							</div>
						</div>

						<div class="w-100"></div>
						<div class="col-md-6">
							<div class="form-group">
								<input type="hidden" class="form-control"
									value="<%=dto.getPw()%>" placeholder="" name="pw" required="required">
							</div>
						</div>
						<div class="w-100"></div>

					</div>
					<!-- END -->


					<div class="row mt-5 pt-3 d-flex">
						<div class="col-md-6 d-flex">
							<div class="cart-detail cart-total p-3 p-md-4">
								<h3 class="billing-heading mb-4">Total</h3>
								<p class="d-flex" name= "datteee">
									<span>Date</span> <span id="tex1" name = "ddadfds" ></span>
								</p>
								<p class="d-flex">
									<span>Time</span> <span id="tex3" name = "timeee" ></span>
								</p>
								<p class="d-flex">
									<span>Model: </span> <span id="tex2" name="namemd" ></span>
								</p>
								<hr>
								<p class="d-flex total-price">
									<span>예약하시겠습니까?</span> <span> </span>
								</p>
								<p>
									<button type="submit" id="btn1" class="btn btn-primary py-3 px-4" 
									>Make
										An Appointment</button>
								</p>
							</div>
						</div>

					</div>
				</div>
				<!-- .col-md-8 -->
 </form>
			</div>
		</div>
		<!--    </section> -->


	<script src="js/jquery.min.js"></script>
	<script src="js/jquery-migrate-3.0.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/jquery.stellar.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/jquery.animateNumber.min.js"></script>
	<script src="js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="js/google-map.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>
	<script src="js/main.js"></script>

</body>
</html>