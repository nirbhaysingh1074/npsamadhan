<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<title>UniHyr</title>
	
	<link rel="stylesheet" href="css/media.css" media="screen" />
    <link rel="stylesheet" href="css/style.css" media="screen" />
	<link rel="stylesheet" href="css/font-awesome.css" media="screen"   />
	<link href="css/main.css" type="text/css" media="all" rel="stylesheet" />
	<link href="css/fonts.css" type="text/css" media="all" rel="stylesheet" />
	<style type="text/css">
		input[type="text"], input[type="password"], input[type="tel"], input[type="search"], input[type="email"], textarea, select 
		{
			margin-top: 10px;
		}
	</style>
</head>
<body style="background-image: url('images/bg-image.png')">
	<section>
		<div class="container" style="background: inherit;">
			<div class="login-form"  style="max-width: 700px">
				<div class="login-header" >
					<a href="index"><img alt="" src="images/logo.png"></a>
					<button onclick="createpdf()">Create Pdf</button>
					<a href="home"><span class="close" title="Home Page">X</span></a>
				</div>
				<div class="login-wrap bottom-padding" id="genpdf">
						
<!-- 					<img alt="" src="http://localhost:8081/unihyr/images/logo.png">	 -->
					<form class="form-box bottom-padding" method="POST" >
					<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
						<br>
						Helo
						<input type="text" name="abc">
						
						again
					</p>	
					</form>
					<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>	<p >
						Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
					</p>
					<div class="positions_info cons_new_posts">
	  <!--     <div class="filter">
	        
	        <div class="col-md-7 pagi_summary"><span>Showing 0 - 0 of 0</span></div>
	        <div class="col-md-5">
	              <ul class="page_nav unselectable">
			            <li class="disabled"><a>First</a></li>
			            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
		            	<li class="active current_page"><a>1</a></li>
	      				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li class="disabled"><a>Last</a></li>
	              </ul>
	            </div>
	      </div> -->
	      <div class="positions_tab">
							<table class="table no-margin" style="font-size: 10px; border: 1px solid gray;" >
								<thead>
									<tr>
										<th align="left">Position</th>
										<th align="left">Client</th>
										<th align="left">Location</th>
										<th align="left">Candidate</th>
										<th align="left">Accepted Date</th>
										<th align="left">Joining Date</th>
										
									</tr>
								</thead>
								<tbody>


									<tr>
										<td>Developer</td>
										<td>Silvereye it solutions</td>
										<td>Lucknow</td>
										<td>Ajay</td>
										<td>19/04/2016</td>
										<td>19/04/2016</td>
										
									</tr>



								</tbody>
							</table>
						</div>
	      <!-- <div class="block tab_btm">
	        <div class="pagination">
	          <ul class="pagi">
		            <li class="disabled"><a>First</a></li>
		            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
	            	<li class="active current_page"><a>1</a></li>
	   				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
		            <li class="disabled"><a>Last</a></li>
	          </ul>
	        </div>
	      
        
	      </div> -->
	      
	      
	    </div>						
				</div>
			</div>
		</div>
	
	</section>


	




<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>


<script type="text/javascript" src="js/jspdf/jspdf.js"></script>

<script type="text/javascript" src="js/jspdf/acroform.js"></script>
<script type="text/javascript" src="js/jspdf/addhtml.js"></script>
<script type="text/javascript" src="js/jspdf/addimage.js"></script>
<script type="text/javascript" src="js/jspdf/annotations.js"></script>
<script type="text/javascript" src="js/jspdf/autoprint.js"></script>
<script type="text/javascript" src="js/jspdf/canvas.js"></script>
<script type="text/javascript" src="js/jspdf/cell.js"></script>
<script type="text/javascript" src="js/jspdf/context2d.js"></script>
<script type="text/javascript" src="js/jspdf/from_html.js"></script>
<script type="text/javascript" src="js/jspdf/javascript.js"></script>
<script type="text/javascript" src="js/jspdf/outline.js"></script>
<script type="text/javascript" src="js/jspdf/png_support.js"></script>
<script type="text/javascript" src="js/jspdf/prevent_scale_to_fit.js"></script>

<script type="text/javascript" src="js/jspdf/split_text_to_size.js"></script>
<script type="text/javascript" src="js/jspdf/standard_fonts_metrics.js"></script>
<script type="text/javascript" src="js/jspdf/svg.js"></script>
<script type="text/javascript" src="js/jspdf/total_pages.js"></script>

<script type="text/javascript" src="js/jspdf/png.js"></script>
<script type="text/javascript" src="js/jspdf/zlib.js"></script>





<script type="text/javascript">
	var doc = new jsPDF();          
	var elementHandler = {
	  /* '#ignorePDF': function (element, renderer) {
	    return true;
	  } */
	};
	doc.setFontSize(7);
	function createpdf()
	{
		var source = window.document.getElementById("genpdf");
		doc.fromHTML(
		    source,
		    15,
		    15,
		    {
		      'width': 180,'font-size':11/* ,'elementHandlers': elementHandler */
		    });
		
		doc.output("dataurlnewwindow");
		
	}
	

</script>




</body>
</html>