<!DOCTYPE html>

<html dir="ltr" lang="en-US">
<head>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras"
	prefix="tilesx"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<link href="css/main.css" type="text/css" media="all" rel="stylesheet" />
<link href="css/fonts.css" type="text/css" media="all" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.IE.js"></script>
<script type="text/javascript" src="js/consult_js.js"></script>

</head>
<body class="loading">
	<tilesx:useAttribute name="currentpage" />
	<header>
		<div class="header">
			<div class="container">
				<div class="logo">
					<a href="consdashboard"><img src="images/logo.png" alt="Logo"></a>

					<div class="last_login">
						<p>Last Login: May 20, 2015 at 09:39 AM</p>
					</div>
				</div>

				<div class="header_right">
					<div class="brnad_logo">
						<span>Welcome</span> <img src="images/logo_2.png" alt="Logo">
					</div>
					<div class="address_info">
						<p>
							<span>Account Details:</span> (Update Account Info)<br>DLF
							Phase V, <br>Gurgaon
						</p>
					</div>
					<div class="contact_our">
						<p>Key Contact Persons:</p>
						<p>
							<span>1. Mr. ABC -</span>+91 9xxxxxxxxx (abc@xxxxx)
						</p>
						<p>
							<span>2. Mr. DEF -</span> +91 8xxxxxxxxx (def@xxxxxx)
						</p>
					</div>
				</div>
			</div>
		</div>
		<nav>
			<div class="container">
				<a href="javascript:void(0);"
					onClick="$('.toggle_menu').slideToggle();" class="toggle-icon"></a>
				<ul class="toggle_menu">
					<li class="${currentpage == 'consdashboard' ? 'active' : ''}"><a href="consdashboard">Home</a></li>
					<li class="${currentpage == 'consnewposts' ? 'active' : ''}" class="active"><a href="consnewposts">New Post</a></li>
					<li class="${currentpage == 'cons_your_positions' ? 'active' : ''}"><a href="cons_your_positions">Your Positions</a></li>
					<li class="${currentpage == 'cons_billingdetails' ? 'active' : ''}"><a href="cons_billingdetails">Billing Details</a></li>
					<li class="${currentpage == 'cons_profilecenter' ? 'active' : ''}"><a href="cons_profilecenter">Profiles Center</a></li>
				</ul>
			</div>
		</nav>
	</header>

</body>
</html>
