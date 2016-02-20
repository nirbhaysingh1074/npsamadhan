<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.List"%>
<%

	List<CandidateProfile> profileList = (List<CandidateProfile>) request.getAttribute("profileList");
%>

<div class="filter">
              <div class="col-md-7"><span>Showing 1 - 10 of 22</span> </div>
              <div class="col-md-5">
                <ul class="page_nav">
                  <li class="active"><a href="">1</a></li>
                  <li><a href=""></a></li>
                  <li><a href="">22</a></li>
                  <li><a href=""><img alt="img" src="images/ic_3.png"></a></li>
                </ul>
              </div>
            </div>
            <table width="100%" border="0" class="new_tabl">
              <tr>
                <th>Basic Information</th>
                <th>&nbsp;</th>
                <th>Status</th>
                <th>&nbsp;</th>
              </tr>
              <%for(CandidateProfile profile:profileList){ %>
              
              <tr>
                <td><h3><%=profile.getName() %></h3>
                  <p><%=profile.getContact() %>, <br>
                    <%=profile.getCurrentRole() %>, <%=profile.getCurrentOrganization() %><br>
                    BE, MBA<br>
                    Salary: <%=profile.getCurrentCTC() %>lacs</p></td>
                <td><p>Relocation: <%=profile.getWillingToRelocate() %> - Hyd</p>
                  <p>Expectation: 20%(negotiable)</p>
                  <p>NP: <%=profile.getNoticePeriod() %> months</p></td>
                <td><a href=""><img src="images/ic_17.png" alt="img" align="top"></a> Shortlist/Inprogress</td>
                <td><p><a href="" class="btn search_btn">View Applicant</a></p>
              </tr>
              
              <%} %>
              
              
            </table>
            <div class="block tab_btm">
              <div class="pagination">
                <ul>
                  <li><a href="">Prev</a></li>
                  <li class="active"><a href="">1</a></li>
                  <li><a href="">2</a></li>
                  <li><a href="">3</a></li>
                  <li><a href="">4</a></li>
                  <li><a href="">5</a></li>
                  <li><a href="">6</a></li>
                  <li><a href="">7</a></li>
                  <li><a href="">8</a></li>
                  <li><a href="">9</a></li>
                  <li><a href="">10</a></li>
                  <li><a href="">Next</a></li>
                </ul>
              </div>
              <div class="sort_by"> <span>Order by</span>
                <select>
                  <option>&nbsp;</option>
                </select>
              </div>
            </div>