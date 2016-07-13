<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<footer class="footer rw">
		<div class="footer_top Light12 grey2">
			<div class="container">
				<!--<div class="col_1">
					<h3></h3>
					
 					<div style="margin-left: 22px; color: #fff !important;" class="fb-like" data-href="https://www.facebook.com/UniHyr-491301114398011/" data-layout="button_count" data-action="like" data-show-faces="true" data-share="true"></div>
				</div>
 -->
				 <div class="col_2" style="text-align: center;margin-left: 0px;">
					<h3>Contact Us</h3>

					<div class="news rw">
						<ul style="font-size: 12px;">
							<li>
					<form:form action="requestfordemo" method="post"  commandName="contactusform">
					<form:select  class="col_4 contactfooter" path="usertype">
				<form:option value="emp">I am Employer</form:option>
				<form:option value="cons">I am Consultant</form:option>
				</form:select>
				<br>
				<form:input required="required" path="name" type="text" class="col_4 contactfooter" placeholder="Name*" />
				<form:input required="required" path="email"  type="text" class="col_4 contactfooter" placeholder="Email*" />
				<form:input required="required" path="company" type="text" class="col_4 contactfooter" placeholder="Company*" />
				<form:input required="required" path="phone" type="text" class="col_4 contactfooter" placeholder="Phone Number*" /> 	
				
				<br>
				<input type="submit"   class="col_4 contactfooter" value="Submit Request" style="margin-bottom: 15px;margin-left:-1px;
margin-right: 0px !important;
background: black none repeat scroll 0% 0%;
color: white;
overflow: hidden;
font-size: 14px;border: 1px solid black;" />
				
				</form:form>
								
							</li>
						</ul>
					</div>
				</div> 
				<div class="col_3">
					
					<div class="rw m_b_10 Light12 grey2" style="font-size: 11px;">
						<!-- <div class="adrs_b_1 Lineheight1">
							Unit 5/62 -64 West Ave<br /> Edinburgh Parks SA 5111<br /> PO
							Box 3023<br /> Elizabeth East SA 5112
						</div> -->

						<div class="adrs_b_2"><h3>Reach Us</h3>
							<p>
								<img src="images/ic_3.jpg" alt="img"> 92 8283 3477
							</p>
							<p>
								<img src="images/ic_4.jpg" alt="img"> 011 283 3577
							</p>
							<p>
								<img src="images/ic_5.jpg" alt="img"> unihyr@gmail.com
							</p>
							
					</div>
				</div>
			</div>
		</div>
		<div class="footer_botm Align_cent Light12 grey3">
			<div class="container" style="background-color: #1f1e1e;font-size: 12px;width: 400px;">
				<div style="float: left;line-height: 44px;">
				<a href="termsOfService">Terms of Use</a> | <a href="privacyPolicy">Privacy Policy</a> 
				
			<!-- 			|	<a	href="">Sitemap</a> | <a href="">Work with Us</a> -->
			</div>
			<div style="float: left;line-height:52px;">
						<a  style="margin:8px;" href="https://www.facebook.com/UniHyr-491301114398011/" target="_blank"> 
						<img style="width:8px;" src="images/fb.png" title="facebook" /></a> 
						<a  style="margin:8px;"  href="https://twitter.com/unihyr" target="_blank"> 
						<img style="width:15px;"  src="images/twitter.png" title="twitter" /></a> 
						<a  style="margin:8px;"  target="_blank" href="https://in.linkedin.com/in/unihyr-admin-5aab60122"> 
						<img style="width:14px;"  src="images/linkedin.png" title="linkedin" /></a>
			</div>
			</div> 
			</div>
	</footer>
	<div
		style=" cursor: pointer;
		position:fixed;bottom:10px;right: 10px;z-index:100;"
		id="movetotop">
<img style="height: 40px;" alt="Top" src="images/movetotop.png">
</div>

	<script type="text/javascript" src="js/script.js"></script>

<script type="text/javascript">
$("#movetotop").click(function() {
	  $("html, body").animate({ scrollTop: 0 }, "slow");
	  return false;
	});

</script>


</body>
</html>